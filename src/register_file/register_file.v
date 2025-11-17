`timescale 1ns/1ps
`include "specs.vh"


module register_file #(
    parameter WIDTH = 4*`WORD,
    parameter ZERO_REGISTER = 5'b00000,
    parameter ADDR_SPACE = 5,
    parameter REG_AMOUNT = 32
)(
    input wire clk,
    input wire rst,
    input wire [ADDR_SPACE-1:0] r1_addr,
    input wire [ADDR_SPACE-1:0] r2_addr,
    input wire [ADDR_SPACE-1:0] wr_addr,
    input wire wr_en,
    input wire [WIDTH-1:0] wr_data,
    output reg [WIDTH-1:0] r1,
    output reg [WIDTH-1:0] r2
);

reg [WIDTH-1:0] registers [0:REG_AMOUNT-1];

always @(posedge clk or posedge rst) begin
    if (rst) begin
        integer i;
        for (i = 0; i < REG_AMOUNT; i = i + 1) begin
            registers[i] <= 0;
        end 
    end else begin
        if (wr_en && wr_addr != ZERO_REGISTER) begin
            registers[wr_addr] <= wr_data;
        end
        registers[ZERO_REGISTER] <= 0;
    end
end

always_comb begin
    r1 = (r1_addr == ZERO_REGISTER) ? 0 : registers[r1_addr];
    r2 = (r2_addr == ZERO_REGISTER) ? 0 : registers[r2_addr];
end

endmodule