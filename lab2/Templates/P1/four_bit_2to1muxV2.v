module four_bit_2to1muxV2 (sel,a,b,chosen);
 
	input sel;
	input[3:0] a, b;
	output reg[3:0] chosen;
	
	always @(a,b,sel) begin
		if (sel == 1'b1) begin
			//Complete
			chosen <= b;
		end else begin
			//Complete
			chosen <= a;
		end
	end
 
endmodule
