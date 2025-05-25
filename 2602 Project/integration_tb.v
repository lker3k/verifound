`timescale 1ns / 1ps

module integration_tb;

  reg clk;
  reg rst;

  // Instantiate the DUT (Device Under Test)
  integration uut (
    .clk(clk),
    .rst(rst)
  );

  // Clock generation (10 ns period)
  always #5 clk = ~clk;

  initial begin
    $display("Time | Instruction | Bus | Done | Enable | Tri_en");
    $monitor("%4t | %b | %b | %b | %b | %b", 
             $time, uut.instruction, uut.bus, uut.done, uut.enable, uut.tri_en);

    // Initialize
    clk = 0;
    rst = 0;

    // Hold reset
    #10 rst = 0;

    // Release reset
    #10 rst = 1;

    // Run simulation
    #300;

    $finish;
  end

endmodule
