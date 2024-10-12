module ssd( 
input logic [3:0] BCD,
output logic [6:0] SSD

);

always_comb begin
case(BCD)
        4'b0000: SSD = 7'b1000000; 
        4'b0001: SSD = 7'b1111001; 
        4'b0010: SSD = 7'b0100100; 
        4'b0011: SSD = 7'b0110000; 
        4'b0100: SSD = 7'b0011001; 
        4'b0101: SSD = 7'b0010010; 
        4'b0110: SSD = 7'b0000010; 
        4'b0111: SSD = 7'b1111000;
        4'b1000: SSD = 7'b0000000;
        4'b1001: SSD = 7'b0010000; 
        default: SSD = 7'b1111111;
	endcase
end
endmodule