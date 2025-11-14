`timescale 1ns/1ps
`include "tools.v"
`include "specs.vh"

module bench #(
    parameter WIDTH = `WORD 
);

// Сигналы
reg t_clk;
reg t_rst;
reg [WIDTH-1:0] t_a;
reg [WIDTH-1:0] t_b;
reg [2:0] t_op;
reg t_i_valid;
reg [31:0] t_clk_counter;

wire [WIDTH-1:0] t_result;
wire t_zero;
wire t_cf;
wire t_o_valid;

// Инстанцирование тестируемого модуля
pipeline_alu pa8 (
    .i_clk(t_clk),
    .i_rst(t_rst),
    .i_a(t_a),
    .i_b(t_b),
    .i_opcode(t_op),
    .i_valid(t_i_valid),
    .o_result(t_result),
    .o_zero(t_zero),
    .o_cf(t_cf),
    .o_valid(t_o_valid)
);

// Генерация тактового сигнала
initial begin
    t_clk = 0;
    forever #5 t_clk = ~t_clk; // 100 МГц
end

// not used, but might for debug
always @(posedge t_clk) t_clk_counter <= t_clk_counter + 1; 

task automatic tick;
    input int tick_amount;
    begin
        repeat(tick_amount) @(posedge t_clk);
    end
endtask

task automatic test_opcode;
    input logic [WIDTH-1:0] a, b, expected_result;
    input logic [2:0] opcode;
    begin
        t_a = a;
        t_b = b;
        t_op = opcode;
        t_i_valid = 1;
        tick(2);
        `ASSERT(
            t_result == expected_result, 
            $sformatf("OPCODE[%b]: %0d, %0d", opcode, a, b), 
            $sformatf("expected %0d, but actual %0d[%b]", expected_result, t_result, t_result))
    end
endtask 

// Инициализация
initial begin
    t_rst = 0;
    t_a = 0;
    t_b = 0;
    t_op = 3'b111;
    t_i_valid = 0;

    tick(3);
    t_rst = 1;
    tick(1);
    t_rst = 0;

    test_opcode(8'b0011_1100,8'b0000_0011,8'b0011_1111,`OP_XOR);
    test_opcode(2,2,4,`OP_SUM);
    test_opcode(8'b0011_1100,8'b0000_0100,8'b0000_0100,`OP_AND);
    test_opcode(7,2,5,`OP_SUB);

    #250 $finish();
end

// Мониторинг: включить, если нужен
// initial begin
//     $monitor(
//         "| CLK=%0t | RST=%b | OP=%b | A=%0d | B=%0d | RES=%0d | ZERO=%b | CF=%b | VALID=%b |",
//         $time, t_rst, t_op, t_a, t_b, t_result, t_zero, t_cf, t_o_valid
//     );
// end

endmodule
