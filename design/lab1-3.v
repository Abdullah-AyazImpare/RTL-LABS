`timescale 1ns/1ps
module 2x1_mux (
    input  wire       SEL,
    input  wire [7:0] IN0,
    input  wire [7:0] IN1,

    output reg  [7:0] OUT
);
assign OUT = (SEL) ? IN1 : IN0;
endmodule

