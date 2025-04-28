module top_level_tb;
    // Declare the signals that will be used for the testbench
    reg clk;
    reg reset;
    reg enable;
    wire [6:0] HEX0, HEX1, HEX2, HEX3;
    
    // Instantiate the top_level module
    top_level uut (
        .HEX0(HEX0),
        .HEX1(HEX1),
        .HEX2(HEX2),
        .HEX3(HEX3),
        .reset(reset),
        .enable(enable),
        .clk(clk)
    );

    // Clock generation (50 MHz)
    always begin
        #10 clk = ~clk;  // 10 time units for a period of 20 time units
    end
    
    // Stimulus block
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 0;
        enable = 0;
        
        // Display output values to observe in the simulation
        $monitor("Time = %0t | HEX0 = %b | HEX1 = %b | HEX2 = %b | HEX3 = %b", $time, HEX0, HEX1, HEX2, HEX3);
        
        // Test sequence
        #5 reset = 1;  // Apply reset
        #20 reset = 0; // Release reset
        
        #5 enable = 1; // Enable the counter
        
        // Simulate for a few cycles
        #200 enable = 0; // Disable the counter after 200 time units
        #40 enable = 1;  // Enable again
        
        // Finish simulation after a certain time
        #500 $finish; // End the simulation
    end
endmodule
