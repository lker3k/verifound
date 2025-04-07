module top_level (SW, HEX0, HEX1, LEDR);
	input[9:0] SW;
	output [6:0] HEX0, HEX1;
	output [9:0] LEDR;
	
	wire [3:0] sumInA, sumInB, total;
	
	comparator7 comparatorA (
		.v(SW[3:0]),
		.z(sumInA)
	);
	
	comparator7 comparatorB (
		.v(SW[7:4]),
		.z(sumInB)
	);
	
	fourBit_FA fourbit (
		.a(sumInA), 
		.b(sumInB),  
		.s(LEDR[4:1])
	);
	
	lab3_p2_v1 lab3 (
		.v(total), 
		.d1(HEX0), 
		.d2(HEX1)
	);
	
	

endmodule

module comparator7 (v, z);
	input [3:0] v; 	
	output reg [3:0] z; 
	
	always @(v)
	begin
	  if (v > 4'b0111)
		z = 0;
	  else
		z = v;
	end
	
endmodule
