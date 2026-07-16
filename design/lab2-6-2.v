`timescale 1ns/1ps

module shifter8 (
    input clk,
    input load,
    input shl,
    input shr,
    input [7:0] data_in,
    output reg [7:0] data_out
);

always @(posedge clk) begin
    if (load)
        data_out <= data_in;
    else if (shl)
        data_out <= data_out << 1;
    else if (shr)
        data_out <= data_out >> 1;
    else
        data_out <= data_out;      // Hold value
end

endmodule