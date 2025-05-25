`timescale 1ns / 1ps

module xor_alu_tb;

  // Inputs
  reg [2:0] a, b;
  reg rst;

  // Output
  wire [2:0] g;

  // Instantiate the DUT (Device Under Test)
  xor_alu uut (
    .a(a),
    .b(b),
    .g(g),
    .rst(rst)
  );

  initial begin
    // Initialize inputs
    a = 3'b000; b = 3'b000; rst = 0;

    // Apply test vectors
    #10 a = 3'b001; b = 3'b011; rst = 0;  // g = 010
    #10 a = 3'b101; b = 3'b001; rst = 0;  // g = 100
    #10 a = 3'b111; b = 3'b111; rst = 0;  // g = 000
    #10 rst = 1;                          // g = 000 (reset)
    #10 rst = 0; a = 3'b010; b = 3'b110;  // g = 100
    #10 a = 3'b100; b = 3'b001;          // g = 101

    // Finish simulation
    #10 $finish;
  end

  initial begin
    $monitor("Time=%0t | rst=%b | a=%b (%d) | b=%b (%d) | g=%b (%d)", 
              $time, rst, a, a, b, b, g, g);
  end

endmodule
