`ifndef SPECS_VH
`define SPECS_VH

// opcode types
`define R_TYPE 0
`define NOT_R_TYPE 1
`define WR_EN 1
`define WR_DISEN 0

// RISC-V RV32I Base Instruction Set - All instructions with OP_* pattern

// Integer Register-Immediate Instructions (I-type)
`define OP_ADDI    6'b000000
`define OP_SLTI    6'b000001
`define OP_SLTIU   6'b000010
`define OP_XORI    6'b000011
`define OP_ORI     6'b000100
`define OP_ANDI    6'b000101
`define OP_SLLI    6'b000110
`define OP_SRLI    6'b000111
`define OP_SRAI    6'b001000

// Integer Register-Register Operations (R-type)
`define OP_ADD     6'b001001
`define OP_SUB     6'b001010
`define OP_SLL     6'b001011
`define OP_SLT     6'b001100
`define OP_SLTU    6'b001101
`define OP_XOR     6'b001110
`define OP_SRL     6'b001111
`define OP_SRA     6'b010000
`define OP_OR      6'b010001
`define OP_AND     6'b010010

// Load Instructions (I-type)
`define OP_LB      6'b010011
`define OP_LH      6'b010100
`define OP_LW      6'b010101
`define OP_LBU     6'b010110
`define OP_LHU     6'b010111

// Store Instructions (S-type)
`define OP_SB      6'b011000
`define OP_SH      6'b011001
`define OP_SW      6'b011010

// Branch Instructions (B-type)
`define OP_BEQ     6'b011011
`define OP_BNE     6'b011100
`define OP_BLT     6'b011101
`define OP_BGE     6'b011110
`define OP_BLTU    6'b011111
`define OP_BGEU    6'b100000

// Upper Immediate Instructions (U-type)
`define OP_LUI     6'b100001
`define OP_AUIPC   6'b100010

// Jump Instructions (J-type and I-type)
`define OP_JAL     6'b100011
`define OP_JALR    6'b100100

// System Instructions
`define OP_ECALL   6'b100101
`define OP_EBREAK  6'b100110

// supported cpu bit width
`define WORD 32

`define OP_WIDTH 6

`define REG_ADDRESS_SPACE 5

`define INS_ADDRESS_SPACE 4
`define INS_WIDTH 32

// opcode map
function string opname;
    input [`OP_WIDTH-1:0] op;
    case(op)
        `OP_ADDI: opname = "ADDI";
        `OP_SLTI: opname = "SLTI";
        `OP_SLTIU: opname = "SLTIU";
        `OP_XORI: opname = "XORI";
        `OP_ORI: opname = "ORI";
        `OP_ANDI: opname = "ANDI";
        `OP_SLLI: opname = "SLLI";
        `OP_SRLI: opname = "SRLI";
        `OP_SRAI: opname = "SRAI";
        `OP_ADD: opname = "ADD";
        `OP_SUB: opname = "SUB";
        `OP_SLL: opname = "SLL";
        `OP_SLT: opname = "SLT";
        `OP_SLTU: opname = "SLTU";
        `OP_XOR: opname = "XOR";
        `OP_SRL: opname = "SRL";
        `OP_SRA: opname = "SRA";
        `OP_OR: opname = "OR";
        `OP_AND: opname = "AND";
        `OP_LB: opname = "LB";
        `OP_LH: opname = "LH";
        `OP_LW: opname = "LW";
        `OP_LBU: opname = "LBU";
        `OP_LHU: opname = "LHU";
        `OP_SB: opname = "SB";
        `OP_SH: opname = "SH";
        `OP_SW: opname = "SW";
        `OP_BEQ: opname = "BEQ";
        `OP_BNE: opname = "BNE";
        `OP_BLT: opname = "BLT";
        `OP_BGE: opname = "BGE";
        `OP_BLTU: opname = "BLTU";
        `OP_BGEU: opname = "BGEU";
        `OP_LUI: opname = "LUI";
        `OP_AUIPC: opname = "AUIPC";
        `OP_JAL: opname = "JAL";
        `OP_JALR: opname = "JALR";
        `OP_ECALL: opname = "ECALL";
        `OP_EBREAK: opname = "EBREAK";
        default: opname = "???";
    endcase
endfunction

`endif // SPECS_VH
