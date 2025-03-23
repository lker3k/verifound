module circuitA (a,b,c,x,y);
	input[3:0] a,b;
	input c;
	output[1:0] x;
	output[3:0] y;

    
    // complete the rest of the code
	 assign y = a&b|{1'b0,1'b0,1'b0,c};
	 assign x = {y[3]&y[2],y[1]|y[0]};

endmodule