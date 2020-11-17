`timescale 1ns/1ns

module NOAA_tb();
  
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

// copied numbers from NOAA_Test_Data_30_n.xlsx
  initial begin // numbers from test dataset of 30
    #65
    TN = 1383;	MODE = 0;
    #20
    TN = 3177;	MODE = 1;
    #20
    TN = 593;	MODE = 1;
    #20
    TN = 586;	MODE = 0;
    #20
    TN = 1449;	MODE = 1;
    #20
    TN = 2362;	MODE = 1;
    #20
    TN = 2290;	MODE = 1;
    #20
    TN = 1763;	MODE = 0;
    #20
    TN = 2940;	MODE = 0;
    #20
    TN = 2772;	MODE = 0;
    #20
    TN = 411;	MODE = 0;
    #20
    TN = 1767;	MODE = 1;
    #20
    TN = 1782;	MODE = 0;
    #20
    TN = 2862;	MODE = 1;
    #20
    TN = 2867;	MODE = 1;
    #20
    TN = 329;	MODE = 0;
    #20
    TN = 2022;	MODE = 0;
    #20
    TN = 269;	MODE = 1;
    #20
    TN = 2993;	MODE = 0;
    #20
    TN = 2211;	MODE = 0;
    #20
    TN = 1829;	MODE = 1;
    #20
    TN = 2821;	MODE = 1;
    #20
    TN = 984;	MODE = 1;
    #20
    TN = 2398;	MODE = 0;
    #20
    TN = 3115;	MODE = 0;
    #20
    TN = 1613;	MODE = 0;
    #20
    TN = 1691;	MODE = 0;
    #20
    TN = 3156;	MODE = 1;
    #20
    TN = 2062;	MODE = 0;
    #20
    TN = 1396;	MODE = 1;
    #20
    TN = 3105;	MODE = 1;
    #20
    TN = 1884;	MODE = 1;
    #20
    TN = 1136;	MODE = 1;
    #20
    TN = 446;	MODE = 1;
    #20
    TN = 2113;	MODE = 1;
    #20
    TN = 124;	MODE = 1;
    #20
    TN = 1982;	MODE = 1;
    #20
    TN = 2814;	MODE = 1;
    #20
    TN = 234;	MODE = 0;
    #20
    TN = 1643;	MODE = 0;
    #20
    TN = 3087;	MODE = 0;
    #20
    TN = 476;	MODE = 0;
    #20
    TN = 1388;	MODE = 0;
    #20
    TN = 3003;	MODE = 1;
    #20
    TN = 2354;	MODE = 1;
    #20
    TN = 3132;	MODE = 0;
    #20
    TN = 876;	MODE = 0;
    #20
    TN = 2139;	MODE = 0;
    #20
    TN = 1026;	MODE = 0;
    #20
    TN = 894;	MODE = 1;
    #20
    TN = 3195;	MODE = 0;
    #20
    TN = 1834;	MODE = 0;
    #20
    TN = 3067;	MODE = 1;
    #20
    TN = 2897;	MODE = 0;
    #20
    TN = 517;	MODE = 0;
    #20
    TN = 252;	MODE = 0;
    #20
    TN = 501;	MODE = 0;
    #20
    TN = 1086;	MODE = 1;
    #20
    TN = 265;	MODE = 1;
    #20
    TN = 1244;	MODE = 1;
    #20
    TN = 40;  	MODE = 1;
    #20
    TN = 2831;	MODE = 1;
    #20
    TN = 2097;	MODE = 1;
    #20
    TN = 881;	MODE = 1;
    #20
    TN = 2309;	MODE = 1;
    #20
    TN = 2167;	MODE = 0;
    #20
    TN = 1897;	MODE = 1;
    #20
    TN = 186;	MODE = 1;
    #20
    TN = 2506;	MODE = 1;
    #20
    TN = 3019;	MODE = 0;
    #20
    TN = 328;	MODE = 1;
    #20
    TN = 2532;	MODE = 1;
    #20
    TN = 3103;	MODE = 1;
    #20
    TN = 670;	MODE = 0;
    #20
    TN = 1308;	MODE = 1;
    #20
    TN = 740;	MODE = 1;
    #20
    TN = 2196;	MODE = 1;
    #20
    TN = 218;	MODE = 1;
    #20
    TN = 1246;	MODE = 1;
    #20
    TN = 121;	MODE = 1;
    #20
    TN = 1979;	MODE = 0;
    #20
    TN = 1764;	MODE = 0;
    #20
    TN = 1041;	MODE = 0;
    #20
    TN = 393;	MODE = 0;
    #20
    TN = 1834;	MODE = 0;
    #20
    TN = 1324;	MODE = 0;
    #20
    TN = 2587;	MODE = 0;
    #20
    TN = 943;	MODE = 1;
    #20
    TN = 2227;	MODE = 1;
    #20
    TN = 2659;	MODE = 0;
    #20
    TN = 2632;	MODE = 1;
    #20
    TN = 2837;	MODE = 0;
    #20
    TN = 2875;	MODE = 1;
    #20
    TN = 674;	MODE = 1;
    #20
    TN = 58;	  MODE = 1;
    #20
    TN = 2429;	MODE = 1;
    #20
    TN = 1035;	MODE = 1;
    #20
    TN = 1818;	MODE = 0;
    #20
    TN = 2943;	MODE = 1;
    #20
    TN = 1528;	MODE = 1;
    #20;

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
endmodule
