// Lab 3-2: Comparator with inputs a and b (8 bits wide)
// Outputs EQ, GT, LT
`timescale 1ns/1ps
module comparator_rel (a, b, EQ, GT, LT);
    input  [7:0] a, b;
    output EQ, GT, LT;

    assign EQ = (a == b);
    assign GT = (a > b);
    assign LT = (a < b);

endmodule
