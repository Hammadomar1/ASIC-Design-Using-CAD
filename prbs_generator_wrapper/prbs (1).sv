module prbs(
    input  logic        data_in,
    input  logic        clk,
    input  logic        reset,
    input  logic        load,
    input  logic        en,
    input  logic [1:15] seed,
    output logic        data_out
);
    logic [1:15] r_reg;
    logic [1:15] r_next;

    logic lfsrXOR;

    // Register inference 
    always_ff @(posedge clk or posedge reset)
    begin
        if(reset == 1'b1) 
        begin
            r_reg <= '0;
        end
        else if(load == 1'b1)
        begin
            r_reg <= seed;
        end
        else if(en == 1'b1)
        begin
            r_reg <= r_next;

        end

    end

    always_comb
    begin
        lfsrXOR = r_reg[15] ^ r_reg[14];
        // Next state logic
        r_next = {lfsrXOR, r_reg[1:14]};

        // Output logic
        data_out = data_in ^ lfsrXOR;

    end

endmodule