// Lab 3-6: Create a multiplier which multiplies a number by three
// using synthesizable RTL and no '*' operator.
// x*3 = (x << 1) + x
`timescale 1ns/1ps
module mult3 (mult_in, en, mult_out);
    input  en;
    input  [5:0] mult_in;
    output [7:0] mult_out;

    wire [7:0] in_ext;
    wire [7:0] times2;

    assign in_ext  = {2'b00, mult_in};
    assign times2  = in_ext << 1;
    assign mult_out = en ? (times2 + in_ext) : 8'b0;

endmodule
