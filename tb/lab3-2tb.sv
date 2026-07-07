`timescale 1ns/1ps

module comparator_rel_tb;

    // Testbench signals
    reg  [7:0] a, b;
    wire EQ, GT, LT;

    // Instantiate the DUT
    comparator_rel uut (
        .a(a),
        .b(b),
        .EQ(EQ),
        .GT(GT),
        .LT(LT)
    );

    // Apply test vectors
    initial begin
        // Test Equal
        a = 8'd10; b = 8'd10; #10;

        // Test Greater Than
        a = 8'd25; b = 8'd15; #10;

        // Test Less Than
        a = 8'd5;  b = 8'd20; #10;

        // Additional tests
        a = 8'd255; b = 8'd0;   #10;
        a = 8'd0;   b = 8'd255; #10;
        a = 8'd100; b = 8'd100; #10;

        $finish;
    end

    // Display results
    initial begin
        $monitor("Time=%0t  a=%d  b=%d  EQ=%b  GT=%b  LT=%b",
                 $time, a, b, EQ, GT, LT);
    end

endmodule