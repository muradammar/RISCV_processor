/*
the register file stores 32 words (32 x 32 array)
x0 is hardwired to zero and cannot have anything written 
to it. the register reads are purely combinational
and therefore, do not depend on the clk. The reg write
is synchronized with the clk. 

***
might implement write-through behaviour if needed
this is when the reads immediately reflect the value of a write
instead of a 1 clock cycle delay. 
*/

module register_file(
    input [4:0] reg1_addr,
    input [4:0] reg2_addr,
    input [4:0] regw_addr,
    input [31:0] write_data,
    input write_ena,
    input clk,
    output reg [31:0] reg1_data,
    output reg [31:0] reg2_data
);

//RAM can be modelled as 32 element array
//where each element is 32 bits wide
reg [31:0] reg_mem [31:0];

//read are combinational
always @ (*) begin
    reg1_data = reg1_addr == 0 ? 32'b0 : reg_mem[reg1_addr];
    reg2_data = reg2_addr == 0 ? 32'b0 : reg_mem[reg2_addr];
end

//writes are clock synchronized
always @ (posedge clk) begin
    if (write_ena && regw_addr != 5'b0) begin
        reg_mem[regw_addr] <= write_data;
    end
end

endmodule