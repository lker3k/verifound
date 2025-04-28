module top_level(CLOCK_50, KEY, SW, HEX0, HEX1, HEX2, HEX3);
	
	
	input CLOCK_50;
	input [3:0] KEY;
	input [9:0] SW;
	
	/*
	input reset;
	input enable;
	input clk;
	*/
	
	output [6:0] HEX0, HEX1, HEX2, HEX3;
	
	wire enable, clk, clear;
	
	wire [15:0] q_reg;
	
	wire [15:0] t_reg;
	
	
	assign clk = KEY[0];
	assign enable = SW[1];
	assign clear = SW[0];
	
	assign t_reg[0] = enable;
	t_flip_flop t_flip0 (
	.t(t_reg[0]),
	.clk(clk),
	.rst(clear),
	.q(q_reg[0])
	); 
	
	genvar i;
	generate 
		for (i = 1; i < 16; i = i + 1) begin : t_loop
			assign t_reg[i] = t_reg[i - 1] & q_reg[i - 1];
		end
		for (i = 1; i < 16; i = i + 1) begin : q_loop
			t_flip_flop t_flip (
				.t(t_reg[i]),
				.clk(clk),
				.rst(clear),
				.q(q_reg[i])
				); 
		end
	endgenerate
	
	/*
	t_flip_flop t_flip0 (
		.t(t_reg[0]),
		.clk(clk),
		.rst(clear),
		.q(q_reg[0])
		);
		
	t_flip_flop t_flip1 (
		.t(t_reg[0]),
		.clk(clk),
		.rst(clear),
		.q(q_reg[1])
		);

	t_flip_flop t_flip2 (
		.t(t_reg[0]),
		.clk(clk),
		.rst(clear),
		.q(q_reg[2])
		);
		
	t_flip_flop t_flip3 (
		.t(t_reg[0]),
		.clk(clk),
		.rst(clear),
		.q(q_reg[3])
		);
		
	t_flip_flop t_flip4 (
		.t(t_reg[0]),
		.clk(clk),
		.rst(clear),
		.q(q_reg[4])
		);
		
	t_flip_flop t_flip5 (
		.t(enable & q_reg[4]),
		.clk(clk),
		.rst(clear),
		.q(q_reg[5])
		);

	t_flip_flop t_flip6 (
		.t(enable & q_reg[5]),
		.clk(clk),
		.rst(clear),
		.q(q_reg[6])
		);
		
	t_flip_flop t_flip7 (
		.t(enable & q_reg[6]),
		.clk(clk),
		.rst(clear),
		.q(q_reg[7])
		);
		
	t_flip_flop t_flip8 (
		.t(enable & q_reg[7]),
		.clk(clk),
		.rst(clear),
		.q(q_reg[8])
		);
	
	t_flip_flop t_flip9 (
		.t(enable & q_reg[8]),
		.clk(clk),
		.rst(clear),
		.q(q_reg[9])
		);

	t_flip_flop t_flip10 (
		.t(enable & q_reg[9]),
		.clk(clk),
		.rst(clear),
		.q(q_reg[10])
		);
		
	t_flip_flop t_flip11 (
		.t(enable & q_reg[10]),
		.clk(clk),
		.rst(clear),
		.q(q_reg[11])
		);
		
	t_flip_flop t_flip12 (
		.t(enable & q_reg[11]),
		.clk(clk),
		.rst(clear),
		.q(q_reg[12])
		);	
		
	t_flip_flop t_flip13 (
		.t(enable & q_reg[12]),
		.clk(clk),
		.rst(clear),
		.q(q_reg[13])
		);

	t_flip_flop t_flip14 (
		.t(enable & q_reg[13]),
		.clk(clk),
		.rst(clear),
		.q(q_reg[14])
		);
		
	t_flip_flop t_flip15 (
		.t(enable & q_reg[14]),
		.clk(clk),
		.rst(clear),
		.q(q_reg[15])
		);
		*/
	

	hex_to_seg hex0 (.hex(q_reg[3:0]), 
							.seg(HEX0));
	hex_to_seg hex1 (.hex(q_reg[7:4]), 
							.seg(HEX1));
	hex_to_seg hex2 (.hex(q_reg[11:8]), 
							.seg(HEX2));
	hex_to_seg hex3 (.hex(q_reg[15:12]), 
							.seg(HEX3));
	

endmodule