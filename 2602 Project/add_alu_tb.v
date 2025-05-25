`timescale 1ns / 1ps

module add_alu_tb;

  // Declare testbench variables
  reg [15:0] a, b;
  reg rst;
  wire [15:0] g;

  // Instantiate the Unit Under Test (UUT)
  add_alu uut (
    .a(a),
    .b(b),
    .g(g),
    .rst(rst)
  );

  initial begin
    // Initialize inputs
    a = 0; b = 0; rst = 0;

    // Wait and observe normal operation
    #10 a = 3; b = 2; rst = 0;  // g = 5
    #10 a = 1; b = 6; rst = 0;  // g = 7
    #10 rst = 1;                // g = 0 (reset)
    #10 rst = 0; a = 2; b = 2;  // g = 4
    #10 a = 7; b = 1;           // g = 0 (overflow for 3-bit add)
    
    // Finish simulation
    #10 $finish;
  end

  initial begin
    $monitor("Time=%0t | rst=%b | a=%b (%d) | b=%b (%d) | g=%b (%d)", 
              $time, rst, a, a, b, b, g, g);
  end

endmodule
