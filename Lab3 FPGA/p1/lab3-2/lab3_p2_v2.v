module lab3_p2_v2 (v, d1, d2);
    input [3:0] v; 
	output reg[6:0] d1, d2; 
	
	
	
	always @(v) begin
		case (v)
		4'b0000 : begin d1 = 7'b1000000; d2 = 7'b1000000; end
		4'b0001 : begin d1 = 7'b1000000; d2 = 7'b1111001; end
		4'b0010 : begin d1 = 7'b1000000; d2 = 7'b0100100; end
		4'b0011 : begin d1 = 7'b1000000; d2 = 7'b0110000; end
		4'b0100 : begin d1 = 7'b1000000; d2 = 7'b0011001; end
		4'b0101 : begin d1 = 7'b1000000; d2 = 7'b0010010; end
		4'b0110 : begin d1 = 7'b1000000; d2 = 7'b0000010; end
		4'b0111 : begin d1 = 7'b1000000; d2 = 7'b1111000; end
		4'b1000 : begin d1 = 7'b1000000; d2 = 7'b0000000; end
		4'b1001 : begin d1 = 7'b1000000; d2 = 7'b0010000; end
		4'b1010 : begin d1 = 7'b1111001; d2 = 7'b1000000; end
		4'b1011 : begin d1 = 7'b1111001; d2 = 7'b1111001; end
		4'b1100 : begin d1 = 7'b1111001; d2 = 7'b0100100; end
		4'b1101 : begin d1 = 7'b1111001; d2 = 7'b0110000; end
		4'b1110 : begin d1 = 7'b1111001; d2 = 7'b0011001; end
		4'b1111 : begin d1 = 7'b1111001; d2 = 7'b0010010; end
		default : begin d1 = 7'b1000000; d2 = 7'b1000000; end
	endcase
	end
	
endmodule