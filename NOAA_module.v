`include "register_file.v"
`include "calculate_denominator.v"
`include "calculate_numerator.v"

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

register_file reg_file(
    .RESET( RESET ),
    .TN( TN ),
    .CLK( CLK ),
    .Tsum( Tsum ),
    .N( N )
);

calculate_denominator calc_denom(
    .N( N ),
    .sigma_hat( sigma_hat ),
    .MODE( MODE ),
    .denominator( denominator )
);

calculate_numerator calc_num(
    .N( N ),
    .sigma_hat( sigma_hat ),
    .MODE( MODE ),
    .Tsum( Tsum ),
    .numerator( numerator )
);

always @ ( posedge CLK )
begin
    if ( RESET )
    begin
        SAMPLE <= 0;
        DONE <= 0;
        sigma_hat <= 12'b010000000000; // 32deg F
    end
end

endmodule