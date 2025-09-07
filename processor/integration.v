/*
this module connects the processor to the instruction and data memories
to view signals, set them as outputs
*/

module top_module (
    input clk,
    input reset,
    output reg [31:0] pc,
    output reg [31:0] write_data,
    output reg [31:0] data_addr
);

wire [31:0] instr;
wire [31:0] read_data;
wire mem_write;

processor riscv(
    .clk(clk),
    .reset(reset),
    .instr(instr),
    .read_data(read_data),
    .pc(pc),
    .data_addr(data_addr),
    .write_data(write_data),
    .mem_write(mem_write)
);

im instr_mem(
    .instr_addr(pc),
    .instr(instr)
);

dm data_mem(
    .clk(clk),
    .mem_write(mem_write),
    .rw_addr(data_addr),
    .write_data(write_data),
    .read_data(read_data)
);

endmodule