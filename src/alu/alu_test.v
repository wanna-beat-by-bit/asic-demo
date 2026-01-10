`timescale 1ns/1ps
`include "specs.vh"
`include "tools.v"

module test_alu #(
    parameter WIDTH = `WORD,
    parameter OP_WIDTH = `OP_WIDTH
);

reg [WIDTH-1:0] t_a, t_b;
reg [OP_WIDTH-1:0] t_opcode;

wire [WIDTH-1:0] o_result;
wire o_zero;
wire o_cf;

// Инстанцирование тестируемого модуля
alu alu_inst (
    .i_a(t_a),
    .i_b(t_b),
    .i_opcode(t_opcode),
    .o_result(o_result),
    .o_zero(o_zero),
    .o_cf(o_cf)
);

task automatic tick;
    input int tick_amount;
    begin
        repeat(tick_amount) #5;
    end
endtask

task automatic test_op;
    input [WIDTH-1:0] a, b, exp_res;
    input [OP_WIDTH-1:0] op;
    input       exp_cf;
    input string name;
    begin
        t_a = a; t_b = b; t_opcode = op;
        tick(1);
         `ASSERT(
             (o_result === exp_res) && (o_cf === exp_cf) && (o_zero === (exp_res == 0)),
             name,
             $sformatf("got: res=%x, cf=%x, zero=%x | exp: res=%x, cf=%x, zero=%x",
                 o_result, o_cf, o_zero, exp_res, exp_cf, (exp_res==0))
         );
    end
endtask

initial begin
    test_op(3, 4, 7, `ALU_ADD, 0, "alu add");
    test_op(32'hffffffff, 1, 0, `ALU_ADD, 1, "alu sum and carry"); // carry due to overflow
    test_op(5, 3, 2, `ALU_SUB, 0, "alu sub");
    test_op(32'h00000003, 5, 32'hfffffffe, `ALU_SUB, 1, "alu sub and cf"); // assert CF=1
    test_op(8'b11110000, 8'b10101010, 8'b10100000, `ALU_AND, 0, "alu and");
    test_op(8'b11110000, 8'b10101010, 8'b01011010, `ALU_XOR, 0, "alu xor");
    test_op(32'h00000001, 1, 0, `ALU_SUB, 0, "alu zero on sub"); // ZR=1 || CF=0

    $finish;
end

endmodule
