module johnson_counter (
    input wire clock,
    input wire reset,
    output wire [3:0] counter_state
);

reg [3:0] counter;

always @(posedge clock or posedge reset) begin
    if (reset)
        counter <= 4'b0000;
    else
        counter <= {counter[2:0], ~counter[3]};
end

assign counter_state = counter;

endmodule


