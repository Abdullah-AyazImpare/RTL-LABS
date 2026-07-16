`timescale 1ns/1ps
module barrel_org (S, A_P, B_P);
    input  [1:0] S;
    input  [3:0] A_P;
    output reg [3:0] B_P;

    always @(*) begin
        case (S)
            2'b00: begin
                B_P = A_P;
            end

            2'b01: begin
                B_P[3]   = A_P[0];
                B_P[2:0] = A_P[3:1];
            end

            2'b10: begin
                B_P[3:2] = A_P[1:0];
                B_P[1:0] = A_P[3:2];
            end

            2'b11: begin
                B_P[3:1] = A_P[2:0];
                B_P[0]   = A_P[3];
            end
        endcase
    end

endmodule
