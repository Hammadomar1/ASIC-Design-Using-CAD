
`timescale 1ns/1ps
import Package_wimax::*;
module fec_encoder_wimax_phy_tb;


    bit clk_50;
    bit clk_100;
    bit reset_N;
    bit randomizer_output_valid;
    bit interleaver_ready;
    bit data_in;
    bit valid_out;
    bit data_out;
    bit ready_out;

    // Instantiate the DUT (Device Under Test)
    fec_encoder_wimax_phy dut (
        .clk_50(clk_50),
        .clk_100(clk_100),
        .reset_N(reset_N),
        .randomizer_output_valid(randomizer_output_valid),
        .interleaver_ready(interleaver_ready),
        .data_in(data_in),
        .valid_out(valid_out),
        .data_out(data_out),
        .ready_out(ready_out)
    );

    //clock generation
    initial begin
        clk_50 = 1;
        forever #(CLK_100_PERIOD) clk_50 = ~clk_50; //period = 20ns
    end

    initial begin
        clk_100 = 1;
        forever #(CLK_100_HALF_PERIOD) clk_100 = ~clk_100; //period = 10ns
    end

    // Test vectors
    logic [95:0]  input_vector;
    logic [191:0] expected_output_vector;
    logic [191:0] output_vector;

   integer i;
   integer output_bit_count;

    //initialize signals and apply test vectors
    initial begin
        // Initialize inputs
        reset_N                 = 0;
        randomizer_output_valid = 0;
        interleaver_ready       = 0;
//        data_in                 = 0;

        // Initialize test vectors
        input_vector          = FEC_ENCODER_INPUT;
        expected_output_vector =FEC_ENDODER_OUTPUT;
        output_vector         = 192'b0;
        output_bit_count      = 0;

        #100;
        reset_N = 1;

        //for stabilization
        #100;
			
        //indicate that the interleaver is ready
        interleaver_ready = 1;
		  

		repeat(4) begin					 ///4 Streams ///
		 randomizer_output_valid = 1;
		 output_bit_count      = 0;

        //wait until all output bits are collected
        wait (output_bit_count == 192);

        //compare the actual output with the expected output
        compare_output(output_vector, expected_output_vector);
		end
    
		  
		  	repeat(100) begin  
		  //if interleaver is not ready:
		  interleaver_ready = 0;
		 #(CLK_50_PERIOD);
		  // Indicate that the FEC is ready
			end
		$finish;
    end


    //task to compare the DUT output with the expected output
    task compare_output(input logic [191:0] actual_output, input logic [191:0] expected_output);
        integer bit_idx;
        integer error_count;
        begin
            error_count = 0;
            for (bit_idx = 191; bit_idx >= 0; bit_idx = bit_idx - 1) begin
                if (actual_output[bit_idx] !== expected_output[bit_idx]) begin
                    $display("Mismatch at bit %0d: Expected %b, Got %b", bit_idx, expected_output[bit_idx], actual_output[bit_idx]);
                    error_count = error_count + 1;
                end
					 else begin
						$display(" Bit %0d: Expected %b, Got %b", bit_idx, expected_output[bit_idx], actual_output[bit_idx]);
						end
            end
            if (error_count == 0) begin
                $display("Test Passed: Output matches expected output vector.");
            end else begin
                $display("Test Failed: %0d mismatches found.", error_count);
            end
        end
    endtask

    //collect output data from the DUT
    always @(posedge clk_100) begin
        if (valid_out) begin
            output_vector[191 - output_bit_count] = data_out;
            output_bit_count = output_bit_count + 1;
        end
    end
	 
	 always @(posedge clk_50 or negedge reset_N) begin
	   if(!reset_N) begin 
			i <= 95;
//			counter_output <= 0;
		end else if(randomizer_output_valid) begin
			//$display("Applying bit %0d: %b", i, data_in); 
			if(i == 0) begin
				i <= 95;
//				counter_output <= 0;
			end else begin
				i <= i - 1;
			end
		end
	 end
	 
	 assign data_in = FEC_ENCODER_INPUT[i];
	 

endmodule


