//=============================
// BCD Testbench
//=============================



   module top_bcd_tb;

    // Testbench signals
    logic [7:0] binary_in;
    logic [3:0] hundreds, tens, units;

    // Instantiate the binary_to_bcd module
    top_bcd dut (
        .binary_in(binary_in),
        .hundreds(hundreds),
        .tens(tens),
        .units(units)
    );

    initial begin
         // Test vector generator
  
         for (int i = 0; i < 256; i++) begin
            binary_in = i;
            #50;
         end
 

		  
//		  
//		  // Monitor the outputs
//        $monitor("Binary: %d, BCD = %d%d%d", binary_in, hundreds, tens, units);
//
//        // Test case 1: 14 (0xE in hex)
//        binary_in = 8'd14; // Expected BCD: 14
//        #10;
//
//        // Test case 2: 255 (0xFF in hex)
//        binary_in = 8'd255; // Expected BCD: 255
//        #10;
//
//        // Test case 3: 100
//        binary_in = 8'd100; // Expected BCD: 100
//        #10;
//
//        // Test case 4: 128
//        binary_in = 8'd128; // Expected BCD: 128
//        #10;

        // End simulation
        $finish;
    end

endmodule
