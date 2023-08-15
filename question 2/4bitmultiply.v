module full_adder_1bit(
    input wire A,
    input wire B,
    input wire Cin,
    output wire Sum,
    output wire Cout
);
    assign Sum = A ^ B ^ Cin;
    assign Cout = (A & B) | (B & Cin) | (A & Cin);
endmodule


module eight_bit_adder(
    input wire [7:0] A,
    input wire [7:0] B,
    input wire Cin,
    output wire [7:0] Sum,
    output wire Cout
);
    wire [7:0] internal_sum;
    wire [7:0] carry_chain;

    assign internal_sum = A + B + Cin;
    
    assign carry_chain[0] = Cin;
    genvar i;
    generate
        for (i = 0; i < 7; i = i + 1) begin
            assign carry_chain[i+1] = internal_sum[i] | (carry_chain[i] & (A[i] | B[i]));
        end
    endgenerate

    assign Sum = internal_sum;
    assign Cout = carry_chain[7];

endmodule



module multiplier_4bit(
    input wire [3:0] A,
    input wire [3:0] B,
    output wire [7:0] P
);
    wire [3:0] partial_products [7:0];
    wire [7:0] compressed_products [1:0];
    
    // Generate partial product matrix
    genvar i, j;
    generate
        for (i = 0; i < 4; i = i + 1) begin
            for (j = 0; j < 8; j = j + 1) begin
                assign partial_products[j][i] = A[i] & B[j];
            end
        end
    endgenerate
    
    // Compress partial product matrix using full adder
    genvar k;
    generate
        for (k = 0; k < 2; k = k + 1) begin
            full_adder_1bit fa (
                .A(partial_products[2*k][0]),
                .B(partial_products[2*k+1][0]),
                .Cin(1'b0),
                .Sum(compressed_products[k][0]),
                .Cout()
            );
            
            for (j = 1; j < 8; j = j + 1) begin
                full_adder_1bit fa (
                    .A(partial_products[2*k][j]),
                    .B(partial_products[2*k+1][j]),
                    .Cin(compressed_products[k][j-1]),
                    .Sum(compressed_products[k][j]),
                    .Cout()
                );
            end
        end
    endgenerate
    
    // Generate final result using 8-bit adder
    wire [8:0] P_extended;
    assign P_extended = {1'b0, compressed_products[1], compressed_products[0]};
    
    eight_bit_adder adder (
        .A(P_extended),
        .B(8'b0), // Set to 8 bits of zeros for correct width match
        .Cin(1'b0),
        .Sum(P),
        .Cout()
    );
endmodule
