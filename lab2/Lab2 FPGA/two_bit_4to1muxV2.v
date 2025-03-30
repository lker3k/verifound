module two_bit_4to1muxV2 (s,u,v,w,x,m);
 
	input[1:0] s;
	input[1:0] u,v,w,x;
	output reg[1:0] m;
	
	reg[1:0] t1, t2;
	
	//complete always blocks (look at one_bit_4to1muxV2.v for hints. Should look the same)
	
	always @(*) begin
		case(s)
			2'b00 : m = u;
			2'b01 : m = v;
			2'b10 : m = w;
			2'b11 : m = x;
			default : m = 2'b00;
		endcase
	end
endmodule
