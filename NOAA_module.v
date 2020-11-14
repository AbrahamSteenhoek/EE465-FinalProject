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

reg mode1;
reg mode2;
reg MODE_for_calc;
reg [3:0] N_for_calc;
reg [3:0] N_temp;
wire [11:0] sigma_hat_for_calc = ( mode1 && mode2 ) ? AVG_SD : sigma_hat;
reg [15:0] Tsum_for_calc;

reg [32:0] numerator_store;
reg [21:0] denominator_store;
wire [13:0] final_quotient;
assign final_quotient = numerator_store / denominator_store;
wire [11:0] final_quotient_rounded;
assign final_quotient_rounded = final_quotient[1] ? ( final_quotient[13:2] + 1 ) : final_quotient[13:2];


always @ ( posedge CLK )
begin
    if ( RESET )
    begin
        SAMPLE <= 1'b0;
        DONE <= 1'b0;
        sigma_hat <= 12'b010000000000; // 32deg F
        // MODE <= 0;
        MODE_for_calc <= 0;
        N_for_calc <= 0;
        // sigma_hat_for_calc <= 0;
        Tsum_for_calc <= 0;
        // calc_state <= 0;
    end
    else
    begin
        SAMPLE <= 1'b1; // should be able to sample every CLK cycle
        // MODE_for_calc <= MODE;
        N_temp <= N;
        N_for_calc <= N_temp;
        Tsum_for_calc <= Tsum;

        mode1 <= MODE;
        mode2 <= mode1;

        numerator_store <= numerator;
        denominator_store <= denominator;

        AVG_SD <= final_quotient_rounded;
        // DONE <= 1; ???
        if ( mode2 == 1'b1 ) // update sigma_hat if we've calculated a new stddev
        begin
            // sigma_hat_for_calc <= sigma_hat;

            sigma_hat <= final_quotient_rounded;
            DONE <= 1;
        end
    end
end

// reg instead?
// assign AVG_SD = numerator / denominator; // do we need to do rounding?

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
    .sigma_hat( sigma_hat ),
    .MODE( mode2 ),
    .Tsum( Tsum_for_calc ),
    .numerator( numerator ),
    .denominator( denominator )
);

endmodule