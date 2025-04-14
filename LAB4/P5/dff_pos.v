module dff_pos (D, clk, Q, Qnot, reset);
	input  [3:0] D;
	input	  clk, reset;
	output [3:0] Q, Qnot;
	reg    [3:0] Q, Qnot;
	
	always @ (posedge clk or posedge reset) begin
		if (reset) begin
			Q = 0;
			Qnot <= 1;
		end else begin
			Q <= D;
			Qnot <= ~D;
		end

	end 
endmodule