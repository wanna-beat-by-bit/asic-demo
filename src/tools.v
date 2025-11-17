// ASSERT is a non blocking test function.
`define ASSERT(condition, name, message) \
    if (condition) begin \
        $display("✅ PASS TEST '%s'", name); \
    end else begin \
        $display("❌ ERROR TEST '%s': %s", name, message); \
    end
