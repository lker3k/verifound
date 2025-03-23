module two_bit_4to1mux (s,u,v,w,x,m);
 
	input[1:0] s;
	input[1:0] u, v, w, x;
	output[1:0] m;
	
	wire [1:0] t1, t2;
	
	one_bit_2to1mux mux1(.s(s[0]),.x(u[0]),.y(v[0]),.m(t1[0]));  //complete instantiation
	one_bit_2to1mux mux2(.s(s[0]),.x(u[1]),.y(v[1]),.m(t1[1])); //complete
	//complete other instantiations
	one_bit_2to1mux mux3(.s(s[0]),.x(w[0]),.y(x[0]),.m(t2[0])); //complete
	one_bit_2to1mux mux4(.s(s[0]),.x(w[1]),.y(x[1]),.m(t2[1])); //complete
	
	one_bit_2to1mux mux5(.s(s[1]),.x(t1[0]),.y(t2[0]),.m(m[0])); //complete
	one_bit_2to1mux mux6(.s(s[1]),.x(t1[1]),.y(t2[1]),.m(m[1])); //complete
endmodule
