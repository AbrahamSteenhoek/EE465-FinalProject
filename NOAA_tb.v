`timescale 1ns/1ns

module NOAA_tb();
  
  // Ports of __NOAA_Module__
  reg      CLK, RESET, MODE;
  reg      [11:0] TN;
  wire     SAMPLE, DONE;
  wire     [11:0] AVG_SD;
  
  
  // Integers for checking test data
  integer  dataFile;
  integer  scanFile;
  
  // Dummy registers for building test stimulus
  reg      mode;
  reg      [11:0] newInput;
  reg      [11:0] expectedOutput;
  
  
  // // Checking for availability of test data
  // initial begin
  //   $display("Initiating NOAA IoT Motes Module Testing Phase!! Good Luck!!");
  //   // Change the test data filename below
  //   dataFile = $fopen("NOAA_Test_Data_30.txt", "r");
  //   if (dataFile == 0)
  //     begin
  //       $display("Data file does not exist");
  //       $stop;
  //     end
  // end

  initial begin
    CLK = 0;
    RESET = 1; 
  end
    
  initial begin
    #50
    RESET = 0;
  end
    
  always #10 CLK = ~CLK; 

  initial begin // numbers from test dataset of 30
    #65
    TN = 1590; MODE =	1;
    #20
    TN = 2313; MODE =	0;
    #20
    TN = 2804; MODE =	1;
    #20
    TN = 3003; MODE =	0;
    #20
    TN = 1468; MODE =	1;
    #20
    TN = 1138; MODE =	1;
    #20
    TN = 994;  MODE =	1;
    #20
    TN = 433;  MODE =	1;
    #20
    TN = 2416; MODE =	0;
    #20
    TN = 1691; MODE =	0;
    #20
    TN = 1037; MODE =	1;
    #20
    TN = 2571; MODE =	0;
    #20
    TN = 1916; MODE =	0;
    #20
    TN = 2447; MODE =	0;
    #20
    TN = 3054; MODE =	0;
    #20
    TN = 56;   MODE =	0;
    #20
    TN = 1416; MODE =	1;
    #20
    TN = 2242; MODE =	0;
    #20
    TN = 614;  MODE =	1;
    #20
    TN = 494;  MODE =	0;
    #20
    TN = 1404; MODE =	1;
    #20
    TN = 1766; MODE =	0;
    #20
    TN = 732;  MODE =	1;
    #20
    TN = 1104; MODE =	0;
    #20
    TN = 452;  MODE =	1;
    #20
    TN = 2204; MODE =	1;
    #20
    TN = 65;   MODE =	1;
    #20
    TN = 1940; MODE =	1;
    #20
    TN = 45;   MODE =	1;
    #20
    TN = 2573; MODE =	1;
    #20;
  end
  
  // always begin
  //   #60
  //   scanFile = $fscanf(dataFile, "%d %d %d\n", newInput, mode, expectedOutput);
  //   if (!$feof(dataFile)) 
  //     begin
  //       TN = newInput;
  //       MODE = mode;
  //     end
  // end
    
  // // Comparison of NOAA IoT Mote Module output with expected output
  // always @(posedge CLK) begin
  //   if (DONE) begin
  //     $strobe("Reset: %d TN: %5d MODE: %d DONE: %d AVG_OR_SD: %5d expectedOutput: %5d", RESET, TN, MODE, DONE, AVG_SD, expectedOutput);
  //     if (AVG_SD != expectedOutput) begin
  //       $error("WRONG OUTPUT GENERATED!! PLEASE FIX YOUR DESIGN!!");
  //     end
  //     if (scanFile == -1) begin
  //       $display("NOAA IoT Motes MODULE PASSED ALL TESTS!! CONGRATULATIONS!!");
  //       $stop;
  //     end
  //   end
  // end
        
  NOAA_module IoT_Motes(
                  .CLK(CLK),
                  .RESET(RESET),
                  .MODE(MODE),
                  .TN(TN),
                  .SAMPLE(SAMPLE),
                  .DONE(DONE),
                  .AVG_SD(AVG_SD)
                  );
endmodule                    
