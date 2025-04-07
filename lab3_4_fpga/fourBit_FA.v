module fourBit_FA(a,b,s);
	//some inputs and outputs are 1-bit, some are 4-bit
	input [3:0] a, b;
	output reg [3:0] s;
	
	always @(*) begin
			s = a + b;
	end

	
endmodule