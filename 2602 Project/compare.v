module compare (a, b, g, rst);

	input [2:0] a, b;
	output reg g;
	
	input rst;
	
	
	always @(*) begin
		if (rst) begin
			g = 0;
		end else begin
			if (a == b) begin
				g = 1;
			end else begin
				g = 0;
			end
		end
	end
	

endmodule