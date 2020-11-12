`timescale 1ns/1ns

module NOAA_module_tb;
    // Ports of __NOAA_Module__
    reg      CLK, RESET, MODE;
    reg      [11:0] TN;
    wire     SAMPLE, DONE;
    wire     [11:0] AVG_SD;

    initial begin
        CLK = 0;
        RESET = 1; 
    end

    initial begin
        #50
        RESET = 0;
    end

    always #10 CLK = ~CLK; 
        
    initial begin
        #5
        MODE <= 1;
        TN <= 1590;
        #40
        MODE <= 0;
        TN <= 2313;
        #40
        MODE <= 1;
        TN <= 2804;
        #40
        MODE <= 0;
        TN <= 3003;
        #40
        MODE <= 1;
        TN <= 1468;
        #40
        MODE <= 1;
        TN <= 1138;
        #40
        MODE <= 1;
        TN <= 994;
        #40
        MODE <= 1;
        TN <= 433;
        #40
        MODE <= 0;
        TN <= 2416;
        #40
        MODE <= 0;
        TN <= 1691;
        #40
        MODE <= 1;
        TN <= 1037;
        #40
        MODE <= 0;
        TN <= 2571;
        #40
        MODE <= 0;
        TN <= 1916;
        #40
        MODE <= 0;
        TN <= 2447;
        #40
        MODE <= 0;
        TN <= 3054;
        #40;
    end

    NOAA_module IoT_Motes(
                    .CLK(CLK),
                    .RESET(RESET),
                    .MODE(MODE),
                    .TN(TN),
                    .SAMPLE(SAMPLE),
                    .DONE(DONE),
                    .AVG_SD(AVG_SD)
                    );
endmodule;