module top_level (SW, HEX4, HEX3, LEDR);
	input[9:0] SW;
	output [6:0] HEX4, HEX3;
	output [9:0] LEDR;
	
	wire [3:0] sumInA, sumInB, total_sum, total;
	wire cin;
	
	assign LEDR[4:1] = total;
	assign cin = SW[8];
	assign total = total_sum + cin;
	
	comparator7 comparatorA (
		.v(SW[3:0]),
		.z(sumInA),
		.err(LEDR[8])
	);
	
	comparator7 comparatorB (
		.v(SW[7:4]),
		.z(sumInB),
		.err(LEDR[9])
	);
	
	fourBit_FA fourbit (
		.a(sumInA), 
		.b(sumInB),  
		.s(total_sum)
	);
	
	lab3_p2_v1 lab3 (
		.v(total), 
		.d1(HEX4), 
		.d2(HEX3)
	);
	
	

endmodule

module comparator7 (v, z, err);
	input [3:0] v; 	
	output reg [3:0] z; 
	output reg err;
	
	always @(v)
	begin
	  if (v > 4'b0111) begin
		z = 0;
		err = 1;
	  end else begin
		z = v;
		err = 0;
		end
	end
	
endmodule
