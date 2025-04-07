module d_latch (D, clk, Q, Qnot);
	input  D, clk;
	output Q, Qnot;
	reg    Q, Qnot;
	
	always @ (clk or D) begin
		if (clk) begin
			Q <= D;
			Qnot <= ~D;
		end
	end 
	
endmodule