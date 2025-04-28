module top_level_2(CLOCK_50, KEY, SW, HEX0, HEX1, HEX2, HEX3);
	
	
	input CLOCK_50;
	input [3:0] KEY;
	input [9:0] SW;
	
	output [6:0] HEX0, HEX1, HEX2, HEX3;
	
	wire clk, reset, enable;
	
	assign clk = KEY[0];
	assign reset = SW[0];
	assign enable = SW[1];
	
	reg [15:0] Q;
	
	// 1st counter
	always @(posedge clk) begin
		if (reset) begin
			Q <= 0;
		end else if (enable) begin
			Q <= Q+1;
		end 
	end

	
	hex_to_seg hex0 (.hex(Q[3:0]), 
							.seg(HEX0));
	hex_to_seg hex1 (.hex(Q[7:4]), 
							.seg(HEX1));
	hex_to_seg hex2 (.hex(Q[11:8]), 
							.seg(HEX2));
	hex_to_seg hex3 (.hex(Q[15:12]), 
							.seg(HEX3));
	
endmodule 