module t_flip_flop (t, clk, rst, q);
    input t, clk, rst;
    output reg q;

    always @(*) begin
        if (rst) begin
            q <= 0;
        end
    end

    always @(posedge clk) begin
        q <= ~t
    end
endmodule