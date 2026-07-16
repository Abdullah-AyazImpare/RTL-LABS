`timescale 1ns/1ps
module lab12 (
    input  wire       CLK,
    input  wire       RESET,
    input  wire       LOAD,
    input  wire       ADD,
    input  wire [7:0] DIN,

    output reg  [7:0] CLKCNT,
    output reg  [7:0] SUM
);

always @(posedge CLK or posedge RESET)
begin
    if (RESET) begin
        CLKCNT <= 8'd0;
        SUM    <= 8'd0;
    end
    else begin

        if (LOAD) begin
            CLKCNT <= DIN;
        end
        else if (ADD) begin
            SUM <= DIN + CLKCNT;
        end
        else begin
            CLKCNT <= CLKCNT + 8'd1;
        end

    end
end

endmodule
