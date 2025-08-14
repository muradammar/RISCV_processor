module alu_tb();

    reg [31:0] r1;
    reg [31:0] r2;
    reg [3:0] alu_op;
    wire [31:0] result;

    alu alu_test(
        .r1(r1),
        .r2(r2),
        .alu_op(alu_op),
        .result(result)
    );

    initial begin
        $dumpfile("alu_tb.vcd");
        $dumpvars(0, alu_tb);
        $monitor("Time=%0t | r1=%d | r2=%d | alu_op=%b | result=%d", $time, r1, r2, alu_op, result);

        alu_op <= 4'b0000;
        r1 <= 32'd0;
        r2 <= 32'd1;

        #10

        r1 <= 32'd1; 
    end

endmodule