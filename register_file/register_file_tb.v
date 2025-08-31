`timescale 1ns/1ps

module reg_file_tb();
    
    //inputs
    reg [4:0] reg1_addr;
    reg [4:0] reg2_addr;
    reg [4:0] regw_addr;
    reg [31:0] write_data;
    reg write_ena;
    reg clk;

    //outputs
    wire [31:0] reg1_data;
    wire [31:0] reg2_data;

    register_file dut(
        .reg1_addr(reg1_addr),
        .reg2_addr(reg2_addr),
        .regw_addr(regw_addr),
        .write_data(write_data),
        .write_ena(write_ena),
        .clk(clk),
        .reg1_data(reg1_data),
        .reg2_data(reg2_data)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin

        reg1_addr = 0;
        reg2_addr = 0;
        regw_addr = 0;
        write_data = 0;
        write_ena = 0;

        $dumpfile("reg_file_tb.vcd");
        $dumpvars(0, reg_file_tb);

        //read the first two registers
        #1
        reg1_addr = 5'b1;
        reg2_addr = 5'd2;

        //write to the first two registers
        #10
        write_ena = 1'b1;
        regw_addr = 5'b1;
        write_data = 32'h0000FFFF;
        #10
        regw_addr = 5'd2;
        write_data = 32'hFFFF0000;

        #10
        write_ena = 1'b0;

        //values on the first two register should be changed

        #20
        $finish;
        
    end
endmodule