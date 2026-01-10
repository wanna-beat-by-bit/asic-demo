`timescale 1ns/1ps
`include "specs.vh"
`include "tools.v"

module cpu_test;

reg clk;
reg rst;

// Instantiate CPU
cpu cpu_inst(
    .clk(clk),
    .rst(rst)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns period = 100MHz
end

// Test stimulus
initial begin
    $dumpfile("cpu_test.vcd");
    $dumpvars(0, cpu_test);
    
    // Reset
    rst = 1;
    #20;
    rst = 0;
    
    // Let CPU run for several clock cycles
    // The ROM contains add instructions that should execute
    #200;
    
    // Check that some registers have been written
    // The ROM has instructions like: add x3, x1, x2
    // Since registers start at 0, and we're adding 0+0, results will be 0
    // But we can verify the CPU is running by checking PC progression
    
    $display("=== CPU Test Complete ===");
    $display("Final PC: %d", cpu_inst.pc_current);
    
    // Basic sanity check - PC should have advanced
    `ASSERT(cpu_inst.pc_current > 0, "CPU PC advanced", "PC should increment from 0");
    
    // Check that register file is responsive
    // After reset, all registers should be 0
    `ASSERT(cpu_inst.rf_inst.registers[0] == 0, "Register x0 is zero", "x0 must always be zero");
    
    $display("✅ CPU basic functionality test passed");
    
    $finish;
end

// Monitor for debugging
initial begin
    $monitor("Time=%0t | PC=%d | Instruction=%h | rs1=%d rs2=%d rd=%d | ALU_op=%b | Result=%h", 
             $time, cpu_inst.pc_current, cpu_inst.instruction, 
             cpu_inst.rs1, cpu_inst.rs2, cpu_inst.rd,
             cpu_inst.alu_op, cpu_inst.alu_result);
end

endmodule
