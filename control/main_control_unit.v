/*
This higher level module instantiates the alu control unit and main control unit 
to provide all control signals for the processor. this modularity makes it much easier
to add more instruction while keeping the complexity lower
*/

module main_control_unit(
    input [6:0] opcode,
    input [6:0] funct7,
    input [2:0] funct3,
    input zero, //from datapath
    output reg reg_write,
    output reg [1:0] imm_src,
    output reg alu_src,
    output reg pc_src,
    output reg mem_write,
    output reg [1:0] result_src,
    output reg [3:0] alu_control
);

    wire [1:0] alu_op; //this signal is used to control the alu_control
    wire branch, jump;

    control_unit control (
        .opcode(opcode),
        .reg_write(reg_write),
        .imm_src(imm_src),
        .alu_src(alu_src),
        .mem_write(mem_write),
        .result_src(result_src),
        .branch(branch),
        .alu_op(alu_op),
        .jump(jump)
    );

    alu_control alu_ctl (
        .opcode(opcode),
        .funct7(funct7),
        .funct3(funct3),
        .alu_op(alu_op),
        .alu_control(alu_control)
    );

    //use target instr addr if branch is true or if jal
    assign pc_src = branch & zero | jump;

endmodule
