// Lab 4-9: UART controller interface to a memory
// Sub-block: UART parallel-to-serial interface.
// Loads a byte when load_valid is asserted and busy is low, then shifts
// it out one bit per clock, MSB first.

module uart_tx (clk, reset, data_in, load_valid, serial_out, busy);
    input  clk, reset, load_valid;
    input  [7:0] data_in;
    output reg serial_out;
    output busy;

    reg [7:0] shift_reg;
    reg [3:0] bit_cnt;
    reg       sending;

    assign busy = sending;

    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg  <= 8'b0;
            bit_cnt    <= 4'b0;
            serial_out <= 1'b1; // idle line high
            sending    <= 1'b0;
        end else begin
            if (!sending && load_valid) begin
                shift_reg <= data_in;
                bit_cnt   <= 4'b0;
                sending   <= 1'b1;
            end else if (sending) begin
                serial_out <= shift_reg[7];
                shift_reg  <= shift_reg << 1;
                bit_cnt    <= bit_cnt + 4'd1;
                if (bit_cnt == 4'd7)
                    sending <= 1'b0;
            end
        end
    end

endmodule
