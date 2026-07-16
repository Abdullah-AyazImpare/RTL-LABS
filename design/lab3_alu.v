// Lab 3-1: Design an ALU
`timescale 1ns/1ps
module alu (Opcode, Reset, clock, A, B, Dout, Zero, Overflow, CarryOut);
    input  [3:0]  Opcode;
    input         Reset, clock;
    input  [31:0] A, B;
    output reg [31:0] Dout;
    output        Zero;
    output reg    Overflow;
    output reg    CarryOut;

    localparam ADD    =  4'b0000,
               SUB     = 4'b0001,
               AND_OP  = 4'b0010,
               OR_OP   = 4'b0011,
               XOR_OP  = 4'b0100,
               SHR     = 4'b0101,   
               SHL     = 4'b0110,   
               BARREL  = 4'b0111;   
    wire [32:0] add_ext = {1'b0, A} + {1'b0, B};
    wire [32:0] sub_ext = {1'b0, A} - {1'b0, B};

    always @ (posedge clock or posedge Reset) begin
        if (Reset) begin
            Dout     <= 32'b0;
            Overflow <= 1'b0;
            CarryOut <= 1'b0;
        end else begin
            case (Opcode)
                ADD: begin
                    Dout     <= add_ext[31:0];
                    CarryOut <= add_ext[32];
                    Overflow <= (A[31] == B[31]) && (add_ext[31] != A[31]);
                end
                SUB: begin
                    Dout     <= sub_ext[31:0];
                    CarryOut <= sub_ext[32];
                    Overflow <= (A[31] != B[31]) && (sub_ext[31] != A[31]);
                end
                AND_OP: begin
                    Dout <= A & B;
                    Overflow <= 1'b0;
                    CarryOut <= 1'b0;
                end
                OR_OP: begin
                    Dout <= A | B;
                    Overflow <= 1'b0;
                    CarryOut <= 1'b0;
                end
                XOR_OP: begin
                    Dout <= A ^ B;
                    Overflow <= 1'b0;
                    CarryOut <= 1'b0;
                end
                SHR: begin
                    Dout <= A >> B[4:0];
                    Overflow <= 1'b0;
                    CarryOut <= 1'b0;
                end
                SHL: begin
                    Dout <= A << B[4:0];
                    Overflow <= 1'b0;
                    CarryOut <= 1'b0;
                end
                BARREL: begin
                    
                    Dout <= (A << B[4:0]) | (A >> (6'd32 - B[4:0]));
                    Overflow <= 1'b0;
                    CarryOut <= 1'b0;
                end
                default: begin
                    Dout     <= 32'b0;
                    Overflow <= 1'b0;
                    CarryOut <= 1'b0;
                end
            endcase
        end
    end

    assign Zero = (Dout == 32'b0);

endmodule
