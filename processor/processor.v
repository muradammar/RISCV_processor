/*
this module combines the datapath and the control unit to form a 
RISC-V RV32I single cycle processor. It can be interfaced with a data
and instruction memory to run a program. 
*/

module processor (
    input clk,
    input reset,
    input [31:0] instr, //from IM
    input [31:0] read_data, //from DM
    output wire [31:0] pc,
    output wire [31:0] data_addr,
    output wire [31:0] write_data,
    output wire mem_write
);

//datapath -> controller
wire zero;

//controller -> datapath
wire reg_write;
wire alu_src, pc_src;
wire [1:0] imm_src, result_src;
wire [3:0] alu_control;

main_control_unit control_unit_inst(
    .opcode(instr[6:0]),
    .funct7(instr[31:25]),
    .funct3(instr[14:12]),
    .zero(zero),
    .reg_write(reg_write),
    .imm_src(imm_src),
    .alu_src(alu_src),
    .pc_src(pc_src),
    .mem_write(mem_write),
    .result_src(result_src),
    .alu_control(alu_control)
);

datapath data_path(
    .instr(instr),
    .read_data(read_data),
    .clk(clk),
    .reset(reset),
    .result_src(result_src),
    .pc_src(pc_src),
    .alu_src(alu_src),
    .imm_src(imm_src),
    .alu_control(alu_control),
    .reg_write(reg_write),
    .alu_res(data_addr), //alu res serves as data_addr otherwise used internally
    .zero(zero),
    .PC(pc),
    .write_data(write_data)
);

endmodule

