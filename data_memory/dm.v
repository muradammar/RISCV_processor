/*
the data memory has combinational reads
and clock synchronized writes and is thus a 
sequential element
*/

module dm(
    input clk, 
    input mem_write,
    input [31:0] rw_addr,
    input [31:0] write_data,
    output reg [31:0] read_data
);

reg [31:0] RAM [63:0]; //64 32-bit elements

//combinational reads
always @ (*) begin
    read_data = RAM[rw_addr[31:2]]; //word aligned
end

//sequential writes
always @ (posedge clk) begin
    if (mem_write) RAM[rw_addr[31:2]] <= write_data;
end

endmodule