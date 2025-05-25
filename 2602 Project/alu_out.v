module alu_out (G, clk, rst, G_in, G_out, alu_in);
	
	input clk, rst;
	
	input G_in, G_out;
	input [2:0] alu_in;
	
	output [2:0] G;
	
	reg [2:0] g;
	
	assign G = (G_out)? g : 3'bzzz;
	
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			g <= 0;
		end else if (G_in) begin
			g <= alu_in;
		end
	end
	
endmodule