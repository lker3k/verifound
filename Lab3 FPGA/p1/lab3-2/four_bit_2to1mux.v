module four_bit_2to1mux (sel,a,b,chosen);
 
	input sel;
	input[3:0] a, b;
	output[3:0] chosen;
	
	//fill in wires to connect s,x,y, m with inputs and outputs sel, a, b, chosen
	one_bit_2to1mux mux1(.s(sel),.x(a[0]),.y(b[0]),.m(chosen[0]));
	
	//Complete other instantiations
   one_bit_2to1mux mux2(.s(sel),.x(a[1]),.y(b[1]),.m(chosen[1]));
	one_bit_2to1mux mux3(.s(sel),.x(a[2]),.y(b[2]),.m(chosen[2]));
	one_bit_2to1mux mux4(.s(sel),.x(a[3]),.y(b[3]),.m(chosen[3]));
	
	
endmodule
