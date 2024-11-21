module prbs(
    input  logic        data_in,
    input  logic        clk,
    input  logic        resetN,
    input  logic        load,
    input  logic        en,
    input  logic [14:0] seed,
    input  logic        ready_fec,
    input  logic        valid_in,
    output logic        data_out,
    output logic        valid_out,
    output logic        ready_randomizer
);
    logic [14:0] r_reg;
    logic [14:0] r_next;
    logic        lfsrXOR;

    // Register logic
    always_ff @(posedge clk or negedge resetN) begin
        if (resetN == 1'b0) begin
            r_reg <= '0;
        end else if (load == 1'b1) begin
            r_reg <= seed;
        end else if (en == 1'b1 && valid_in == 1'b1 && ready_fec == 1'b1) begin
            r_reg <= r_next;
        end
    end

    // Combinational logic
    always_comb begin
        // LFSR feedback calculation for x^15 + x^14 + 1 polynomial
        lfsrXOR = r_reg[14] ^ r_reg[13];
        r_next  = {r_reg[13:0], lfsrXOR}; // Shift left with new bit
        // PRBS data output
        data_out = data_in ^ lfsrXOR;
        // Output control signals
        valid_out        = valid_in & en & ready_fec;
        ready_randomizer = 1'b1; // Assuming always ready
    end
endmodule
