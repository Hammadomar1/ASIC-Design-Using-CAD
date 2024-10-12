module add3 (
    input  logic [3:0] A,   // 4-bit input
    output logic [3:0] S    // 4-bit output after add-3 correction
);

always_comb begin
	 bcd = 10'b0;

        for (int i = 7; i >= 0; i = i - 1) begin
            if (bcd[7:4] >= 5)
                bcd[7:4] = bcd[7:4] + 4'd3;
				else 
					bcd[7:4] = bcd[7:4];
			
            if (bcd[3:0] >= 5)
						bcd[3:0] = bcd[3:0] + 4'd3;   
				else 
					bcd[3:0] = bcd[3:0];

            bcd = {bcd[8:0], binary_in[i]};
        end
	end	  
endmodule


//module add3 (
//    input  logic [3:0] A,   // 4-bit input
//    output logic [3:0] S    // 4-bit output after add-3 correction
//);
//
//    always_comb begin
//        case (A)
//            4'b0000: S = 4'b0000; // 0 remains 0
//            4'b0001: S = 4'b0001; // 1 remains 1
//            4'b0010: S = 4'b0010; // 2 remains 2
//            4'b0011: S = 4'b0011; // 3 remains 3
//            4'b0100: S = 4'b0100; // 4 remains 4
//            4'b0101: S = 4'b1000; // 5 becomes 8 (Add 3)
//            4'b0110: S = 4'b1001; // 6 becomes 9 (Add 3)
//            4'b0111: S = 4'b1010; // 7 becomes 10 (invalid in BCD, corrected later)
//            4'b1000: S = 4'b1011; // 8 becomes 11 (invalid in BCD, corrected later)
//            4'b1001: S = 4'b1100; // 9 becomes 12 (invalid in BCD, corrected later)
//            default: S = 4'bxxxx; // Invalid cases
//        endcase
//    end
//
//endmodule