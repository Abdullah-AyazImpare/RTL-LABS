// Lab 3-6: Create parity generator for 32-bit data
`timescale 1ns/1ps

module parity_gen (clk, din, dout);
    input  clk;
    input  [31:0] din;
    output reg [35:0] dout;

    always @ (posedge clk) begin
        dout[31:0]  <= din;
        dout[32]    <= ^din[7:0];    // parity of byte 0
        dout[33]    <= ^din[15:8];   // parity of byte 1
        dout[34]    <= ^din[23:16];  // parity of byte 2
        dout[35]    <= ^din[31:24];  // parity of byte 3
    end

endmodule
