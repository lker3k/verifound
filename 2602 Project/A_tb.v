`timescale 1ns / 1ps

module A_tb;

  reg [2:0] bus;
  reg a_in, clk, rst;
  wire [2:0] A;

  // Instantiate module A
  A uut (
    .bus(bus),
    .a_in(a_in),
    .clk(clk),
    .rst(rst),
    .A(A)
  );

  // Generate clock
  always #5 clk = ~clk;

  initial begin
    // Initialize
    clk = 0; rst = 0; a_in = 0; bus = 3'b000;

    // Reset the register
    #10 rst = 1;
    #10 rst = 0;

    // Load value into register A
    #10 bus = 3'b101; a_in = 1;
    #10 a_in = 0;

    // Change bus to check register holds old value
    #10 bus = 3'b010;

    // Apply reset again
    #10 rst = 1;
    #10 rst = 0;

    // Finish
    #10 $finish;
  end

  initial begin
    $monitor("Time=%0t | clk=%b | rst=%b | a_in=%b | bus=%b | A=%b",
              $time, clk, rst, a_in, bus, A);
  end

endmodule
