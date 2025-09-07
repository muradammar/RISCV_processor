`timescale 1ns/1ps

module tb_top;

    reg clk;
    reg reset;

    wire [31:0] pc;
    wire [31:0] write_data;
    wire [31:0] data_addr;

    // Instantiate the DUT (Device Under Test)
    top_module uut (
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .write_data(write_data),
        .data_addr(data_addr)
    );

    // Clock generation (10ns period = 100 MHz)
    always #5 clk = ~clk;

    initial begin
        // VCD dump setup
        $dumpfile("tb_top.vcd");      // name of dump file
        $dumpvars(0, tb_top);         // dump everything in tb_top hierarchy

        // Initialize
        clk = 0;
        reset = 1;

        // Hold reset for a few cycles
        #20;
        reset = 0;

        // Run for some cycles
        #200;

        $finish; // End simulation
    end

endmodule
