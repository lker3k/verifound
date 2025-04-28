module timer(CLOCK_50, SW, HEX0, HEX1, HEX2, HEX3);
	
	
	input CLOCK_50;
	input [9:0] SW;
	
	output [6:0] HEX0, HEX1, HEX2, HEX3;
	
	wire clk, reset, enable;
	
	assign clk = CLOCK_50;
	assign reset = SW[0];
	assign enable = SW[1];
	
	reg [25:0] Q;
	reg [15:0] t;
	
	// 1st counter
	always @(posedge clk) begin
		if (reset) begin
			Q <= 0;
			t <= 0;
		end else if (enable) begin
			Q <= Q+1;
			
			//timer
			if (Q >= 50000000) begin
				t <= t + 1;
				Q <= 0;
			end
		end 
	end
	
	
	hex_to_seg hex0 (.hex(t[3:0]), 
							.seg(HEX0));
	hex_to_seg hex1 (.hex(t[7:4]), 
							.seg(HEX1));
	hex_to_seg hex2 (.hex(t[11:8]), 
							.seg(HEX2));
	hex_to_seg hex3 (.hex(t[15:12]), 
							.seg(HEX3));
	
endmodule 