// Lab 4-4: Serial 8-bit to 1-bit

module serial (bit_out, byte_in, clk, reset);
    output reg bit_out;
    input  [7:0] byte_in;
    input  clk, reset;

    reg [7:0] shift_reg;
    reg [2:0] bit_cnt;

    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 8'b0;
            bit_cnt   <= 3'b0;
            bit_out   <= 1'b0;
        end else begin
            if (bit_cnt == 3'd0)
                shift_reg <= byte_in; 
            bit_out   <= shift_reg[7];  
            shift_reg <= shift_reg << 1;
            bit_cnt   <= bit_cnt + 3'd1;
        end
    end

endmodule
