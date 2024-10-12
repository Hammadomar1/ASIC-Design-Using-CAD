module ssd_tb;

   logic [3:0] input_test;   
   logic [6:0] output_test;  
   logic [6:0] check_output;
	integer pass_count = 0;
   integer fail_count = 0;
   ssd uut (
      .BCD(input_test),
      .SSD(output_test)
   );

   initial begin
         for (int i = 0; i < 16; i++) begin
            input_test = i;
            case (input_test)
                  'd0: check_output = 7'b1000000; 
                  'd1: check_output = 7'b1111001; 
                  'd2: check_output = 7'b0100100; 
                  'd3: check_output = 7'b0110000; 
                  'd4: check_output = 7'b0011001; 
                  'd5: check_output = 7'b0010010; 
                  'd6: check_output = 7'b0000010; 
                  'd7: check_output = 7'b1111000;
                  'd8: check_output = 7'b0000000;
                  'd9: check_output = 7'b0010000; 
                  default: check_output = 7'b1111111;
               endcase    
			
			#50;
			if (check_output != output_test) begin
                $display("Test FAILED for input %d:", i);
                $display("  Expected SSD: %d", check_output);
                $display("  Actual SSD  : %d", output_test);
                fail_count = fail_count + 1;
            end else begin
                pass_count = pass_count + 1;
            end
        end
			  $display("Test completed.");
			  $display("Total tests passed: %d", pass_count);
			  $display("Total tests failed: %d", fail_count);
			  $finish;
	end	
		
		
		
		
endmodule


