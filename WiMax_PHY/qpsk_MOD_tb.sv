module qpsk_MOD_tb;

    // Clock signals
    logic clk_50;
    logic clk_100;

    // Reset signal
    logic Reset_N;

    // Inputs to the DUT
    logic data_in;
    logic valid_interleaver;
    logic ready_TOP_TB;

    // Outputs from the DUT
    logic ready_interleaver;
    logic valid_TOP_TB;
    logic signed [15:0] I_comp;
    logic signed [15:0] Q_comp;

    // Instantiate the DUT (Device Under Test)
    qpsk_MOD dut (
        .clk_50(clk_50),
        .clk_100(clk_100),
        .Reset_N(Reset_N),
        .data_in(data_in),
        .valid_interleaver(valid_interleaver),
        .ready_TOP_TB(ready_TOP_TB),
        .ready_interleaver(ready_interleaver),
        .valid_TOP_TB(valid_TOP_TB),
        .I_comp(I_comp),
        .Q_comp(Q_comp)
    );

    // Clock generation for 50 MHz and 100 MHz
    initial begin
        clk_50 = 0;
        forever #10 clk_50 = ~clk_50; // Period = 20ns
    end

    initial begin
        clk_100 = 0;
        forever #5 clk_100 = ~clk_100; // Period = 10ns
    end

    // Input data from the interleaver
    bit [191:0] serial_data = 192'h4B047DFA42F2A5D5F61C021A5851E9A309A24FD58086BD1E;

    // Expected outputs (I_comp and Q_comp) corresponding to the input data
    // You need to generate this based on your modulator mapping
    // For this testbench, we'll compute expected values within the testbench

    integer i;
    integer error_count;

    // Internal variables
    logic [1:0] symbol_bits;
    logic signed [15:0] expected_I;
    logic signed [15:0] expected_Q;

    // QPSK Constellation points in Q15 format
    localparam logic signed [15:0] POS_A = 16'd23170;  // +0.707 in Q15 format
    localparam logic signed [15:0] NEG_A = -16'd23170; // -0.707 in Q15 format

    // Initialize signals and apply test vectors
    initial begin
        // Initialize inputs
        Reset_N           = 0;
        data_in           = 0;
        valid_interleaver = 0;
        ready_TOP_TB      = 1; // Assume ready to receive output

        error_count = 0;

        // Apply reset
        #50;
        Reset_N = 1;

        // Wait for the system to stabilize
        #50;

        // Apply input data and print outputs
        apply_input_data();

        // Display test results
        if (error_count == 0) begin
            $display("Test Passed: All outputs match the expected values.");
        end else begin
            $display("Test Failed: %0d mismatches found.", error_count);
        end

        // Finish simulation
        $finish;
    end

    // Task to apply input data and print outputs
    task apply_input_data;
        integer idx;
		   integer bit_count; // Declare bit_count as an integer instead of bit
        begin
            idx = 0;
            valid_interleaver = 1;

            // Initialize bit counter for symbol formation
            bit_count = 0;

            // Loop over all bits in serial_data
            for (i = 191; i >= 0; i = i - 1) begin
                data_in = serial_data[i];
                @(posedge clk_100);

                // Collect bits to form a symbol
                symbol_bits[bit_count] = data_in;
                bit_count = bit_count + 1;

                if (bit_count == 2) begin
                    bit_count = 0;

                    // Map bits to I and Q components
                    case (symbol_bits)
                        2'b00: begin expected_I = POS_A; expected_Q = POS_A; end // 00 -> (+0.707, +0.707)
                        2'b01: begin expected_I = POS_A; expected_Q = NEG_A; end // 01 -> (+0.707, -0.707)
                        2'b10: begin expected_I = NEG_A; expected_Q = POS_A; end // 10 -> (-0.707, +0.707)
                        2'b11: begin expected_I = NEG_A; expected_Q = NEG_A; end // 11 -> (-0.707, -0.707)
                        default: begin expected_I = 16'd0; expected_Q = 16'd0; end
                    endcase

                    // Wait for the valid output
                    wait(valid_TOP_TB);

                    // Print the outputs in the desired format
                    $display("I_comp Q_comp: %d %d %d", I_comp, Q_comp, i);
                end
            end

            valid_interleaver = 0;
        end
    endtask

endmodule
