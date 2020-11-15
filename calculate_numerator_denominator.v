`timescale 1ns/1ns

module calculate_numerator_denominator(
    input [11:0] sigma_hat,
    input [3:0] N,
    input [13:0] Tsum,
    input [27:0] Tsum_square,
    output [32:0] numerator, // can be up to 33 bits large
    output [21:0] denominator
);

assign numerator = ((sigma_hat**2) * (N**2)) + (N*Tsum_square) - (Tsum**2);
assign denominator = 2 * (N**2) * sigma_hat;

endmodule