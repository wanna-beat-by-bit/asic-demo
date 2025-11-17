# ASIC Demo

Some CPU related components will be presented in the project.

## TODO
- [x] alu
- [x] register file
- [ ] control unit
- [ ] core

## Goals

- testable units
- designed to be easily exntensible
- easy to build and run on any system (docker + Makefile)

## Usage

```
requirements:
1. docker

steps:
make dev-build
make dev

Then inside created container:
cd app
make test_all
make test_rf
make test_alu
```

## 🖼️ Current ALU Overview 

### Supported operation codes:

|code|description|ready|
|----|-|-|
|OP_SUM|+|✅|
|OP_SUB|-|✅|
|OP_AND|&|✅|
|OP_XOR|^|✅|
|OP_NOP|nop|✅|
|OT_INC|+1|🛠️|
|OT_DEC|-1|🛠️|
|OT_MUL|*|🛠️|
|OT_DIV|/|🛠️|
|OT_CMP| > < <= >= |🛠️|
|OT_NOT| ~ |🛠️|
|OT_MOV| [] -> [] |🛠️|
|OT_SHR| 10 -> 01 |🛠️|
|OT_SHL| 10 <- 01 |🛠️|

**WORD** size Dynamicly set through [specs](./src/specs.vh)
