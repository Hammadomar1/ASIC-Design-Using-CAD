module mult4x4_top(
input logic [3:0] in1,
input logic [3:0] in2,
output logic [6:0] dig_1,
output logic [6:0] dig_2,
output logic [6:0] dig_3

);

//internal wires
logic [7:0] mult_out;
logic [3:0] hunds, tens,units;



//multiplier instance

mult4x4 multiplier (
    .A(in1),
	 .B(in2),
    .Y(mult_out)
);

// BCD instance
bcd8 BCD_encoder (
    .binary_in(mult_out),
	 .hundreds(hunds),
    .tens(tens),
	 .units(units)
	 
);

//SSD instances 
ssd ssd_1 (
    .BCD(hunds),
	 .SSD(dig_1)
);

ssd ssd_2 (
    .BCD(tens),
	 .SSD(dig_2)
);

ssd ssd_3 (
    .BCD(units),
	 .SSD(dig_3)
);


endmodule