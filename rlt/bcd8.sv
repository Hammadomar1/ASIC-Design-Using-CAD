module bcd8(
    input  logic [7:0] binary_in,
    output logic [3:0] hundreds,   
    output logic [3:0] tens,       
    output logic [3:0] units       
);

logic [3:0] output1, output2, output3, output4, output5, output6, output7;

add3 c1 (
    .A({1'b0, binary_in[7], binary_in[6], binary_in[5]}),
    .S(output1)
);

add3 c2 (
    .A({output1[2:0], binary_in[4]}),
    .S(output2)
);

add3 c3 (
    .A({output2[2:0], binary_in[3]}),
    .S(output3)
);

add3 c4 (
    .A({output3[2:0], binary_in[2]}),
    .S(output4)
);

add3 c5 (
    .A({output4[2:0], binary_in[1]}),
    .S(output5)
);

add3 c6 (
    .A({1'b0, output1[3], output2[3], output3[3]}),
    .S(output6)
);

add3 c7 (
    .A({output6[2:0], output4[3]}),
    .S(output7)
);



assign hundreds = {2'b00, output6[3], output7[3]};
assign tens = {output7[2:0], output5[3]};
assign units = {output5[2:0], binary_in[0]};

endmodule

	
