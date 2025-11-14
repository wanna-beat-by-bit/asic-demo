`timescale 1ns/1ps

module pipeline_alu #(
    parameter WIDTH = `WORD
)(
    input wire i_clk,
    input wire i_rst,

    input wire [WIDTH-1:0] i_a,
    input wire [WIDTH-1:0] i_b,
    input wire [2:0] i_opcode,
    input wire i_valid,

    output reg [WIDTH-1:0] o_result,
    output reg o_zero,
    output reg o_cf,
    output reg o_valid
);

wire [WIDTH-1:0] alu_result;
wire alu_zr;
wire alu_cf;

reg [WIDTH-1:0] r_a;
reg [WIDTH-1:0] r_b;
reg [2:0] r_opcode;
reg r_valid;

reg [WIDTH-1:0] r_result;

alu_8bit alu8 (
    .i_a(r_a),
    .i_b(r_b),
    .i_opcode(r_opcode),
    .o_result(alu_result),
    .o_zero(alu_zr),
    .o_cf(alu_cf)
);

always @(posedge i_clk or posedge i_rst) begin
    if (i_rst) begin
        r_valid <= 1'b0;
        o_valid <= 1'b0;
    end else begin
        r_a       <= i_a;
        r_b       <= i_b;
        r_opcode  <= i_opcode;
        r_valid   <= i_valid;

        // calculate on next tick
        o_result  <= alu_result;
        o_zero    <= alu_zr;
        o_cf      <= alu_cf;
        o_valid   <= r_valid;
    end
end 

endmodule
