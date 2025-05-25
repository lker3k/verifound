`timescale 1ns / 1ps

module register_tb;

  reg clk;
  reg R_in, R_out, rst;
  wire [15:0] bus;

  reg [15:0] bus_driver;
  reg bus_drive_en;
  assign bus = (bus_drive_en) ? bus_driver : 16'bz;

  // Instantiate the register module
  register uut (
    .clk(clk),
    .R_in(R_in),
    .R_out(R_out),
    .rst(rst),
    .bus(bus)
  );

  // Clock generation
  always #5 clk = ~clk;

  initial begin
    // Initialize
    clk = 0; R_in = 0; R_out = 0; rst = 0;
    bus_driver = 16'b0; bus_drive_en = 0;

    // Apply reset
    #10 rst = 1;
    #10 rst = 0;

    // Load value onto bus and write into register
    #10 bus_driver = 16'b0000_0000_0101; bus_drive_en = 1; R_in = 1;
    #10 R_in = 0; bus_drive_en = 0;

    // Read from register to bus
    #10 R_out = 1;
    #10 R_out = 0;

    // Apply another reset and test again
    #10 rst = 1;
    #10 rst = 0;
    #10 R_out = 1; // Should drive 0 onto bus
    #10 R_out = 0;

    // Finish
    #10 $finish;
  end

  initial begin
    $monitor("Time=%0t | clk=%b | rst=%b | R_in=%b | R_out=%b | bus=%b", 
              $time, clk, rst, R_in, R_out, bus);
  end

endmodule
