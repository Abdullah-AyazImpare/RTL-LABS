`timescale 1ns/1ps

module dec3t08_tb;

    // Testbench signals
    reg  [2:0] d_in;
    reg  en;
    wire d0, d1, d2, d3, d4, d5, d6, d7;

    // Instantiate the DUT
    dec3t08 uut (
        .d_in(d_in),
        .en(en),
        .d0(d0),
        .d1(d1),
        .d2(d2),
        .d3(d3),
        .d4(d4),
        .d5(d5),
        .d6(d6),
        .d7(d7)
    );

    // Apply test vectors
    initial begin
        // Enable = 0 (all outputs should be 0)
        en = 0; d_in = 3'b000; #10;
        en = 0; d_in = 3'b101; #10;

        // Enable = 1 (test all input combinations)
        en = 1;
        d_in = 3'b000; #10;
        d_in = 3'b001; #10;
        d_in = 3'b010; #10;
        d_in = 3'b011; #10;
        d_in = 3'b100; #10;
        d_in = 3'b101; #10;
        d_in = 3'b110; #10;
        d_in = 3'b111; #10;

        $finish;
    end

    // Display outputs
    initial begin
        $monitor("Time=%0t en=%b d_in=%b -> d7..d0=%b%b%b%b%b%b%b%b",
                  $time, en, d_in,
                  d7, d6, d5, d4, d3, d2, d1, d0);
    end

endmodule