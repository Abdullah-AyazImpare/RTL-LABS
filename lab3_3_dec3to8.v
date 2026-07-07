
module dec3t08  (d_in, en, d0, d1, d2, d3, d4, d5, d6, d7);
    input  [2:0] d_in;
    input  en;
    output d0, d1, d2, d3, d4, d5, d6, d7;

    wire [7:0] decoded;

    assign decoded    = en ? (8'b0000_0001 << d_in) : 8'b0;
    assign {d7,d6,d5,d4,d3,d2,d1,d0} = decoded;

endmodule
