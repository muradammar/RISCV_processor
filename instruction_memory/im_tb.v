`timescale 1ns/1ps

module top_module();

reg [31:0] instr_addr;
wire [31:0] instr;

im dut(
    .instr_addr(instr_addr),
    .instr(instr)
);

initial begin

$dumpfile("im_tb.vcd");
$dumpvars(0, top_module);

instr_addr = 6'd0;

#20 instr_addr = 6'd4;

#20 instr_addr = 6'd8;

#20 instr_addr = 6'd12;

#20 $finish;

end

endmodule 