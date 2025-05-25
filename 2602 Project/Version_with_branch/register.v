module register (
    input clk,
    input R_in,
    input R_out,
	 input rst,
    inout [15:0] bus
);

  reg [15:0] R;

  assign bus = (R_out) ? R : 16'bz;  // Drive bus when R_in is high
  always @(posedge clk or posedge rst) begin
	 if (rst) begin
		R = 0;
	 end else if (R_in) begin
      R = bus;  // Capture bus value on rising edge if R_out is high
    end
  end

endmodule
