module comparator (v, z);
	input [3:0] v; 	
	output reg z; 
	
	always @(v)
	begin
	  if (v > 4'b1001)
		z = 1;
	  else
		z = 0;
	end
	
endmodule
