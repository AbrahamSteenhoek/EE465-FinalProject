`timescale 1ns/1ps

module NOAA_Module(RESET, MODE, TN, CLK, SAMPLE, DONE, AVG_SD);
input RESET;
input MODE;
input [11:0] TN;
input CLK;

output reg SAMPLE;
output reg DONE;
output reg [11:0] AVG_SD;

reg[11:0] TN1, TN2, TN3, TN4, TN5, TN6, TN7;
reg[11:0] TN8, TN9, TN10, TN11, TN12;

reg [3:0] N;
reg [11:0] variance_guess;

wire [13:0] Tsum;

initial
begin
N <= 4'b1100;//change to reactive
variance_guess <= 12'b010000000000;//32 oF
end

always @ (posedge CLK)
begin
	if(RESET == 1'b1) begin
	TN1 <= 1'b0;
	TN2 <= 1'b0;
	TN3 <= 1'b0;
	TN4 <= 1'b0;
	TN5 <= 1'b0;
	TN6 <= 1'b0;
	TN7 <= 1'b0;
	TN8 <= 1'b0;
	TN9 <= 1'b0;
	TN10 <= 1'b0;
	TN11 <= 1'b0;
	TN12 <= 1'b0;
	SAMPLE <= 1'b0;
	DONE <= 1'b0;
	AVG_SD <= 12'b0;
	end
	else begin	
	TN1 <= TN;
	TN2 <= TN1;
	TN3 <= TN2;
	TN4 <= TN3;
	TN5 <= TN4;
	TN6 <= TN5;
	TN7 <= TN6;
	TN8 <= TN7;
	TN9 <= TN8;
	TN10 <= TN9;
	TN11 <= TN10;
	TN12 <= TN11;
	end
	if(MODE == 1'b0) begin
		AVG_SD <= Tsum;//Tavg;
	end
	else begin
		AVG_SD <= Tsum;//Tstd;
	end
end
assign Tsum = TN1 + TN2 + TN3 + TN4 + TN5 + TN6 + TN7 + TN8 + TN9 + TN10 + TN11 + TN12;

endmodule
