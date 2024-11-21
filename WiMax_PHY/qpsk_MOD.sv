// QPSK modulator block RTL design
// Done by: ASIC team 4
// ASIC PROJECT



module qpsk_MOD (
    input logic clk_50,           // 50 MHz input clock
    input logic clk_100,          // 100 MHz output clock (generated by PLL)
    input logic Reset_N,          // Active-low reset
    input logic data_in,          // Serial input data (1 bit at a time)
    input logic valid_interleaver, // Valid input from interleaver
    input logic ready_TOP_TB,     // Input coming from top module test bench
    output logic ready_interleaver, // Output ready to interleaver
    output logic valid_TOP_TB,    // Output going to top module test bench
    output logic signed [15:0] I_comp, // I-component (16 bits for each symbol)
    output logic signed [15:0] Q_comp  // Q-component (16 bits for each symbol)
);

    // QPSK Constellation points in Q15 format
    localparam logic signed [15:0] POS_A = 16'd23170; // 0.707 in Q15 format
    localparam logic signed [15:0] NEG_A = -16'd23170; // -0.707 in Q15 format

    // Internal signals
    logic [1:0] symbol; // Temporary 2-bit symbol register
    bit  bit_count;     // Bit counter for 2-bit symbol

    // Assign ready signal
    assign ready_interleaver = 1'b1; // Always ready to accept data

    always_ff @(posedge clk_100 or negedge Reset_N) begin
        if (Reset_N == 1'b0) begin
            bit_count     <= 0;
            valid_TOP_TB  <= 0;
            I_comp        <= 16'd0;
            Q_comp        <= 16'd0;
        end else begin
            if (valid_interleaver == 1'b1 && ready_interleaver == 1'b1) begin
                if (bit_count == 0) begin
                    symbol[1] <= data_in; // Load first bit into MSB
                    bit_count <= 1;
                    valid_TOP_TB <= 0;
                end else begin
                    symbol[0] <= data_in; // Load second bit into LSB
                    bit_count <= 0;
                    // Mapping code
                    case (symbol)
                        2'b00: begin I_comp <= POS_A; Q_comp <= POS_A; end // 00 -> (+0.707, +0.707)
                        2'b01: begin I_comp <= POS_A; Q_comp <= NEG_A; end // 01 -> (+0.707, -0.707)
                        2'b10: begin I_comp <= NEG_A; Q_comp <= POS_A; end // 10 -> (-0.707, +0.707)
                        2'b11: begin I_comp <= NEG_A; Q_comp <= NEG_A; end // 11 -> (-0.707, -0.707)
                    endcase
                    valid_TOP_TB <= 1'b1; // Indicate valid output
                end
            end else begin
                valid_TOP_TB <= 0; // No valid output
            end
        end
    end

endmodule