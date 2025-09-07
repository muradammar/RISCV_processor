/*
This module encloses all parts of the CPU excluding
the control unit, instruction memory, and data memory
*/

module datapath(
    input [31:0] instr,
    input [31:0] read_data,
    input clk,
    input reset,
    input [1:0] result_src,
    input pc_src, alu_src,
    input [1:0] imm_src,
    input [3:0] alu_control,
    input reg_write,
    output reg [31:0] alu_res,
    output reg zero,
    output reg [31:0] PC, //address of the cur instr
    output reg [31:0] write_data
);

//program counter
reg [31:0] pc_plus4; //the default next instruction to be executed
reg [31:0] pc_target; //the instruction address from a BEQ or JAL instruction
reg [31:0] pc_next; //the mux between the two above 

pc program_counter (
    .next_inst(pc_next),
    .clk(clk),
    .rst(reset),
    .cur_inst(PC)
);

adder #(32) pcadd4( //increment instr address
    .a(PC),
    .b(32'd4),
    .out(pc_plus4)
);

adder #(32) pcaddtarget( //determine target instr address 
    .a(PC),
    .b(immext),
    .out(pc_target)
);

mux2 #(32) pcmux( //determine next instr address based on pc_src
    .sel(pc_src),
    .a(pc_plus4),
    .b(pc_target),
    .out(pc_next)
);

//register file
reg [31:0] srcA, srcB, immext;

register_file reg_file (
    .reg1_addr(instr[19:15]), //rs1
    .reg2_addr(instr[24:20]), //rs2
    .regw_addr(instr[11:7]), //rd
    .clk(clk),
    .write_ena(reg_write),
    .write_data(result), //from mux3
    .reg1_data(srcA),
    .reg2_data(write_data)
);

extend imm_extend (
    .instr(instr[31:7]),
    .immsrc(imm_src),
    .immext(immext)
);

mux2 #(32) alumux(
    .sel(alu_src),
    .a(write_data),
    .b(immext),
    .out(srcB)
);

//ALU
wire [31:0] result;

alu ALU(
    .r1(srcA),
    .r2(srcB),
    .alu_op(alu_control),
    .result(alu_res),
    .zero(zero)
);

mux3 #(32) resultmux(
    .sel(result_src),
    .a(alu_res),
    .b(read_data),
    .c(pc_plus4),
    .out(result)
);


endmodule

