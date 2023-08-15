`timescale 1ns/1ns
`include "4bitmultiply.v"



module multiplier_4bit_tb;

    reg [3:0] A;
    reg [3:0] B;
    wire [7:0] P;

    multiplier_4bit dut (
        .A(A),
        .B(B),
        .P(P)
    );

    initial begin

        $dumpfile("4bit_multiply_tb.vcd");
        $dumpvars(0, multiplier_4bit_tb);

        $display("Testing 4-bit Multiplier");

        // Test cases
        A = 4'b0010;
        B = 4'b0011;
        #10;
        $display("A * B = %d", P);

        A = 4'b1100;
        B = 4'b1010;
        #10;
        $display("A * B = %d", P);

        // Add more test cases here

        $finish;
    end

endmodule
