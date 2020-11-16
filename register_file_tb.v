`include "register_file.v"

`timescale 1ns/1ns

module register_file_tb;

reg reset;
reg [11:0] tn;
reg sample;
reg clk;
wire [15:0] tsum_actual;
reg [15:0] tsum_expected;
wire [27:0] tsum_square_actual;
reg [27:0] tsum_square_expected;

always #10 clk <= ~clk;

integer i;

initial begin
    $display("Running tests for register_file module");
    $display("Tsum_actual=%d | Tsum_expected=%d | Tsum_square_actual=%d | Tsum_square_expected=%d",
    tsum_actual,
    tsum_expected,
    tsum_square_actual,
    tsum_square_expected
    );

    clk = 0;
    reset = 1;
    sample = 0;
    #40
    reset = 0;
    sample = 1;

    for ( i = 1; i <= 16; i = i + 1 ) begin
        tn = i;
        #10
        case ( i )
            1: begin
                tsum_expected = 1;
                tsum_square_expected = 1**2;
            end
            2: begin
                tsum_expected = 1+2;
                tsum_square_expected = 1**2 + 2**2;
            end
            3: begin
                tsum_expected = 1+2+3;
                tsum_square_expected = 1**2 + 2**2 + 3**2;
            end
            4: begin
                tsum_expected = 1+2+3+4;
                tsum_square_expected = 1**2 + 2**2 + 3**2 + 4**2;
            end
            5: begin
                tsum_expected = 1+2+3+4+5;
                tsum_square_expected = 1**2 + 2**2 + 3**2 + 4**2 + 5**2;
            end
            6: begin
                tsum_expected = 1+2+3+4+5+6;
                tsum_square_expected = 1**2 + 2**2 + 3**2 + 4**2 + 5**2 + 6**2;
            end
            7: begin
                tsum_expected = 1+2+3+4+5+6+7;
                tsum_square_expected = 1**2 + 2**2 + 3**2 + 4**2 + 5**2 + 6**2 + 7**2;
            end
            8: begin
                tsum_expected = 1+2+3+4+5+6+7+8;
                tsum_square_expected = 1**2 + 2**2 + 3**2 + 4**2 + 5**2 + 6**2 + 7**2 + 8**2;
            end
            9: begin
                tsum_expected = 1+2+3+4+5+6+7+8+9;
                tsum_square_expected = 1**2 + 2**2 + 3**2 + 4**2 + 5**2 + 6**2 + 7**2 + 8**2 + 9**2;
            end
            10: begin
                tsum_expected = 1+2+3+4+5+6+7+8+9+10;
                tsum_square_expected = 1**2 + 2**2 + 3**2 + 4**2 + 5**2 + 6**2 + 7**2 + 8**2 + 9**2 + 10**2;
            end
            11: begin
                tsum_expected = 1+2+3+4+5+6+7+8+9+10+11;
                tsum_square_expected = 1**2 + 2**2 + 3**2 + 4**2 + 5**2 + 6**2 + 7**2 + 8**2 + 9**2 + 10**2 + 11**2;
            end
            12: begin
                tsum_expected = 1+2+3+4+5+6+7+8+9+10+11+12;
                tsum_square_expected = 1**2 + 2**2 + 3**2 + 4**2 + 5**2 + 6**2 + 7**2 + 8**2 + 9**2 + 10**2 + 11**2 + 12**2;
            end
            13: begin
                tsum_expected = 1+2+3+4+5+6+7+8+9+10+11+12+13;
                tsum_square_expected = 1**2 + 2**2 + 3**2 + 4**2 + 5**2 + 6**2 + 7**2 + 8**2 + 9**2 + 10**2 + 11**2 + 12**2 + 13**2;
            end
            14: begin
                tsum_expected = 1+2+3+4+5+6+7+8+9+10+11+12+13+14;
                tsum_square_expected = 1**2 + 2**2 + 3**2 + 4**2 + 5**2 + 6**2 + 7**2 + 8**2 + 9**2 + 10**2 + 11**2 + 12**2 + 13**2 + 14**2;
            end
            15: begin
                tsum_expected = 2+3+4+5+6+7+8+9+10+11+12+13+14+15;
                tsum_square_expected = 2**2 + 3**2 + 4**2 + 5**2 + 6**2 + 7**2 + 8**2 + 9**2 + 10**2 + 11**2 + 12**2 + 13**2 + 14**2 + 15**2;
            end
            16: begin
                tsum_expected = 3+4+5+6+7+8+9+10+11+12+13+14+15+16;
                tsum_square_expected = 3**2 + 4**2 + 5**2 + 6**2 + 7**2 + 8**2 + 9**2 + 10**2 + 11**2 + 12**2 + 13**2 + 14**2 + 15**2 + 16**2;
            end
        endcase
        #5

        $display("Tsum_actual=%d | Tsum_expected=%d | Tsum_square_actual=%d | Tsum_square_expected=%d",
        tsum_actual,
        tsum_expected,
        tsum_square_actual,
        tsum_square_expected
        );

        if ( tsum_expected != tsum_actual || tsum_square_expected != tsum_square_actual ) begin
            $error( "Wrong output for iteration: %d", i);
            $stop;
        end
        #5;
    end

    $display( "All tests for register_file module passed" );
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