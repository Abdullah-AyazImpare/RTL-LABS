// Lab 4-2: 8-bit Updown Counter

module counter (reset, clock, up_down, count);
    input  reset, clock, up_down;
    output reg [7:0] count;

    always @ (posedge clock or posedge reset) begin
        if (reset)
            count <= 8'b0;
        else if (up_down)
            count <= count + 8'd1;
        else
            count <= count - 8'd1;
    end

endmodule
