`include "register_file.v"
`include "calculate_numerator_denominator.v"

`timescale 1ns/1ns

module NOAA_module(
    input RESET,
    input MODE,
    input [11:0] TN,
    input CLK,
    output reg SAMPLE,
    output reg DONE, // Need to put calc_num and calc_denom on the clk to set DONE appropriately (maybe)
    output reg [11:0] AVG_SD
);

wire [15:0] Tsum;
wire [3:0] N;

reg [11:0] sigma_hat;
wire [32:0] numerator;
wire [21:0] denominator;

// wire [11:0] final_quotient_rounded;
// assign final_quotient_rounded = final_quotient[1] ? ( quotient[13:2] + 1 ) : quotient[13:2];


reg calc_state1;
reg calc_state2;

reg mode1;
reg mode2;

wire [3:0] N_for_calc;
reg [3:0] N_hold;
assign N_for_calc = mode1 ? N : N_hold;

reg [15:0] Tsum_hold;
reg [15:0] Tsum_for_calc;

wire [11:0] sigma_hat_for_calc;
reg [32:0] numerator_store;
reg [21:0] denominator_store;

wire [13:0] quotient;
// wire [13:0] final_quotient;
assign quotient = numerator_store / denominator_store;
// assign final_quotient = quotient[1]?(quotient[13:2]+1):quotient[13:2]; //performs rounding of quotient

assign sigma_hat_for_calc = ( mode1 && mode2 ) ? quotient : sigma_hat;

always @ ( posedge CLK )
begin
    if ( RESET )
    begin
        SAMPLE <= 1'b0;
        DONE <= 1'b0;
        sigma_hat <= 12'b010000000000; // 32deg F
        AVG_SD <= 0;
        // N <= 0;
        // MODE <= 0;
        // N_for_calc <= 0;
        // sigma_hat_for_calc <= 0;
        Tsum_for_calc <= 0;

        calc_state <= 0;
        calc_state0 <= 0;
        calc_state1 <= 0;

        numerator_store <= 0;
        denominator_store <= 0;
        mode1 <= 0;
        mode2 <= 0;
    end
    else
    begin
        SAMPLE <= 1'b1; // should be able to sample every CLK cycle
        if ( SAMPLE )
        begin
            if (N < 4'b1110) begin
                N <= N + 1;
            end
            Tsum_hold <= Tsum;
            Tsum_for_calc <= Tsum_hold;

            N_hold <= N_for_calc;

            mode1 <= MODE;
            calc_state1 <= 1; // we have received an input in the first calculating stage
        end
        else
            calc_state1 = 0; // no new input in the first calculating stage

        if ( calc_state1 ) // data available in first stage
        begin
            // process data needed for second stage

            numerator_store <= (mode1)? ( numerator << 1 ) : ( Tsum << 2 );
            denominator_store <= (mode1) ? (denominator) : (N);

            calc_state2 <= 1;
            mode2 <= mode1;
        end
        else
            calc_state2 <= 0; // no new data in 2nd stage

        if ( calc_state2 ) // data available in the second stage
        begin
            AVG_SD <= quotient; // perform the division

            if ( mode2 == 1'b1 ) // update sigma_hat if we've calculated a new stddev
                sigma_hat <= quotient;

            DONE <= 1;
        end
        else
            DONE <= 0; // no new output ready yet
    end
end

register_file reg_file(
    .RESET( RESET ),
    .TN( TN ),
    .SAMPLE( SAMPLE ),
    .CLK( CLK ),
    .Tsum( Tsum ),
    .N( N )
);

calculate_numerator_denominator calc_num(
    .N( N_for_calc ),
    .sigma_hat( sigma_hat_for_calc ),
    .MODE( mode2 ),
    .Tsum( Tsum_for_calc ),
    .numerator( numerator ),
    .denominator( denominator )
);

endmodule