`timescale 1ns / 1ps

module xor_alu_tb;

  // Inputs
  reg [15:0] a, b;
  reg rst;

  // Output
  wire [15:0] g;

  // Instantiate the DUT (Device Under Test)
  xor_alu uut (
    .a(a),
    .b(b),
    .g(g),
    .rst(rst)
  );

  initial begin
    // Initialize inputs
    a = 16'b0; b = 16'b0; rst = 0;

    // Apply test vectors
    #10 a = 16'b0000_0000_0001; b = 16'b0000_0000_0011; rst = 0;  // g = 010
    #10 a = 16'b0000_0000_0101; b = 16'b0000_0000_0001; rst = 0;  // g = 100
    #10 a = 16'b0000_0000_0111; b = 16'b0000_0000_0111; rst = 0;  // g = 000
    #10 rst = 1;                          // g = 000 (reset)
    #10 rst = 0; a = 16'b0000_0000_0010; b = 16'b0000_0000_0110;  // g = 100
    #10 a = 16'b0000_0000_0100; b = 16'b0000_0000_0001;          // g = 101

    // Finish simulation
    #10 $finish;
  end

  initial begin
    $monitor("Time=%0t | rst=%b | a=%b (%d) | b=%b (%d) | g=%b (%d)", 
              $time, rst, a, a, b, b, g, g);
  end

endmodule
