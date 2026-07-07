`timescale 1ns/1ps

module mult3_tb;

    // Testbench signals
    reg        en;
    reg  [5:0] mult_in;
    wire [7:0] mult_out;

    // Instantiate the DUT
    mult3 uut (
        .mult_in(mult_in),
        .en(en),
        .mult_out(mult_out)
    );

    // Apply test vectors
    initial begin
        // Enable disabled
        en = 0;
        mult_in = 6'd10; #10;

        // Enable enabled
        en = 1;

        mult_in = 6'd0;  #10;   // 0 × 3 = 0
        mult_in = 6'd1;  #10;   // 1 × 3 = 3
        mult_in = 6'd5;  #10;   // 5 × 3 = 15
        mult_in = 6'd10; #10;   // 10 × 3 = 30
        mult_in = 6'd21; #10;   // 21 × 3 = 63
        mult_in = 6'd63; #10;   // 63 × 3 = 189

        $finish;
    end

    // Display results
    initial begin
        $monitor("Time=%0t  en=%b  mult_in=%d  mult_out=%d",
                 $time, en, mult_in, mult_out);
    end

endmodule