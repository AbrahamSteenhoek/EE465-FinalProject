`timescale 1ns/1ns

module calculate_denominator(
    input [3:0] N,
    input [11:0] sigma_hat,
    input MODE,
    output [21:0] denominator
);

assign denominator = (MODE == 0) ? N : 2*sigma_hat*N**2;

endmodule