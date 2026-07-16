`timescale 1ns/1ps

module comparator_8bit_tb;

    reg  [7:0] a;
    reg  [7:0] b;

    wire g;
    wire l;
    wire e;

    // Instantiate DUT
    comparator_8bit dut (
        .a (a),
        .b (b),
        .g (g),
        .l (l),
        .e (e)
    );

    initial begin
        $display("Time\t a\t b\t g l e");
        $monitor("%0t\t %0d\t %0d\t %b %b %b",
                 $time, a, b, g, l, e);

        // Test: a > b
        a = 8'd20;
        b = 8'd10;
        #10;
        if (g !== 1'b1 || l !== 1'b0 || e !== 1'b0)
            $display("ERROR: a > b case failed");

        // Test: a < b
        a = 8'd15;
        b = 8'd25;
        #10;
        if (g !== 1'b0 || l !== 1'b1 || e !== 1'b0)
            $display("ERROR: a < b case failed");

        // Test: a == b
        a = 8'd50;
        b = 8'd50;
        #10;
        if (g !== 1'b0 || l !== 1'b0 || e !== 1'b1)
            $display("ERROR: a == b case failed");

        // Boundary test: minimum values
        a = 8'd0;
        b = 8'd0;
        #10;

        // Boundary test: maximum values
        a = 8'd255;
        b = 8'd254;
        #10;

        $display("Simulation completed.");
        $finish;
    end

endmodule
