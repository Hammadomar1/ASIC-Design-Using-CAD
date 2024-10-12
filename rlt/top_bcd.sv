module top_bcd (
    input  logic [7:0] binary_in,  
    output logic [1:0] hundreds,   
    output logic [3:0] tens,      
    output logic [3:0] units      //  binary_in: 0000_0000_01     //1000000

);

    logic unsigned [9:0] bcd;
	 
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

        hundreds = bcd[9:8];
        tens     = bcd[7:4];
        units    = bcd[3:0];
    end

endmodule

