module labtest_q1_hardware(a,b,c,d,y);
    input a,b,c,d;
    output reg y;
    
    wire[3:0] temp; //this is an optional wire you may/may not wish to use
    
    // complete the rest of the code
     assign temp = {a, b, c, d};
     
     always @(temp) begin
        case (temp)
            4'b0000       : begin y = 1'b0; end 
            4'b0001       : begin y = 1'b0; end 
				4'b0010		  : begin y = 1'b1; end
				4'b0011		  : begin y = 1'b1; end
				4'b0100		  : begin y = 1'b0; end
				4'b0101		  : begin y = 1'b1; end
				4'b0110		  : begin y = 1'b0; end
				4'b0111		  : begin y = 1'b1; end 
				4'b1000		  : begin y = 1'b0; end
				4'b1001		  : begin y = 1'b0; end
				4'b1010		  : begin y = 1'b0; end
				4'b1011		  : begin y = 1'b0; end
				4'b1100		  : begin y = 1'b1; end
				4'b1101		  : begin y = 1'b0; end
				4'b1110		  : begin y = 1'b0; end
				4'b1111		  : begin y = 1'b0; end
            default     : begin y = 1'b0 ; end 
        endcase
    end

endmodule

