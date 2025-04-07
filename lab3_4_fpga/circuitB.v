module circuitB (z, d1);
    input z;
	output reg[3:0] d1; 
	
	always @(z)
	begin
	  if (z == 1'b1)
		d1 = 0001;
	  else
		d1 = 0000;
	end
endmodule