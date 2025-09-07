/*
the control unit is a combinational element that determines the
flow of data based on the specific instruction. it takes the function code 
of the instruction as input and outputs the 
*/

module control_unit(
    input [6:0] opcode,
    output reg reg_write,
    output reg [1:0] imm_src,
    output reg alu_src,
    output reg mem_write,
    output reg [1:0] result_src,
    output reg branch,
    output reg [1:0] alu_op,
    output reg jump
);

//concatenate all signals to a vector for easy assignment
reg [10:0] controls;

always @ (*) begin
    case (opcode)
        7'b0000011: controls = 11'b1_00_1_0_01_0_00_0;
        7'b0100011: controls = 11'b0_01_1_1_00_0_00_0;
        7'b0110011: controls = 11'b1_00_0_0_00_0_10_0;
        7'b1100011: controls = 11'b0_10_0_0_00_1_01_0;
        7'b0010011: controls = 11'b1_00_1_0_00_0_10_0;
        7'b1101111: controls = 11'b1_11_0_0_10_0_00_1;
    endcase
end

always @ (*) begin
    {reg_write, imm_src, alu_src, mem_write, result_src, branch, alu_op, jump} = controls;
end

endmodule



