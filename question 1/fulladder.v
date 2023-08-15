module FullAdder1Bit (
    input A,
    input B,
    input Cin,
    output Sum,
    output Cout
);

    assign Sum = A ^ B ^ Cin;
    assign Cout = (A & B) | (B & Cin) | (A & Cin);

endmodule

module FullAdder8Bit (
    input [7:0] A,
    input [7:0] B,
    input Cin,
    output [7:0] Sum,
    output Cout
);

    wire [7:0] carry_outs;

    genvar i   ;



    generate
        for (i = 0; i < 8  ; i = i + 1  ) begin : gen_full_adders
            FullAdder1Bit fa ( 

                .A(A[i]),

                .B(B[i]),
                
                .Cin(i == 0 ? Cin : carry_outs[i-1]),
                .Sum(Sum[i]),
                .Cout(carry_outs[i])
            );
        end
    endgenerate

    assign Cout = carry_outs[7];

endmodule
