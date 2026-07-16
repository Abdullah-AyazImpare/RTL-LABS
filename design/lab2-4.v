`timescale 1ns/1ps
module counter_8bit (
    input        clk,
    input  [1:0] c,
    input  [7:0] din,
    output reg [7:0] dout
);

always @(posedge clk) begin
    case (c)
        2'b00: dout <= din;        
        2'b01: dout <= dout + 1;   
        2'b10: dout <= dout - 1;   
        2'b11: dout <= 8'b0;       
    endcase
end

endmodule
