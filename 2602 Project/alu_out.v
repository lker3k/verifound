module alu_out (G, clk, rst, G_in, G_out, alu_in);
	
	input clk, rst;
	
	input G_in, G_out;
	input [15:0] alu_in;
	
	output [15:0] G;
	
	reg [15:0] g;
	
	assign G = (G_out)? g : 16'bz;
	
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			g <= 0;
		end else if (G_in) begin
			g <= alu_in;
		end
	end
	
endmodule