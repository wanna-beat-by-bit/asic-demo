# CPU-Core Educational Roadmap

## Project Goal
Build a minimal, working RISC-V-like CPU that demonstrates core concepts without full complexity. This is a learning project, not a production implementation.

---

## Current Status Summary

### ✅ What's Working
- **ALU**: 5 operations (add, sub, and, xor, nop) with flags
- **Register File**: 32 registers, read/write working perfectly
- **Program Counter**: Sequential instruction fetching
- **Test Framework**: All component tests pass

### ❌ What's Broken
- **CPU Top Module**: Won't compile (syntax errors)
- **Instruction Decoding**: Control unit incomplete
- **Integration**: Components not properly connected

---

## Roadmap: From Current State to Working CPU

### Phase 1: Get Basic CPU Running (PRIORITY)
**Goal**: Execute simple R-type instructions (register-to-register operations)

**Steps:**
1. **Fix CPU module syntax errors** ⚠️ BLOCKING
   - Fix semicolons/commas in port connections
   - Complete wire declarations
   - Make it compile

2. **Implement minimal instruction decoding**
   - Support only R-type instructions (add, sub, and, xor)
   - Extract rs1, rs2, rd from instruction
   - Ignore immediate values for now

3. **Complete execution flow**
   - PC → ROM → Control Unit → Register File + ALU → Write Back
   - Wire everything together properly
   - Single-cycle execution

4. **Create first working program**
   - Write 3-5 simple R-type instructions
   - Test: add two registers, store result
   - Verify with test module

**Outcome**: A CPU that can execute: `add x3, x1, x2` (register operations only)

**Learning**: Understand fetch-decode-execute cycle with real working code

---

### Phase 2: Add Immediate Instructions (I-type)
**Goal**: Support operations with constant values

**Steps:**
1. **Add immediate value extraction**
   - Decode 12-bit immediate from instruction
   - Support I-type instruction format

2. **Extend control unit**
   - Detect I-type vs R-type
   - Add MUX to select register vs immediate

3. **Support addi, andi, xori**
   - Example: `addi x3, x1, 100` (add immediate)

4. **Create test program**
   - Load constants into registers
   - Perform calculations with immediates

**Outcome**: CPU can work with constants, not just register values

**Learning**: Understand instruction formats and immediate encoding

---

### Phase 3: Add Branching (B-type)
**Goal**: Make decisions and create loops

**Steps:**
1. **Implement comparison in ALU**
   - Add compare operation (equality, less-than)
   - Use existing zero flag and add sign flag

2. **Add branch logic**
   - Decode B-type instructions (beq, bne)
   - Calculate PC-relative target address
   - Conditionally update PC

3. **Create first loop**
   - Write program that counts 1 to 10
   - Use branch to repeat

**Outcome**: CPU can make decisions and loop

**Learning**: Understand control flow and conditional execution

---

### Phase 4: Add Memory Operations (Load/Store)
**Goal**: Read and write data memory

**Steps:**
1. **Create data memory module**
   - Simple RAM (16-32 words)
   - Read and write ports

2. **Implement load/store instructions**
   - `lw` (load word): read from memory to register
   - `sw` (store word): write register to memory

3. **Create test program**
   - Store values to memory
   - Load them back
   - Verify data persistence

**Outcome**: CPU can use RAM for data storage

**Learning**: Understand memory hierarchy and data access

---

### Phase 5: Complete Basic Instruction Set
**Goal**: Round out common operations

**Steps:**
1. **Add remaining ALU operations**
   - Shift left/right (sll, srl)
   - OR operation
   - Set-less-than (slt)

2. **Add jump instructions**
   - `jal` (jump and link) for function calls
   - `jalr` (jump register)

3. **Extend branches**
   - `blt`, `bge` (signed comparisons)
   - `bltu`, `bgeu` (unsigned comparisons)

**Outcome**: CPU can run real programs with functions

**Learning**: Complete picture of RISC-V instruction types

---

## Simplified Instruction Set (Educational Subset)

### Minimum for Learning (Phases 1-3):
```
R-type:  add, sub, and, xor
I-type:  addi, andi
B-type:  beq, bne
```
**Total: 7 instructions** - Enough to understand CPU fundamentals!

### Extended Set (Phases 4-5):
```
Load/Store: lw, sw
Shifts:     sll, srl
Compare:    slt, sltu
Jumps:      jal, jalr
Branches:   blt, bge, bltu, bgeu
Logic:      or, ori
```
**Total: ~20 instructions** - Covers most common patterns

---

## What We're Skipping (Not Needed for Learning)

❌ **Full RISC-V Compliance**: We use RISC-V-like encoding, but skip complex details
❌ **Multiply/Divide**: Hardware multiplication is complex
❌ **Pipelining**: Your pipeline_alu is ready, but single-cycle is easier to understand first
❌ **Exceptions/Interrupts**: Advanced topic
❌ **CSR Instructions**: System-level programming
❌ **Fence/Atomic Operations**: Multiprocessor features
❌ **Compressed Instructions**: 16-bit encoding (RVC extension)

---

## Recommended Timeline

### Week 1: Phase 1 - Get Something Working
- Fix CPU module
- Run first instruction
- **Milestone**: See registers change values!

### Week 2: Phase 2 - Add Immediates
- Decode I-type
- Use constants in code
- **Milestone**: Calculate Fibonacci with constants

### Week 3: Phase 3 - Add Branches
- Implement beq/bne
- Write first loop
- **Milestone**: Count to 100 in a loop

### Week 4: Phase 4 - Add Memory
- Create RAM module
- Load/store instructions
- **Milestone**: Bubble sort array in memory

### Week 5+: Phase 5 - Complete Instruction Set
- Add remaining operations
- Write complex programs
- **Milestone**: Run recursive Fibonacci function

---

## Success Criteria

### Minimum Viable CPU (Phase 1-3 Complete):
✅ Can execute R-type and I-type instructions
✅ Can branch and loop
✅ Register file working correctly
✅ Can write simple programs (add numbers, count, etc.)
✅ All tests passing

### Full Educational CPU (All Phases):
✅ Can execute ~20 core RISC-V instructions
✅ Can use memory for data storage
✅ Can call functions with jal/jalr
✅ Can run real algorithms (sorting, recursion)
✅ You understand how CPUs work!

---

## Next Steps

**Immediate Action**: Start with Phase 1, Step 1
- Fix the syntax errors in `/src/cpu.v`
- Get it to compile
- Then we'll connect the pieces and run first instruction

**Question to Consider**: 
- Do you want to dive in and fix things yourself (I can guide)?
- Or should I fix Phase 1 and show you what a working CPU looks like?

The choice is yours - both paths will teach you a lot!

---

## Learning Resources While Building

As you work through phases, you'll naturally learn:
- **Phase 1**: Fetch-decode-execute cycle
- **Phase 2**: Instruction encoding formats
- **Phase 3**: Control flow and program counter manipulation
- **Phase 4**: Memory hierarchy and addressing
- **Phase 5**: Function calls and stack operations

Each phase builds on the previous one, so by the end you'll have a complete mental model of how processors work!
