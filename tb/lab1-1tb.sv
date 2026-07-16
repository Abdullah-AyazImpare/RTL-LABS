`timescale 1ns/1ps

module tb_full_adder;

    reg A, B, Cin;
    wire Sum, Cout;

    // Instantiate the DUT (Device Under Test)
    full_adder dut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    initial begin
        $display("Time\tA B Cin | Sum Cout");
        $display("--------------------------");
        $monitor("%0t\t%b %b  %b  |  %b    %b",
                 $time, A, B, Cin, Sum, Cout);

        // Apply all possible input combinations
        {A, B, Cin} = 3'b000; #10;
        {A, B, Cin} = 3'b001; #10;
        {A, B, Cin} = 3'b010; #10;
        {A, B, Cin} = 3'b011; #10;
        {A, B, Cin} = 3'b100; #10;
        {A, B, Cin} = 3'b101; #10;
        {A, B, Cin} = 3'b110; #10;
        {A, B, Cin} = 3'b111; #10;

        $finish;
    end

endmodule
