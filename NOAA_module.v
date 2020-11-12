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
    output [11:0] AVG_SD
);

wire [13:0] Tsum;
wire [3:0] N;

reg [11:0] sigma_hat;
wire [32:0] numerator;
wire [21:0] denominator;

initial
begin
    sigma_hat <= 12'b010000000000; // 32deg F
end

always @ ( posedge CLK )
begin
    if ( RESET )
    begin
        SAMPLE <= 1'b0;
        DONE <= 1'b0;
        sigma_hat <= 12'b010000000000; // 32deg F
    end
    else
    begin
        SAMPLE <= 1'b1; // should be able to sample every CLK cycle
        // DONE <= 1; ???
        if ( MODE == 1'b1 ) // update sigma_hat if we've calculated a new stddev
        begin
            sigma_hat <= AVG_SD;
        end
    end
end

assign AVG_SD = numerator / denominator; // do we need to do rounding?

register_file reg_file(
    .RESET( RESET ),
    .TN( TN ),
    .SAMPLE( SAMPLE ),
    .CLK( CLK ),
    .Tsum( Tsum ),
    .N( N )
);

calculate_numerator_denominator calc_num(
    .N( N ),
    .sigma_hat( sigma_hat ),
    .MODE( MODE ),
    .Tsum( Tsum ),
    .numerator( numerator ),
    .denominator( denominator )
);

endmodule