module xor_alu (a, b, g, rst);

	input [15:0] a, b;
	output reg [15:0] g;
	
	input rst;
	
	
	always @(*) begin
		if (rst) begin
			g = 0;
		end else begin
			g = a ^ b;
		end
	end
	

endmodule