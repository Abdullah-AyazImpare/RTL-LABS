`timescale 1ns/1ps

module barrel_org_tb;

    reg  [1:0] S;
    reg  [3:0] A_P;
    wire [3:0] B_P;

    // Instantiate DUT
    barrel_org uut (
        .S(S),
        .A_P(A_P),
        .B_P(B_P)
    );

    initial begin
        A_P = 4'b1011;

        S = 2'b00; #10;   // No shift
        S = 2'b01; #10;   // Rotate left by 1
        S = 2'b10; #10;   // Rotate left by 2
        S = 2'b11; #10;   // Rotate left by 3

        // Another input
        A_P = 4'b0101;

        S = 2'b00; #10;
        S = 2'b01; #10;
        S = 2'b10; #10;
        S = 2'b11; #10;

        $finish;
    end

    initial begin
        $monitor("Time=%0t  S=%b  A_P=%b  B_P=%b",
                  $time, S, A_P, B_P);
    end

endmodule