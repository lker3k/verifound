module hex_to_seg (hex, seg);

	input [3:0] hex;
	output reg [6:0] seg;
	
	always@(*) begin
		case(hex)
		4'h0 : begin seg = 7'b1000000; end // 0
		4'h1 : begin seg = 7'b1111001; end // 1
		4'h2 : begin seg = 7'b0100100; end // 2
		4'h3 : begin seg = 7'b0110000; end // 3
		4'h4 : begin seg = 7'b0011001; end // 4
		4'h5 : begin seg = 7'b0010010; end // 5
		4'h6 : begin seg = 7'b0000010; end // 6
		4'h7 : begin seg = 7'b1111000; end // 7
		4'h8 : begin seg = 7'b0000000; end // 8
		4'h9 : begin seg = 7'b0010000; end // 9
		4'hA : begin seg = 7'b0001000; end
		4'hB : begin seg = 7'b0000011; end
		4'hC : begin seg = 7'b0100111; end
		4'hD : begin seg = 7'b0100001; end
		4'hE : begin seg = 7'b0000110; end
		4'hF : begin seg = 7'b0001110; end
		default : begin seg = 7'b1111111; end
		endcase
	end
	
	
	
endmodule