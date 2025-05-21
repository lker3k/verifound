module register (
    input clk,
    input R_in,
    input R_out,
	 input rst,
    inout [2:0] bus
);

  reg [2:0] R;
  reg [2:0] bus_out;

  assign bus = (R_out) ? R : 3'bz;  // Drive bus when R_in is high
  always @(*) begin
	 if (rst) begin
		R = 0;
	 end else if (R_in) begin
      R = bus;  // Capture bus value on rising edge if R_out is high
    end else begin
		R = R;
	 end
  end

endmodule
