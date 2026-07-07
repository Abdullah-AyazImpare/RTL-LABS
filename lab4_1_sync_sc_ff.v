// Lab 4-1: Flop with synchronous set/clear functionality
//Design an 8-bit counter


module counter8_set_clear (clk, clear, set, en, count);
    input  clk, clear, set, en;
    output reg [7:0] count;

    always @ (posedge clk) begin
        if (clear)
            count <= 8'd0;
        else if (set)
            count <= 8'd16;
        else if (en)
            count <= count - 8'd1;
    end

endmodule
