// Instructions to support 

// R-type: Register-register ALU operation; rd = rs1 op rs2
// Example: add x5, x1, x2  // x5 = x1 + x2

// I-type: ALU with immediate or load; rd = rs1 op imm
// Example: addi x6, x3, 10 // x6 = x3 + 10

// S-type: Store to memory; Mem[rs1 + imm] = rs2
// Example: sw x4, 16(x7)   // Store x4 at address x7+16

// B-type: Conditional branch; if (rs1 op rs2) pc += imm
// Example: beq x8, x9, 20  // Branch if x8 == x9 to PC+20

// U-type: Loads upper immediate to rd
// Example: lui x10, 0x1000 // x10 = 0x10000000

// J-type: Jump and link; rd = PC+4; PC += imm
// Example: jal x1, 100     // Jump to PC+100, save return in x1

module control_unit #(
    parameter OP_WIDTH = 3,
    parameter OP_TYPE = 3'b000
)(
    input wire [OP_WIDTH-1:0] opcode,
    output wire is_reg_write,
    output wire alu_src_type,
    output wire [OP_WIDTH-1:0] alu_op
);

always_comb begin
    case (opcode) 
        `OP_SUM, `OP_SUB, `OP_AND, `OP_XOR: begin
            is_reg_write = `WR_EN;
            alu_src_type = `R_TYPE; // source B is register
            alu_op = opcode;
        end
        3'b100: begin // example I-type opcode
            is_reg_write = `WR_DISEN;
            alu_src_type = `NOT_R_TYPE;         // source B is immediate
            alu_op = `OP_SUM;    // typically immediate ops use SUM logic
        end
        default: begin
            is_reg_write = `WR_DISEN;
            alu_src_type = `NOT_R_TYPE;
            alu_op = `OP_NOP;
        end
    endcase 
end

endmodule