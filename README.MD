# CPU-CORE
Trying to implement RISC-V like core

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
```
Latter add support on running test for sepparate modules.

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
