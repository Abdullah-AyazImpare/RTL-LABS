`timescale 1ns/1ps

module divide_by3_tb;

    reg  [15:0] din;
    wire [14:0] result;
    wire [1:0]  remainder;

    // Instantiate DUT
    divide_by3 dut (
        .din       (din),
        .result    (result),
        .remainder (remainder)
    );

    task check;
        input [15:0] value;
        begin
            din = value;
            #1;

            if ((result !== (value / 3)) ||
                (remainder !== (value % 3))) begin
                $display("ERROR: din=%0d result=%0d expected=%0d remainder=%0d expected=%0d",
                         value, result, value/3, remainder, value%3);
            end
            else begin
                $display("PASS : din=%0d result=%0d remainder=%0d",
                         value, result, remainder);
            end
        end
    endtask

    initial begin

        check(16'd0);
        check(16'd1);
        check(16'd2);
        check(16'd3);
        check(16'd4);
        check(16'd5);
        check(16'd10);
        check(16'd100);
        check(16'd255);
        check(16'd1024);
        check(16'd65535);

        $display("Simulation completed.");
        $finish;
    end

endmodule
