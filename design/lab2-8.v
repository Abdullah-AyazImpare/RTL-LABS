`timescale 1ns/1ps

module mux8to1_ternary (
    input  d0,
    input  d1,
    input  d2,
    input  d3,
    input  d4,
    input  d5,
    input  d6,
    input  d7,
    input  [2:0] sel,
    output out
);

assign out = (sel == 3'b000) ? d0 :
             (sel == 3'b001) ? d1 :
             (sel == 3'b010) ? d2 :
             (sel == 3'b011) ? d3 :
             (sel == 3'b100) ? d4 :
             (sel == 3'b101) ? d5 :
             (sel == 3'b110) ? d6 :
                               d7;

endmodule