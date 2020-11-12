`timescale 1ns/1ns

module calculate_numerator_denominator(
    input [11:0] sigma_hat,
    input [3:0] N,
    input [13:0] Tsum,
    input MODE,
    output [32:0] numerator, // can be up to 33 bits large
    output [21:0] denominator
);

assign numerator = ( MODE == 0 ) ? Tsum : (sigma_hat**2)*(N**2) + (N)*(Tsum**2) - (Tsum**2);
assign denominator = (MODE == 0) ? N : 2*sigma_hat*N**2;

endmodule