// Lab 4-7: Regfile
// Synthesizable 16x8-bit register file. All accesses (read or write) take
// only one clock cycle, and back-to-back accesses are possible.
// r_w = 1 selects write, r_w = 0 selects read.
`timescale 1ns/1ps
module regfile (d_out, d_in, addr_in, r_w, clk);
    output reg [7:0] d_out;
    input  [7:0] d_in;
    input  [3:0] addr_in;
    input  clk, r_w;

    // Register array built from 16 x 8 single-bit storage elements
    reg [7:0] mem [0:15];

    always @ (posedge clk) begin
        if (r_w)
            mem[addr_in] <= d_in;   // write
        else
            d_out <= mem[addr_in];  // read
    end

endmodule
