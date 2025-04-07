module circuitB (z, d1);
    input z;
	output reg[6:0] d1; 
	
	always @(z)
	begin
	  if (z == 1'b1)
		d1 = 7'b1111001;
	  else
		d1 = 7'b1000000;
	end
endmodule