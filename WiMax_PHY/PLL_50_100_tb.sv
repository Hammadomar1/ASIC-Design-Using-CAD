module PLL_50_100_tb ();
import Package_wimax::*;


//wires of the PLL outputs
 logic clk_50mhz;
 logic reset_N;
 logic clk_100mhz;
 logic clk_50mhz_pll;
 logic pll_locked;
 

     PLL_50_100 pll_inst (
        .refclk   (clk_50mhz),   
        .rst      (reset_N),   
        .outclk_0 (clk_100mhz),  
        .outclk_1 (clk_50mhz_pll), 
        .locked   (pll_locked) 
    );

	 
 initial begin
        clk_50mhz = 1;
        forever #(CLK_50_HALF_PERIOD) clk_50mhz = ~clk_50mhz; // Period = 10ns
    end
	
endmodule