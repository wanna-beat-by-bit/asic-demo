`include "specs.vh"

// Top-level CPU module integrating all components
module cpu #(
    parameter OP_WIDTH = `OP_WIDTH,
    parameter PC_WIDTH = `INS_ADDRESS_SPACE,
    parameter INSTR_WIDTH = `INS_WIDTH,
    parameter DATA_WIDTH = `WORD,
    parameter ADDR_SPACE = `REG_ADDRESS_SPACE
)(
    input wire clk,
    input wire rst
);

// Program Counter signals
wire [PC_WIDTH-1:0] pc_next;
reg [PC_WIDTH-1:0] pc_current;

// Calculate next PC (simple increment for now, no branches)
assign pc_next = pc_current + 1;

// Single instruction fetched from ROM
wire [INSTR_WIDTH-1:0] instruction;

// Instruction field slicing (RISC-V format)
wire [6:0] funct7 = instruction[31:25];
wire [4:0] rs2 = instruction[24:20];
wire [4:0] rs1 = instruction[19:15];
wire [2:0] funct3 = instruction[14:12];
wire [4:0] rd = instruction[11:7];
wire [6:0] opcode = instruction[6:0];

// For now, we'll use funct3 as our simple opcode
// This is simplified - real RISC-V uses opcode + funct3 + funct7
wire [2:0] simple_opcode = funct3;

// Control signals from control unit
wire reg_write;
wire alu_src; 
wire [2:0] alu_op;

// Register file data signals
wire [DATA_WIDTH-1:0] rs1_data;
wire [DATA_WIDTH-1:0] rs2_data;

// ALU signals
wire [DATA_WIDTH-1:0] alu_in_b; // MUX between register and immediate
wire [DATA_WIDTH-1:0] alu_result;
wire alu_zero, alu_cf;

// Immediate value extraction (I-type format: sign-extended 12 bits)
// For now, we'll just extract the I-type immediate
wire [DATA_WIDTH-1:0] imm = {{20{instruction[31]}}, instruction[31:20]};

// MUX for ALU input B: select register or immediate
assign alu_in_b = alu_src ? imm : rs2_data;

// Program Counter instance
pc #(
    .WIDTH(PC_WIDTH)
) pc_inst(
    .clk(clk),
    .rst(rst),
    .next_pc(pc_next), 
    .current_pc(pc_current) 
);

// ROM instance (instruction memory)
rom #(
    .ADDR_WIDTH(PC_WIDTH),
    .DATA_WIDTH(INSTR_WIDTH)
) rom_inst(
    .addr(pc_current),
    .r_data(instruction)
);

// Register file instance
register_file #(
    .WIDTH(DATA_WIDTH),
    .ADDR_SPACE(ADDR_SPACE)
) rf_inst (
    .clk(clk),
    .rst(rst),
    .r1_addr(rs1),
    .r2_addr(rs2),
    .wr_addr(rd),
    .wr_en(reg_write),
    .wr_data(alu_result),
    .r1_data(rs1_data),
    .r2_data(rs2_data)
);

// Control unit instance
control_unit #(
    .OP_WIDTH(3)
) cunit(
    .opcode(simple_opcode),
    .is_reg_write(reg_write),
    .alu_src_type(alu_src), // 0 = register, 1 = immediate
    .alu_op(alu_op)
);

// ALU instance
alu #(
    .WIDTH(DATA_WIDTH),
    .OP_WIDTH(3)
) alu_inst(
    .i_a(rs1_data),
    .i_b(alu_in_b), // MUXed: immediate or register data
    .i_opcode(alu_op),
    .o_result(alu_result),
    .o_zero(alu_zero),
    .o_cf(alu_cf)
);

endmodule
