`timescale 1ns/1ps

module uart_top_tb;

    reg clk;
    reg reset;
    reg serial_in;

    wire serial_out;
    wire tx_busy;

    // Instantiate DUT
    uart_top uut (
        .clk(clk),
        .reset(reset),
        .serial_in(serial_in),
        .serial_out(serial_out),
        .tx_busy(tx_busy)
    );

    // Clock generation (10 ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Task to transmit one byte serially (MSB first)
    task send_byte;
        input [7:0] data;
        integer i;
        begin
            for (i=7; i>=0; i=i-1) begin
                serial_in = data[i];
                #10;
            end
        end
    endtask

    // Test sequence
    initial begin
        // Reset
        reset = 1;
        serial_in = 0;
        #20;

        reset = 0;

        // -----------------------------
        // WRITE command
        // Command byte:
        // bit7 = 1 (write)
        // addr = 5
        // -----------------------------
        send_byte(8'b10000101);

        // Data byte = 0xA5
        send_byte(8'hA5);

        #40;

        // -----------------------------
        // READ command
        // bit7 = 0 (read)
        // addr = 5
        // -----------------------------
        send_byte(8'b00000101);

        // Wait for UART TX response
        #150;

        $finish;
    end

    // Monitor
    initial begin
        $monitor("Time=%0t serial_in=%b serial_out=%b tx_busy=%b",
                 $time, serial_in, serial_out, tx_busy);
    end

endmodule