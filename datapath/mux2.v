module mux2 #(parameter WIDTH = 32) (
    input sel,
    input [WIDTH-1:0] a, b,
    output reg [WIDTH-1:0] out
);

always @ (*) begin
    case (sel)
        1'b0: out = a;
        1'b1: out = b;
    endcase
end

endmodule
