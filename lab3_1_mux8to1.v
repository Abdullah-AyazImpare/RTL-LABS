// Lab 3-1: Design an 8-to-1 mux using a case statement
// Eight 5-bit inputs, 3-bit select, one 5-bit output

module mux8to1 (a0, a1, a2, a3, a4, a5, a6, a7, sel, dout);
    input  [4:0] a0, a1, a2, a3, a4, a5, a6, a7;
    input  [2:0] sel;
    output reg [4:0] dout;

    always @ (*) begin
        case (sel)
            3'b000: dout = a0;
            3'b001: dout = a1;
            3'b010: dout = a2;
            3'b011: dout = a3;
            3'b100: dout = a4;
            3'b101: dout = a5;
            3'b110: dout = a6;
            3'b111: dout = a7;
            default: dout = 5'b00000;
        endcase
    end

endmodule
