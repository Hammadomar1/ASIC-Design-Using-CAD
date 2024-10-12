module mult4x4_top_tb;

   
    logic [3:0] in1, in2;
    logic [6:0] dig_1, dig_2, dig_3;  
    logic [15:0] expected_result;
    logic [3:0] expected_hundreds, expected_tens, expected_units;
    logic [6:0] ssd_hundreds, ssd_tens, ssd_units;
    integer i, j;

 
    mult4x4_top dut (
        .in1(in1),
        .in2(in2),
        .dig_1(dig_1),
        .dig_2(dig_2),
        .dig_3(dig_3)
    );


    function logic [6:0] bcd_to_ssd(input logic [3:0] bcd);
        case (bcd)
            4'd0: bcd_to_ssd = ~7'b0111111;  // 0
            4'd1: bcd_to_ssd = ~7'b0000110;  //1
            4'd2: bcd_to_ssd = ~7'b1011011;  // 2
            4'd3: bcd_to_ssd = ~7'b1001111;  // 3
            4'd4: bcd_to_ssd = ~7'b1100110;  // 4
            4'd5: bcd_to_ssd = ~7'b1101101;  // 5
            4'd6: bcd_to_ssd = ~7'b1111101;  // 6
            4'd7: bcd_to_ssd = ~7'b0000111;  // 7
            4'd8: bcd_to_ssd = ~7'b1111111;  // 8
            4'd9: bcd_to_ssd = ~7'b1101111;  // 9
            default: bcd_to_ssd = ~7'b0000000;  //invalid 
        endcase
    endfunction


    initial begin
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                // Apply inputs
                in1 = i;
                in2 = j;
     
                expected_result = in1 * in2;
                expected_hundreds = (expected_result / 100) % 10;
                expected_tens = (expected_result / 10) % 10;
                expected_units = expected_result % 10;

        
                ssd_hundreds = bcd_to_ssd(expected_hundreds);
                ssd_tens = bcd_to_ssd(expected_tens);
                ssd_units = bcd_to_ssd(expected_units);
					#50
               
                assert (dig_1 === ssd_hundreds)
                    else $error("Test failed for in1=%0d, in2=%0d: Expected SSD hundreds = %b, Got = %b", in1, in2, ssd_hundreds, dig_1);
                assert (dig_2 === ssd_tens)
                    else $error("Test failed for in1=%0d, in2=%0d: Expected SSD tens = %b, Got = %b", in1, in2, ssd_tens, dig_2);
                assert (dig_3 === ssd_units)
                    else $error("Test failed for in1=%0d, in2=%0d: Expected SSD units = %b, Got = %b", in1, in2, ssd_units, dig_3);

                $display("Test passed for in1=%0d, in2=%0d: Result=%0d", in1, in2, expected_result);
            end
        end

 
        $finish;
    end
endmodule
