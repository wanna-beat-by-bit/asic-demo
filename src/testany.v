`timescale 1ns/1ps

// testbench for various things
// 

module testany;

reg [7:0] some_data;

wire [8:0] extended_sum = {1'b0, 8'b11111110} + {1'b0, 8'b00000001};
assign carry_out = extended_sum[8];
wire carry_out = extended_sum[8];

initial begin
    #1
    $display("extended_sum = %b", extended_sum);
    $display("carry_out = %b", carry_out);
end

endmodule
