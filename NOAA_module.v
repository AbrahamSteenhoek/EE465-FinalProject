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

reg [3:0] N;
wire [3:0] N_for_calc;
reg [3:0] N_hold;

wire [15:0] Tsum;
reg [15:0] Tsum_hold;
wire [15:0] Tsum_calc;

wire [27:0] Tsum_square;
reg [27:0] Tsum_square_hold;
wire [27:0] Tsum_square_calc;

reg mode1;
reg mode2;
reg [1:0] calc_state;

reg [11:0] sigma_hat;
wire [11:0] sigma_hat_for_calc;

wire [32:0] numerator;
reg [32:0] numerator_store;
wire [21:0] denominator;
reg [21:0] denominator_store;

wire [13:0] quotient;
wire [11:0] quotient_rounded;

// This is an idea to save switching for these regs, idk if it'll work
assign N_for_calc = mode1 ? N : N_hold;
assign Tsum_calc = ( mode1 ) ? Tsum : Tsum_hold;
assign Tsum_square_calc = ( mode1 ) ? Tsum_square : Tsum_square_hold;

assign quotient = numerator_store / denominator_store;
assign quotient_rounded[11:0] = quotient[1]?(quotient[13:2]+1):quotient[13:2]; // round up if needed
assign sigma_hat_for_calc = ( mode1 && mode2 ) ? quotient_rounded : sigma_hat;

always @ ( posedge CLK )
begin
    if ( RESET )
    begin
        SAMPLE <= 1'b0;
        DONE <= 1'b0;
        sigma_hat <= 12'b010000000000; // 32deg F
        AVG_SD <= 0;
        N <= 0;

        calc_state <= 0;

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
            if (N < 14) begin
                N <= N + 1;
            end

            Tsum_hold <= Tsum_calc;
            Tsum_square_hold <= Tsum_calc;

            N_hold <= N_for_calc;

            mode1 <= MODE;
            calc_state[0] <= 1;
        end
        // else
        //     calc_state[0] <= 0;

        if ( calc_state[0] ) // data available in first stage
        begin
            numerator_store <= ( mode1 ) ? ( numerator << 2 ) : ( Tsum << 2 ); // not sure why I have to multiply the numerator by 4, but whatever
            denominator_store <= ( mode1 ) ? ( denominator ) : ( N );

            calc_state[1] <= 1;
            mode2 <= mode1;
        end
        // else
        //     calc_state[1] <= 0; // no new data in 2nd stage

        if ( calc_state[1] ) // data available in the second stage
        begin
            if ( mode2 == 1'b1 ) // update sigma_hat if we've calculated a new stddev
                sigma_hat <= quotient_rounded;

            AVG_SD <= quotient_rounded; // perform the division
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
    .Tsum_square( Tsum_square ),
    .N( N )
);

calculate_numerator_denominator calc_num(
    .N( N_for_calc ),
    .sigma_hat( sigma_hat_for_calc ),
    .Tsum( Tsum_calc ),
    .Tsum_square( Tsum_square_calc ),
    .numerator( numerator ),
    .denominator( denominator )
);

endmodule