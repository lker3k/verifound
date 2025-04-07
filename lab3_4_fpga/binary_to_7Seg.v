module binary_to_7Seg(binary, sevenSeg);

	input[3:0] binary;
	output reg[6:0]  sevenSeg;
	
	always @(binary) begin
		case (binary)
		4'b0000 : begin sevenSeg = 7'b1000000; end // 0
		4'b0001 : begin sevenSeg = 7'b1111001; end // 1
		4'b0010 : begin sevenSeg = 7'b0100100; end // 2
		4'b0011 : begin sevenSeg = 7'b0110000; end // 3
		4'b0100 : begin sevenSeg = 7'b0011001; end // 4
		4'b0101 : begin sevenSeg = 7'b0010010; end // 5
		4'b0110 : begin sevenSeg = 7'b0000010; end // 6
		4'b0111 : begin sevenSeg = 7'b1111000; end // 7
		4'b1000 : begin sevenSeg = 7'b0000000; end // 8
		4'b1001 : begin sevenSeg = 7'b0010000; end // 9
		default : begin sevenSeg = 7'b1111111; end
	endcase
	end
 
endmodule
