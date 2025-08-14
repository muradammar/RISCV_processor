/* 
The ALU is a purely combinational element that executes an
operation on the two input words specified by the alu opcode
the zero output is asserted when the result is 32'b0
*/

module alu(
    input [31:0] r1,
    input [31:0] r2,
    input [3:0] alu_op,
    output reg [31:0] result,
    output zero
);

always @ (*) begin
    case (alu_op)
        4'b0000: result <= r1 & r2;
        4'b0001: result <= r1 | r2;
        4'b0010: result <= r1 + r2;
        4'b0110: result <= r1 - r2;
        4'b0111: result <= r1 < r2 ? 32'd1 : 32'd0;
        4'b1100: result <= ~(r1 | r2);
        default: result <= 32'd0;
    endcase
end

assign zero = (result == 32'd0);

endmodule