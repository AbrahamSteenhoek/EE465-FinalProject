`timescale 1ns/1ps

module register_file(RESET, TN, SAMPLE, CLK, Tsum, Tsum_square );
input RESET;
input [11:0] TN;
input SAMPLE;
input CLK;

output [15:0] Tsum;
output [27:0] Tsum_square;

reg[11:0] TN1, TN2, TN3, TN4, TN5, TN6, TN7;
reg[11:0] TN8, TN9, TN10, TN11, TN12, TN13, TN14;

reg[23:0] TN1_sqr, TN2_sqr, TN3_sqr, TN4_sqr, TN5_sqr, TN6_sqr, TN7_sqr;
reg[23:0] TN8_sqr, TN9_sqr, TN10_sqr, TN11_sqr, TN12_sqr, TN13_sqr, TN14_sqr;

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

	TN1_sqr <= 1'b0;
	TN2_sqr <= 1'b0;
	TN3_sqr <= 1'b0;
	TN4_sqr <= 1'b0;
	TN5_sqr <= 1'b0;
	TN6_sqr <= 1'b0;
	TN7_sqr <= 1'b0;
	TN8_sqr <= 1'b0;
	TN9_sqr <= 1'b0;
	TN10_sqr <= 1'b0;
	TN11_sqr <= 1'b0;
	TN12_sqr <= 1'b0;
	TN13_sqr <= 1'b0;
	TN14_sqr <= 1'b0;
	end
	else begin	
		if( SAMPLE ) begin
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

			TN1_sqr <= TN**2;
			TN2_sqr <= TN1_sqr;
			TN3_sqr <= TN2_sqr;
			TN4_sqr <= TN3_sqr;
			TN5_sqr <= TN4_sqr;
			TN6_sqr <= TN5_sqr;
			TN7_sqr <= TN6_sqr;
			TN8_sqr <= TN7_sqr;
			TN9_sqr <= TN8_sqr;
			TN10_sqr <= TN9_sqr;
			TN11_sqr <= TN10_sqr;
			TN12_sqr <= TN11_sqr;
			TN13_sqr <= TN12_sqr;
			TN14_sqr <= TN13_sqr;
		end
	end
end

assign Tsum = TN1 + TN2 + TN3 + TN4 + TN5 + TN6 + TN7 + TN8 + TN9 + TN10 + TN11 + TN12 + TN13 + TN14;
assign Tsum_square = TN1_sqr + TN2_sqr + TN3_sqr + TN4_sqr + TN5_sqr + TN6_sqr + TN7_sqr + TN8_sqr + TN9_sqr + TN10_sqr + TN11_sqr + TN12_sqr + TN13_sqr + TN14_sqr;

endmodule
