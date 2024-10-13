module prbs_verify(
    input  logic        clk,
    input  logic        reset,
    input  logic        load,
    input  logic        en,
    output logic        pass
);

// ROM Inference
const logic [1:15] seed_rom = 15'b011011100010101;
const logic [1:96] out_data_rom = 96'h558AC4A53A1724E163AC2BF9;

const logic [1:96] in_data_rom = 96'hACBCD2114DAE1577C6DBF4C9;

// Internal Signals
logic data_out;
logic data_in_serial;

prbs prbs_inst(.data_in(data_in_serial), .clk(clk), .reset(reset), .load(load), .en(en),
               .seed(seed_rom), .data_out(data_out));

logic [6:0] i; // counter
logic [6:0] error_count;
always_ff @(posedge clk or posedge reset) begin
    if(reset == 1'b1) begin
        // Reset Logic
        i <= 7'h1;
        error_count <= '0;
    end else if(en == 1'b1) begin
        
        if(i < 97) begin
            
            // Verify Logic
            if(out_data_rom[i] !== data_out) begin
                error_count <= error_count + 1;
            end

            i <= i + 1;

        end else begin
            i <= 7'h1;    // Reset to 1 when counter passes 96
        end
    end
end

// serialize the in_data_rom bits for the PRBS
assign data_in_serial = in_data_rom[i];

// Verify Logic continued
assign pass = (error_count === 1'b0) ? 1'b1 : 1'b0;

endmodule