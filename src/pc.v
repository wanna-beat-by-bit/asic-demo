module pc #(
    parameter WIDTH = 4
)(
    input wire clk,
    input wire rst,
    input wire [WIDTH-1:0] next_pc,
    output reg [WIDTH-1:0] current_pc
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        current_pc <= 0;
    end else begin
        current_pc <= next_pc; 
    end
end

endmodule