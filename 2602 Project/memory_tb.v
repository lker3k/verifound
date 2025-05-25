`timescale 1ns / 1ps

module memory_tb;

  // Inputs
  reg clk;
  reg rst;
  reg branch;
  reg [5:0] branchaddress;

  // Output
  wire [7:0] instruction;

  // Instantiate the memory module
  memory uut (
    .clk(clk),
    .rst(rst),
    .branch(branch),
    .branchaddress(branchaddress),
    .instruction(instruction)
  );

  // Clock generation (10 ns period)
  always #5 clk = ~clk;

  initial begin
    // Initialize
    clk = 0;
    rst = 0;
    branch = 0;
    branchaddress = 6'b0;

    $display("Time | PC | Instruction");
    $monitor("%4t | %b | %b", $time, uut.pc, instruction);

    // Apply reset
    #3 rst = 1;
    #10 rst = 0;

    // Let PC increment normally
    #40;

    // Trigger branch to address 2
    #1 branchaddress = 6'b000010; branch = 1;
    #10 branch = 0;

    // Let it continue
    #30;

    // Branch to address 0 (loop)
    #1 branchaddress = 6'b000000; branch = 1;
    #10 branch = 0;

    // Let it run again
    #30;

    $finish;
  end

endmodule
