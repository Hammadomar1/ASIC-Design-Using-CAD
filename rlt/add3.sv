module add3(
    input  logic [3:0] A,   
    output logic [3:0] S    
);

always_comb begin
    if (A > 4'b1001) begin  //invalid xxxx
        S = 4'bxxxx;
    end else if (A >= 4'b0101) begin  //add 3 if A >= 5
        S = A + 4'b0011;
    end else begin //No change  A < 5
        S = A;
    end
end

endmodule

// module add3(
//     input  logic [3:0] A,   
//     output logic [3:0] S   
// );

// always_comb begin
//     case (A)
//         4'b0000, 4'b0001, 4'b0010, 4'b0011, 4'b0100: S = A;        
//         4'b0101, 4'b0110, 4'b0111, 4'b1000, 4'b1001: S = A + 4'b0011; 
//         default: S = 4'bxxxx;  //if A > 9
//     endcase
// end

// endmodule
