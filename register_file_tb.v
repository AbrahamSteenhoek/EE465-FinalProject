`include "register_file.v"

`timescale 1ns/1ns

module register_file_tb;

reg reset;
reg [11:0] tn;
reg sample;
reg clk;
wire tsum_actual;
wire tsum_square_actual;

always #10 clk <= clk;

initial
begin
    clk = 0;
    reset = 1;
    sample = 0;
    #40
    reset = 0;
    sample = 1;

end

register_file reg_file(
    .RESET(reset),
    .TN(tn),
    .SAMPLE(sample), 
    .CLK(clk), 
    .Tsum(tsum_actual), 
    .Tsum_square(tsum_square_actual)
    );

endmodule