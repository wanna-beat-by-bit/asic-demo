`define ASSERT(condition, name, message) \
    if (condition) begin \
        $display("✅ PASS TEST '%s'", name); \
    end else begin \
        $display("❌ ERROR TEST '%s': %s", name, message); \
    end

// `define REQUIRE(condition, message) \
//     if (condition) begin \
//         $display("✅ PASS: %s", message); \
//     end else begin \
//         $display("🛑 CRITICAL ERROR: %s", message); \
//         $display("🛑 Завершение симуляции..."); \
//         $finish; \
//     end

