`timescale 1ns/1ps
module pattern_count (
    input  [31:0] din,
    output reg [3:0] count
);

    integer i;

    always @(*) begin
        count = 4'b0;

        for (i = 0; i <= 29; i = i + 1) begin
            if (din[i+2] == 1'b0 &&
                din[i+1] == 1'b1 &&
                din[i]   == 1'b0)
            begin
                count = count + 1;
            end
        end
    end

endmodule
