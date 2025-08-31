module mux3 #(parameter WIDTH = 32) (
    input [1:0] sel,
    input [WIDTH-1:0] a, b, c,
    output reg [WIDTH-1:0] out
);

always @ (*) begin
    case (sel)
        2'b00: out = a;
        2'b01: out = b;
        2'b10: out = c;
        default: out = a;
    endcase
end

endmodule 