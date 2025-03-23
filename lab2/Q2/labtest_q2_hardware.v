module labtest_q2_hardware  (a,b,c,d,x);
    input[3:0] a, b, d;
	 input c;
    output[3:0] x;

    wire[1:0] t1;
    wire[3:0] t2,t3; //you may use this, but do not have to
    reg[3:0] t5, t6, t7; //you may use this, but do not have to

    circuitA comb1(.a(a),.b(b),.c(c),.x(t1),.y(t2));
    circuitB comb2(.a(d),.b(a),.x(t4));
	 assign t3 = b;
    
    always @(t1) begin
        case (t1)
            2'b00 : begin t5<= t2; end
            2'b01 : begin t5<= t3; end
            2'b10 : begin t5<= t4; end
				2'b11 : begin t5<= d; end
            default : begin t5<= 4'b0000; end
        endcase
    end
    
    circuitC comb3(.a(t5),.b(d),.x(x));
endmodule