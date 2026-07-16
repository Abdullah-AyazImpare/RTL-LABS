`timescale 1ns/1ps

module pattern_count_tb;

    reg  [31:0] din;
    wire [3:0]  count;

    pattern_count dut (
        .din   (din),
        .count (count)
    );

    task check;
        input [31:0] value;
        input [3:0]  expected;
        begin
            din = value;
            #1;

            if (count !== expected)
                $display("ERROR: din=%b count=%0d expected=%0d", value, count, expected);
            else
                $display("PASS : din=%b count=%0d", value, count);
        end
    endtask

    initial begin
        
        check(32'b11111111, 0);

        
        check(32'b0000010000000000, 1);

        
        check(32'b0001001001000000, 3);

        
        check(32'b0101010, 3);

        
        check(32'hA3_4B_10_20, 0);

        $display("Simulation completed.");
        $finish;
    end

endmodule
