`timescale 1ns/1ps

module register_file(RESET, TN, CLK, Tsum, N);
input RESET;
input [11:0] TN;
input CLK;

output [13:0] Tsum;
output reg [3:0] N;

reg[11:0] TN1, TN2, TN3, TN4, TN5, TN6, TN7;
reg[11:0] TN8, TN9, TN10, TN11, TN12, TN13, TN14;

initial
begin
N <= 4'b1100;//change to reactive
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
	TN13 <= 1'b0;
	TN14 <= 1'b0;
	N <= 4'b0;
	end
	else begin	
	if (N != 4'b1110) begin
		N <= N + 1;
	end
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
	TN13 <= TN12;
	TN14 <= TN13;
	end
end
assign Tsum = TN1 + TN2 + TN3 + TN4 + TN5 + TN6 + TN7 + TN8 + TN9 + TN10 + TN11 + TN12 + TN13 + TN14;

endmodule
