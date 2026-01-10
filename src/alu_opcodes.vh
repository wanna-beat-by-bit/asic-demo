`ifndef ALU_OPCODES_VH
`define ALU_OPCODES_VH

`define ALU_WIDTH 4

`define ALU_ADD 4'b0000
`define ALU_SUB 4'b0001
`define ALU_AND 4'b0010
`define ALU_OR 4'b0011
`define ALU_XOR 4'b0100
`define ALU_SLL 4'b0101
`define ALU_SRL 4'b0110
`define ALU_SRA 4'b0111
`define ALU_SLT 4'b1000
`define ALU_SLTU 4'b1001
`define ALU_NOP 4'b1111

function string alu_opname;
    input [`OP_WIDTH-1:0] op;
    case(op)
        `ALU_ADD: alu_opname = "ADD";
        `ALU_SUB: alu_opname = "SUB";
        `ALU_SLL: alu_opname = "SLL";
        `ALU_SLT: alu_opname = "SLT";
        `ALU_SLTU: alu_opname = "SLTU";
        `ALU_XOR: alu_opname = "XOR";
        `ALU_SRL: alu_opname = "SRL";
        `ALU_SRA: alu_opname = "SRA";
        `ALU_OR: alu_opname = "OR";
        `ALU_AND: alu_opname = "AND";
        default: alu_opname = "???";
    endcase
endfunction

`endif
