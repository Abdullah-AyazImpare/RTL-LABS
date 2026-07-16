`timescale 1ns/1ps

module mux_2x1_tb;

    reg        SEL;
    reg  [7:0] IN0;
    reg  [7:0] IN1;
    wire [7:0] OUT;

    mux_2x1 dut (
        .SEL (SEL),
        .IN0 (IN0),
        .IN1 (IN1),
        .OUT (OUT)
    );

    initial begin
        $monitor("Time=%0t SEL=%b IN0=%h IN1=%h OUT=%h",
                  $time, SEL, IN0, IN1, OUT);

        IN0 = 8'hAA;
        IN1 = 8'h55;

        SEL = 1'b0;
        #10;

        SEL = 1'b1;
        #10;

        IN0 = 8'h0F;
        IN1 = 8'hF0;
        #10;

        SEL = 1'b0;
        #10;

        $finish;
    end

endmodule
