`timescale 1ns/1ps
module divide_by3 (
    input  [15:0] din,
    output reg [14:0] result,
    output reg [1:0]  remainder
);

    reg [15:0] temp;

    always @(*) begin
        result    = 15'b0;
        temp      = din;

        while (temp >= 3) begin
            temp   = temp - 3;
            result = result + 1;
        end

        remainder = temp[1:0];  
    end

endmodule
