`timescale 1ns/1ns
`include "fulladder.v"

module FullAdder8Bit_TB;

    reg [7:0] A;
    reg [7:0] B;
    reg Cin;
    
    wire [7:0] Sum;
    wire Cout;

    FullAdder8Bit dut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    initial begin
        $dumpfile("full_adder_tb.vcd");
        $dumpvars(0, FullAdder8Bit_TB);

        // Test case 1
        A = 8'b01101001;
        B = 8'b11011010;
        Cin = 0;
        #10;
        $display("A = %b, B = %b, Cin = %b, Sum = %b, Cout = %b", A, B, Cin, Sum, Cout);
        
        // Test case 2
        A = 8'b10101111;
        B = 8'b00111001;
        Cin = 1;
        #10;
        $display("A = %b, B = %b, Cin = %b, Sum = %b, Cout = %b", A, B, Cin, Sum, Cout);

        // Add more test cases here...

        $finish;
    end

endmodule
