`timescale 1ns / 1ps

module tb_L6;

    reg clk;
    reg w;
    reg rst;
    wire [1:0] z;

    // Instantiate the FSM module
    L6 uut (
        .clk(clk),
        .w(w),
        .rst(rst),
        .z(z)
    );

    // Clock generation: 10 ns period
    always #5 clk = ~clk;

    initial begin
        $display("Time\tclk\trst\tw\tz");
        $monitor("%0t\t%b\t%b\t%b\t%b", $time, clk, rst, w, z);

        // Initialize signals
        clk = 0;
        rst = 1;
        w = 0;

        // Hold reset high for a few cycles
        #10;
        rst = 0;

        // Test sequence: apply various w values
        #10 w = 0;
        #10 w = 0;
        #10 w = 0;
        #10 w = 0;
        #10 w = 0;  // Should stay in E and output z = 1
        #10 w = 1;  // Go to F
        #10 w = 1;  // G
        #10 w = 1;  // H
        #10 w = 1;  // I (z = 1)
        #10 w = 0;  // Back to B
        #10 w = 1;  // F
        #10 w = 0;  // B

        // Finish simulation
        #20;
        $finish;
    end

endmodule