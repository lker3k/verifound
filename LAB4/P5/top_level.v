module top_level(SW, LEDR, HEX0, HEX1, HEX2, HEX3, KEY);

	input [9:0] SW;
	input [3:0] KEY;
	output [9:0] LEDR;
	output [6:0] HEX0, HEX1, HEX2, HEX3;
	
	wire [7:0] qb, qnb, sa, sna;
	
	
	dff_pos d_flip_4_bit1 (.D(sa[3:0]), .clk(~KEY[1]), .reset(~KEY[0]), .Q(qb[3:0]), .Qnot(qnb[3:0]));
	
	dff_pos d_flip_4_bit2 (.D(sa[7:4]), .clk(~KEY[1]), .reset(~KEY[0]), .Q(qb[7:4]), .Qnot(qnb[7:4]));
	
	dff_pos d_flip_4_bit3 (.D(SW[3:0]), .clk(~KEY[1]), .reset(~KEY[0]), .Q(sa[3:0]), .Qnot(sna[3:0]));
	
	dff_pos d_flip_4_bit4 (.D(SW[7:4]), .clk(~KEY[1]), .reset(~KEY[0]), .Q(sa[7:4]), .Qnot(sna[7:4]));
	
	hex_to_seg h_s0 (.hex(sa[3:0]), .seg(HEX0));
	hex_to_seg h_s1 (.hex(sa[7:4]), .seg(HEX1));
	hex_to_seg h_s2 (.hex(qb[3:0]), .seg(HEX2));
	hex_to_seg h_s3 (.hex(qb[7:4]), .seg(HEX3));
	
	
endmodule 