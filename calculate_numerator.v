`timescale 1ns/1ns

module calculate_numerator(
    input [11:0] sigma_hat,
    input [3:0] N,
    input [13:0] Tsum,
    input MODE,
    output [20:0] numerator
);

assign numerator = ( MODE == 0 ) ? Tsum : sigma_hat^2*N^2 + N*Tsum^2 - Tsum^2;

endmodule