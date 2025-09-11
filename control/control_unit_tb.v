`timescale 1ns/1ps

module control_unit_tb ();

reg [6:0] opcode;
wire reg_write;
wire [1:0] imm_src;
wire alu_src;
wire mem_write;
wire [1:0] result_src;
wire branch;
wire [1:0] alu_op;
wire jump;

control_unit dut(
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

initial begin

    $dumpfile("control_unit_tb.vcd");
    $dumpvars(0, control_unit_tb);

    //load word 
    opcode = 7'b0000011;

    //store word
    #10
    opcode = 7'b0100011;

    //R-type
    #10
    opcode = 7'b0110011;

    //beq
    #10 
    opcode = 7'b1100011;

    //I-type ALU
    #10
    opcode = 7'b0010011;

    //jal
    #10 
    opcode = 7'b1101111;

    #10
    $finish;
end

endmodule