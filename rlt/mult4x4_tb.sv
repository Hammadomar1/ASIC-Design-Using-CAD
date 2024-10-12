`timescale 1ns/1ps
module mult4x4_tb;

   logic [3:0] A;   
   logic [3:0] B;  
   logic [7:0] Y;
   logic [7:0] expected_output;  

   
   mult4x4 uut (
      .A(A),
      .B(B),
      .Y(Y)
   );

   initial begin
     
      for (int i = 0; i < 16; i++) begin
         for (int j = 0; j < 16; j++) begin
            A = i;
            B = j;
            expected_output = A * B;  
				
            #50;  //for stabilization 
				
            if (Y !== expected_output) begin
               $display("Test Failed for A = %0d, B = %0d. Expected = %0d, Got = %0d", A, B, expected_output, Y);
            end else begin
               $display("Test Passed for A = %0d, B = %0d. Expected = %0d, Got = %0d", A, B, expected_output, Y);
            end
         end
      end

      $finish; 
   end
endmodule

