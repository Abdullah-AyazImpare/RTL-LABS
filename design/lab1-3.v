`timescale 1ns/1ps
module mux_2x1 (
    input  wire       SEL,
    input  wire [7:0] IN0,
    input  wire [7:0] IN1,

    output   [7:0] OUT
);
assign OUT = (SEL) ? IN1 : IN0;
endmodule

