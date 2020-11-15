`timescale 1ns/1ns

module calculate_numerator_denominator(
    input [11:0] sigma_hat,
    input [3:0] N,
    input [13:0] Tsum,
    input [27:0] Tsum_square,
    output [32:0] numerator, // can be up to 33 bits large
    output [21:0] denominator
);
wire [35:0] product1;
wire [35:0] product2;
wire [35:0] product3;
wire [35:0] den;

assign product1 = (sigma_hat**2) * (N**2);
assign product2 = N*Tsum_square;
assign product3 = Tsum**2;

assign den = 2 * (N**2) * sigma_hat;

assign numerator = product1 + product2 - product3;
assign denominator = den;

endmodule