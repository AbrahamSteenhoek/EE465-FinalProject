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

// wire [30:0] prod1;
// wire [35:0] prod2;
// wire [31:0] prod3;
// wire [18:0] Nsqr_x_sigma;

// assign Nsqr_x_sigma = N*N*sigma_hat;

// assign prod1 = Nsqr_x_sigma*sigma_hat; // assign N^2*sigma_hat^2
// assign prod2 = N*Tsum_square; // assign N*Tsum^2
// assign prod3 = Tsum*Tsum; // assign Tsum^2

// assign numerator = prod1+prod2-prod3; 
// assign denominator = Nsqr_x_sigma; // assign N^2*sigma_hat

endmodule