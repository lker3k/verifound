module A (A, bus, a_in, clk, rst);
	input [2:0] bus;
	input a_in;
	input clk, rst;
	
	output [2:0] A;
	
	reg [2:0] a;
	
	assign A = a;
	
	always @(posedge clk) begin
		if (rst) begin
			a <= 3'b0;
		end else if (a_in) begin
			a <= bus;
		end
	end
	
	
endmodule