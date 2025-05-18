module control(
    input [3:0] opcode,
    output reg rxi,
    output reg rxo,
    output reg ryi,
    output reg ryo,
    output reg ai,
    output reg ao,
    output reg gi,
    output reg go,
    output reg [1:0] alu,
    output reg branch,
    output reg ldpc
);

always @(*) begin
    rxi = 0; rxo = 0;
    ryi = 0; ryo = 0;
    ai = 0;  ao = 0;
    gi = 0;  go = 0;
    alu= 2'b00;
    branch = 0;
    ldpc = 0;

    case (opcode)
        // load Rx, D
        4'b0000: begin
            rx_in  = 1;
        end
        // mov Rx, Ry
        4'b0001: begin
            rx_out = 1;
            ry_in = 1;
        end

        // add Rx, Ry
        4'b0010: begin
            alu = 2'b01;
            rxo = 1;
            ai   = 1;
            ryo = 1;
            gi   = 1;
            go  = 1;
            rxi  = 1;
        end

        // xor Rx, Ry
        4'b0011: begin
            alu_op = 2'b10;
            rxo = 1;
            ai   = 1;
            ryo = 1;
            gi  = 1;
            go  = 1;
            rxi  = 1;
        end

        // branch
        4'b0101: begin
            branch = 1;
        end

        default: begin
        end
    endcase
end
endmodule