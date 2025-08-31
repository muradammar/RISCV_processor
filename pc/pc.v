/*
the pc is simply a register with reset
*/

module pc(
    input [31:0] next_inst,
    input clk,
    input rst,
    output reg [31:0] cur_inst
);

always @ (posedge clk) begin
    if (rst) 
        cur_inst <= 32'b0;
    else 
        cur_inst <= next_inst;
end

endmodule