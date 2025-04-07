module circuitB (z, d1);
    input z;
	output reg[6:0] d1; 
	
	always @(z)
	begin
	  if (z > 1'b1001)
		d1 = 1001111;
	  else
		d1 = 1111110;
	end
endmodule