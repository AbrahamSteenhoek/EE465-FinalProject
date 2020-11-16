`timescale 1ns/1ns

module register_file_tb;

reg reset;
reg [11:0] ts;
reg sample;
reg clk;
reg N;
wire tsum_actual;
wire tsum_square_actual;



register_file reg_file(
    .RESET, 
    .TN, 
    .SAMPLE, 
    .CLK, 
    .Tsum, 
    .Tsum_square, 
    .N
    );

endmodule