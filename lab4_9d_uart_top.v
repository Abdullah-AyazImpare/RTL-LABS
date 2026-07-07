// Lab 4-9: UART controller interface to a memory
// Top-level integration of:
//   - uart_rx        : serial -> parallel command reception
//   - uart_tx        : parallel -> serial response transmission
//   - fifo (x2)      : one FIFO buffers incoming command bytes, the other
//                      buffers outgoing response bytes (reused from
//                      Lab 4-8's fifo module)
//   - dual_port_mem  : the memory block being accessed (one read port,
//                      one write port)
//
// Simplified command protocol (illustrative, since the slide only
// specifies the block diagram, not an exact frame format):
//   Byte 0 from UART: { r_w, addr[6:0] }   -- r_w=1 write, r_w=0 read
//   Byte 1 (write only): data byte to store at addr
// A read command returns one byte on the UART tx path; a write command
// produces no response byte.

module uart_top (
    clk, reset,
    serial_in,
    serial_out, tx_busy
);
    input  clk, reset;
    input  serial_in;
    output serial_out;
    output tx_busy;

    // ---- UART RX ----
    wire [7:0] rx_data;
    wire       rx_valid;

    uart_rx u_rx (
        .clk(clk), .reset(reset),
        .serial_in(serial_in),
        .data_out(rx_data),
        .data_valid(rx_valid)
    );

    // ---- Command FIFO (buffers raw command bytes coming from UART) ----
    wire [7:0] cmd_fifo_out;
    wire       cmd_fifo_full, cmd_fifo_empty;
    reg        cmd_fifo_rd_req;

    fifo u_cmd_fifo (
        .d_in(rx_data),
        .in_valid(rx_valid),
        .d_out(cmd_fifo_out),
        .d_out_req(cmd_fifo_rd_req),
        .clk(clk),
        .full(cmd_fifo_full),
        .empty(cmd_fifo_empty),
        .reset(reset)
    );

    // ---- Response FIFO (buffers bytes waiting to go out over UART) ----
    reg  [7:0] resp_fifo_in;
    reg        resp_fifo_wr_valid;
    wire [7:0] resp_fifo_out;
    wire       resp_fifo_full, resp_fifo_empty;
    reg        resp_fifo_rd_req;

    fifo u_resp_fifo (
        .d_in(resp_fifo_in),
        .in_valid(resp_fifo_wr_valid),
        .d_out(resp_fifo_out),
        .d_out_req(resp_fifo_rd_req),
        .clk(clk),
        .full(resp_fifo_full),
        .empty(resp_fifo_empty),
        .reset(reset)
    );

    // ---- Memory block ----
    reg        mem_wr_en, mem_rd_en;
    reg  [6:0] mem_addr;
    reg  [7:0] mem_wr_data;
    wire [7:0] mem_rd_data;

    dual_port_mem #(.AW(7), .DW(8)) u_mem (
        .clk(clk),
        .wr_en(mem_wr_en), .wr_addr(mem_addr), .wr_data(mem_wr_data),
        .rd_en(mem_rd_en), .rd_addr(mem_addr), .rd_data(mem_rd_data)
    );

    // ---- UART TX ----
    reg tx_load_valid;
    uart_tx u_tx (
        .clk(clk), .reset(reset),
        .data_in(resp_fifo_out),
        .load_valid(tx_load_valid),
        .serial_out(serial_out),
        .busy(tx_busy)
    );

    // ---- Simple command state machine ----
    localparam IDLE       = 3'd0,
               GET_BYTE0  = 3'd1,
               GET_BYTE1  = 3'd2,
               DO_WRITE   = 3'd3,
               DO_READ    = 3'd4,
               PUSH_RESP  = 3'd5,
               SEND_RESP  = 3'd6;

    reg [2:0] state;
    reg       r_w;
    reg [6:0] addr_reg;

    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            state              <= IDLE;
            cmd_fifo_rd_req    <= 1'b0;
            resp_fifo_wr_valid <= 1'b0;
            resp_fifo_rd_req   <= 1'b0;
            mem_wr_en          <= 1'b0;
            mem_rd_en          <= 1'b0;
            tx_load_valid      <= 1'b0;
        end else begin
            // defaults (pulses)
            cmd_fifo_rd_req    <= 1'b0;
            resp_fifo_wr_valid <= 1'b0;
            resp_fifo_rd_req   <= 1'b0;
            mem_wr_en          <= 1'b0;
            mem_rd_en          <= 1'b0;
            tx_load_valid      <= 1'b0;

            case (state)
                IDLE: begin
                    if (!cmd_fifo_empty) begin
                        cmd_fifo_rd_req <= 1'b1;
                        state           <= GET_BYTE0;
                    end
                end
                GET_BYTE0: begin
                    r_w      <= cmd_fifo_out[7];
                    addr_reg <= cmd_fifo_out[6:0];
                    if (cmd_fifo_out[7]) begin
                        // write: need a second byte (data)
                        if (!cmd_fifo_empty) begin
                            cmd_fifo_rd_req <= 1'b1;
                            state           <= GET_BYTE1;
                        end
                    end else begin
                        state <= DO_READ;
                    end
                end
                GET_BYTE1: begin
                    mem_wr_data <= cmd_fifo_out;
                    mem_addr    <= addr_reg;
                    mem_wr_en   <= 1'b1;
                    state       <= IDLE;
                end
                DO_READ: begin
                    mem_addr  <= addr_reg;
                    mem_rd_en <= 1'b1;
                    state     <= PUSH_RESP;
                end
                PUSH_RESP: begin
                    resp_fifo_in       <= mem_rd_data;
                    resp_fifo_wr_valid <= 1'b1;
                    state              <= SEND_RESP;
                end
                SEND_RESP: begin
                    if (!resp_fifo_empty && !tx_busy) begin
                        resp_fifo_rd_req <= 1'b1;
                        tx_load_valid    <= 1'b1;
                        state            <= IDLE;
                    end
                end
                default: state <= IDLE;
            endcase
        end
    end

endmodule
