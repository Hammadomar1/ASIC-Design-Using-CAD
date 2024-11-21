package Package_wimax;

//constants 
    timeunit 1ns;
    timeprecision 1ps;
    `timescale 1ns /1ps
    parameter time CLK_50_PERIOD 						= 20;
    parameter time CLK_50_HALF_PERIOD				   = CLK_50_PERIOD / 2;
    parameter time CLK_100_PERIOD 						= 10;
    parameter time CLK_100_HALF_PERIOD 				= CLK_100_PERIOD / 2;

    // randomizer parameter
    parameter logic [95:0] RANDOMIZER_INPUT 			= 96'hACBCD2114DAE1577C6DBF4C9;
    parameter logic [95:0] RANDOMIZER_OUTPUT			= 96'h558AC4A53A1724E163AC2BF9;
    
    // FEC-Encoder parameter
    parameter logic [95:0]  FEC_ENCODER_INPUT 		= 96'h558AC4A53A1724E163AC2BF9;
	 parameter logic [191:0] FEC_ENDODER_OUTPUT 		= 192'h2833E48D392026D5B6DC5E4AF47ADD29494B6C89151348CA;
    
    // interleaver parameter
    parameter logic [191:0] INTERLEAVER_INPUT 		= 192'h2833E48D392026D5B6DC5E4AF47ADD29494B6C89151348CA;
	 parameter logic [191:0] INTERLEAVER_OUTPUT 		= 192'h4B047DFA42F2A5D5F61C021A5851E9A309A24FD58086BD1E;

    
    // modulator parameters
	 parameter logic [191:0] INPUT_MODULATION 		= 192'h4B047DFA42F2A5D5F61C021A5851E9A309A24FD58086BD1E;
 
    parameter logic [15:0] ZeroPointSeven		 		= 16'b0101101001111111;
    parameter logic [15:0] NegativeZeroPointSeven  = 16'b1010010110000001;


																	//**** Tasks ****//
    
 task automatic enter_96_inputs(
    input int start,
    input int STOP,
    input logic [95:0] data_in,
    output logic test_data
);
    for (int i = STOP; i >= start; i--) begin
        test_data = data_in[i];
        $display("Time=%0t | Sending bit %0d: %b", $time, i, test_data);
        #(CLK_50_PERIOD);
    end
endtask



    // enter192-bit output
    task automatic enter_192_outputs(
        input int start,
        input int STOP,
        output logic [191:0] data_out,
        input logic test_data
    );
        for (int i = STOP; i >= start; i--) begin
            data_out[i] = test_data;
            #(CLK_100_PERIOD);
        end
    endtask
	 
	 
	  //enter 192 bit input
    task automatic enter_192_inputs(
        input int start,
        input int STOP,
        input logic [191:0] data_in,
        output logic test_data
    );
        for (int i = STOP; i >= start; i--) begin
            test_data = data_in[i];
            #(CLK_100_PERIOD);
        end
    endtask

endpackage