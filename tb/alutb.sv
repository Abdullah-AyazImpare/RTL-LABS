`timescale 1ns/1ps

module alu_tb;

    // Testbench signals
    reg  [3:0]  Opcode;
    reg         Reset, clock;
    reg  [31:0] A, B;
    wire [31:0] Dout;
    wire        Zero;
    wire        Overflow;
    wire        CarryOut;

    // Instantiate the DUT
    alu uut (
        .Opcode(Opcode),
        .Reset(Reset),
        .clock(clock),
        .A(A),
        .B(B),
        .Dout(Dout),
        .Zero(Zero),
        .Overflow(Overflow),
        .CarryOut(CarryOut)
    );

    // Clock generation (10 ns period)
    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    // Apply test vectors
    initial begin
        // Reset
        Reset = 1;
        Opcode = 0;
        A = 0;
        B = 0;
        #10;

        Reset = 0;

        // ADD
        Opcode = 4'b0000;
        A = 32'd20;
        B = 32'd15;
        #10;

        // SUB
        Opcode = 4'b0001;
        A = 32'd20;
        B = 32'd15;
        #10;

        // AND
        Opcode = 4'b0010;
        A = 32'hF0F0F0F0;
        B = 32'h0FF00FF0;
        #10;

        // OR
        Opcode = 4'b0011;
        #10;

        // XOR
        Opcode = 4'b0100;
        #10;

        // Shift Right
        Opcode = 4'b0101;
        A = 32'h00000080;
        B = 32'd3;
        #10;

        // Shift Left
        Opcode = 4'b0110;
        A = 32'h00000001;
        B = 32'd4;
        #10;

        // Barrel Rotate Left
        Opcode = 4'b0111;
        A = 32'h80000001;
        B = 32'd1;
        #10;

        $finish;
    end

    // Display results
    initial begin
        $monitor("Time=%0t Opcode=%b A=%h B=%h Dout=%h Zero=%b Overflow=%b CarryOut=%b",
                  $time, Opcode, A, B, Dout, Zero, Overflow, CarryOut);
    end

endmodule