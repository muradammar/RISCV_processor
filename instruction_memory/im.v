/*
insturction memory will be treated as ROM and is assumed
to have the program loaded into it. The reads are combinational
and this it is not synchronized with the clock
*/

module im(
    input [31:0] instr_addr,
    output reg [31:0] instr
);

reg [31:0] RAM [63:0]; //max capacity = 64 32-bit instructions

//load program instructions from a text file
initial $readmemh("riscv_program.txt", RAM);

always @ (*) begin
    instr = RAM[instr_addr[31:2]]; //word alligned -> addresses should only be multiples of 4
end

endmodule