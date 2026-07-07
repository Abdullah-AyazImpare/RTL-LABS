// Lab 4-9: UART controller interface to a memory
// Sub-block: UART serial-to-parallel interface.
// Shifts in one bit per clock; after 8 bits, presents the byte on
// data_out and pulses data_valid for one cycle.

module uart_rx (clk, reset, serial_in, data_out, data_valid);
    input  clk, reset, serial_in;
    output reg [7:0] data_out;
    output reg data_valid;

    reg [7:0] shift_reg;
    reg [3:0] bit_cnt;

    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg  <= 8'b0;
            bit_cnt    <= 4'b0;
            data_out   <= 8'b0;
            data_valid <= 1'b0;
        end else begin
            data_valid <= 1'b0;
            shift_reg  <= {shift_reg[6:0], serial_in};
            bit_cnt    <= bit_cnt + 4'd1;

            if (bit_cnt == 4'd7) begin
                data_out   <= {shift_reg[6:0], serial_in};
                data_valid <= 1'b1;
                bit_cnt    <= 4'b0;
            end
        end
    end

endmodule
