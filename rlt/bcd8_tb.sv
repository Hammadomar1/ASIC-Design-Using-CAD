module bcd8_tb;
    logic [7:0] binary_in;
    logic [3:0] hundreds, tens, units;
    logic [3:0] expected_hundreds, expected_tens, expected_units;
    integer i;
    integer pass_count = 0;
    integer fail_count = 0;
    integer temp_value = 0;

    bcd8 dut (
        .binary_in(binary_in),
        .hundreds(hundreds),
        .tens(tens),
        .units(units)
    );

    initial begin
        binary_in = 8'b0;
        expected_hundreds = 4'b0;
        expected_tens = 4'b0;
        expected_units = 4'b0;

        for (i = 0; i < 256; i = i + 1) begin
            binary_in = i;
            temp_value = i;

            expected_hundreds = temp_value / 100;
            temp_value = temp_value % 100;
            expected_tens = temp_value / 10;
            expected_units = temp_value % 10;

            #50;

            if ((hundreds !== expected_hundreds) || (tens !== expected_tens) || (units !== expected_units)) begin
                $display("Test FAILED for input %d:", i);
                $display("  Expected BCD: %0d%0d%0d", expected_hundreds, expected_tens, expected_units);
                $display("  Actual BCD  : %0d%0d%0d", hundreds, tens, units);
                fail_count = fail_count + 1;
            end else begin
                pass_count = pass_count + 1;
            end
        end
        $display("Test completed.");
        $display("Total tests passed: %0d", pass_count);
        $display("Total tests failed: %0d", fail_count);
        $finish;
    end


endmodule
