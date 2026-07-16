`timescale 1ns/1ps
module comparator_8bit (
    input  [7:0] a,
    input  [7:0] b,
    output reg g,
    output reg l,
    output reg e
);

always @(*) begin
    // Default values
    g = 0;
    l = 0;
    e = 0;

    if (a > b) begin
        g = 1;
    end
    else if (a < b) begin
        l = 1;
    end
    else begin
        e = 1;
    end
end

endmodule
