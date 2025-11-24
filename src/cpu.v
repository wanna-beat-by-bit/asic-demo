// basically this is a top

module cpu #(
    parameter OP_WIDTH = `OP_WIDTH-1,
    parameter PC_WIDTH = INS_ADDRESS_SPACE-1,
    parameter INSTR_WIDTH = `INS_WIDTH-1,
    parameter DATA_WIDTH = `WORD,
    parameter ADDR_SPACE = `REG_ADDRESS_SPACE-1
)(
    input wire clk;
    input wire rst;
);

// signals
wire [PC_WIDTH:0] pc_next = pc_current + 1;
reg [PC_WIDTH:0] pc_current;

// single instruction 
wire [INSTR_WIDTH:0] instruction;

// instruction slicing 
wire [6:0] funct7 = instruction[31:25]
wire [4:0] rs2 = instruction[24:20]
wire [4:0] rs1 = instruction[19:15]
wire [2:0] funct3 = instruction[14:12]
wire [4:0] rd = instruction[11:7]
wire [6:0] opcode = instruction[6:0]

// ctrl signals
wire reg_write;
wire alu_src; 
wire [2:0] alu_op;

// data
wire [DATA_WIDTH-1:0] rs1_data;
wire [DATA_WIDTH-1:0] rs2_data;
wire [DATA_WIDTH-1:0] alu_in_b; // pick second operand
wire [DATA_WIDTH-1:0] alu_result;
wire alu_zero, alu_cf;

pc pc_inst(
    .clk(clk),
    .rst(rst),
    .next_pc(pc_next), 
    .current_pc(pc_current) 
);

rom rom_inst(
    .addr(pc_current),
    .r_data(instruction)
);

register_file rf_inst (
    .clk(clk),
    .rst(rst),
    .r1_addr(rs1),
    .r2_addr(rs2),
    .wr_addr(rd),
    .wr_en(reg_write),
    .wr_data(alu_result),
    .r1(rs1_data),
    .r2(rs2_data)
);

control_unit cunit(
    .opcode(opcode),
    .is_reg_write(reg_write),
    .alu_src_type(alu_src), // registers - 0, immediate - 1
    .alu_op(alu_op)
);

alu alu_inst(
    .i_a(rs1_data),
    .i_b(alu_src ? imm : r_dst_data), // immediate or register data
    .i_opcode(alu_op),
    .o_result(alu_result),
    .o_zero(alu_zero),
    .o_cf(alu_cf)
);

endmodule