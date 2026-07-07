`timescale 1ns/1ps

module mux8to1_tb;

    // Testbench signals
    reg  [4:0] a0, a1, a2, a3, a4, a5, a6, a7;
    reg  [2:0] sel;
    wire [4:0] dout;

    // Instantiate the DUT (Device Under Test)
    mux8to1 uut (
        .a0(a0),
        .a1(a1),
        .a2(a2),
        .a3(a3),
        .a4(a4),
        .a5(a5),
        .a6(a6),
        .a7(a7),
        .sel(sel),
        .dout(dout)
    );

    // Apply test vectors
    initial begin
        // Initialize inputs
        a0 = 5'd1;
        a1 = 5'd2;
        a2 = 5'd3;
        a3 = 5'd4;
        a4 = 5'd5;
        a5 = 5'd6;
        a6 = 5'd7;
        a7 = 5'd8;

        // Test all select values
        sel = 3'b000; #10;
        sel = 3'b001; #10;
        sel = 3'b010; #10;
        sel = 3'b011; #10;
        sel = 3'b100; #10;
        sel = 3'b101; #10;
        sel = 3'b110; #10;
        sel = 3'b111; #10;

        $finish;
    end

    // Display outputs
    initial begin
        $monitor("Time=%0t sel=%b dout=%d", $time, sel, dout);
    end

endmodule