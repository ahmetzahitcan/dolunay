`default_nettype none

module host_top_new #(
    parameter int W_ADDR = 30,
    parameter int MEM_DELAY = 2
)(
    input  wire logic        clk,
    input  wire logic        rst_n,

    output      logic        simt_start_o,
    input  wire logic        simt_ready_i,

    // AXI-Lite Master (connected to Xilinx Uartlite)
    output      logic [6:0]  m_axi_awaddr_o,
    output      logic        m_axi_awvalid_o,
    input  wire logic        m_axi_awready_i,

    output      logic [31:0] m_axi_wdata_o,
    output      logic [3:0]  m_axi_wstrb_o,
    output      logic        m_axi_wvalid_o,
    input  wire logic        m_axi_wready_i,

    input  wire logic [1:0]  m_axi_bresp_i,
    input  wire logic        m_axi_bvalid_i,
    output      logic        m_axi_bready_o,

    output      logic [6:0]  m_axi_araddr_o,
    output      logic        m_axi_arvalid_o,
    input  wire logic        m_axi_arready_i,

    input  wire logic [31:0] m_axi_rdata_i,
    input  wire logic [1:0]  m_axi_rresp_i,
    input  wire logic        m_axi_rvalid_i,
    output      logic        m_axi_rready_o,

    // Block Memory Interface
    output      logic [W_ADDR-1:0] block_mem_addr_o,
    output      logic [31:0] block_mem_din_o,
    output      logic        block_mem_we_o,
    input  wire logic [31:0] block_mem_dout_i,

    // Start/Ready
    input  wire logic        start_i,
    output      logic        ready_o
);
    localparam N_WARPS = 4;
    localparam HCOM_SIZE = 1024;

    // =========================================================================
    // Test Definition: vecadd
    // =========================================================================
    /*
    localparam N  = 64;
    localparam EXP_SIZE  = N;

    // Compute the value to write at address `addr` during the init phase.
    function automatic logic [31:0] gen_init_value(input logic [W_ADDR-1:0] addr);
        if (addr < N)
            return 32'd0;                                    // output region
        else if (addr < 2 * N) begin
            int i = 32'(addr) - 32'(N);               // x[i] = i * 5 + 11
            return 32'(i * 5 + 11);
        end else if (addr < 3 * N) begin
            int i = 32'(addr) - 32'(2 * N);           // y[i] = 1200 - i * 7
            return 32'(1200 - i * 7);
        end else
            return 32'd0;                                    // unused
    endfunction

    // Compute the expected value at address `addr` during the check phase.
    function automatic logic [31:0] gen_exp_value(input logic [W_ADDR-1:0] addr);
        // out[i] = x[i] + y[i] = (i * 5 + 11) + (1200 - i * 7) = 1211 - 2 * i
        int i = 32'(addr);
        return 32'(1211 - 2 * i);
    endfunction
    */

    // =========================================================================
    // Test Definition: saxpy
    // =========================================================================
    
    localparam N  = 64;
    localparam EXP_SIZE  = N;

    // Compute the value to write at address `addr` during the init phase.
    function automatic logic [31:0] gen_init_value(input logic [W_ADDR-1:0] addr);
        if (addr < N)
            return 32'd0;                                    // output region
        else if (addr < 2 * N) begin
            int i = 32'(addr) - 32'(N);               // x[i] = i * 5 + 11
            return 32'(i * 5 + 11);
        end else if (addr < 3 * N) begin
            int i = 32'(addr) - 32'(2 * N);           // y[i] = 1200 - i * 7
            return 32'(1200 - i * 7);
        end else if (addr == 3 * N) begin
            return 32'(11);             //scalar a
        end else
            return 32'd0;                                    // unused
    endfunction

    // Compute the expected value at address `addr` during the check phase.
    function automatic logic [31:0] gen_exp_value(input logic [W_ADDR-1:0] addr);
        // out[i] = scalar_a * x[i] + y[i] = 11 * (i * 5 + 11) + (1200 - i * 7) = 55*i + 121 + 1200 - 7*i = 48*i + 1321
        int i = 32'(addr);
        return 32'(48*i + 1321);
    endfunction
    

    // =========================================================================
    // FSM
    // =========================================================================

    localparam CRLF = {8'h0D, 8'h0A};
    localparam NULL = 8'h00;

    // prints parameters: enough room for the longest message + hex placeholders
    // Per-element:  "[01]: exp=02 got=03\r\n\0" = 21 chars
    // Summary pass: "PASS: all 01 elements match!\r\n\0" = 31 chars
    // Summary fail: "FAIL: 01 mismatches / 02\r\n\0" = 25 chars
    // Waiting msg:  "Waiting for SIMT core to finish...\r\n\0" = 37 chars
    localparam int MAX_LEN = 40;
    localparam int HEX_COUNT = 4;

    enum logic [4:0] {
        S_IDLE,
        S_MEM_WRITE,           // write mem_init[addr_r] to block memory
        S_INIT_SIMT,           // pulse simt_start_o
        S_INIT_MSG_WAITING,    // print "Waiting for SIMT..."
        S_WAIT_MSG_WAITING,    // wait for prints to finish
        S_WAIT_SIMT,           // wait for simt_ready_i
        S_CHECK_READ,          // issue read address, wait for MEM_DELAY
        S_CHECK_COMPARE,       // latch actual, compare with mem_exp
        S_CHECK_PRINT_INIT,    // print per-element: addr / exp / got
        S_CHECK_PRINT_WAIT,    // wait for per-element print to finish
        S_INIT_MSG_RESULT,     // print pass/fail summary
        S_WAIT_MSG_RESULT,     // wait for prints to finish
        S_LOAD_WTINSTRET,      // load wtinstret
        S_LOAD_WTINSTRETH,     // load wtinstreth
        S_LOAD_WUINSTRET,      // load wuinstret
        S_LOAD_WUINSTRETH,     // load wuinstreth
        S_INIT_MSG_HPM,        // print HPM results
        S_WAIT_MSG_HPM,        // wait for prints to finish
        S_INIT_MSG_CYCLE,      // print cycle
        S_WAIT_MSG_CYCLE       // wait for prints to finish
    } state_r;

    // Address counter (used for both write and check phases)
    logic [W_ADDR-1:0] addr_r;

    // Error counter for the check phase
    logic [31:0] err_count_r;

    // Latched actual value from memory read
    logic [31:0] mem_actual_r;

    // Memory delay shift register (same pattern as memdump)
    logic [MEM_DELAY-1:0] wait_counter_r;
    logic [MEM_DELAY-1:0] wait_counter_next_w;
    assign wait_counter_next_w = {wait_counter_r[MEM_DELAY-2:0], 1'b1};
    logic wait_counter_fin_w;
    assign wait_counter_fin_w = wait_counter_r[MEM_DELAY-1];

    // ---- Block Memory Interface Muxing ----
    always_comb begin
        block_mem_addr_o = addr_r;
        block_mem_din_o  = '0;
        block_mem_we_o   = 1'b0;

        if (state_r == S_MEM_WRITE) begin
            block_mem_din_o = gen_init_value(addr_r);
            block_mem_we_o  = 1'b1;
        end
    end

    // ---- HPMs ----
    logic [31:0] wtinstret_r;
    logic [31:0] wtinstreth_r;
    logic [31:0] wuinstret_r;
    logic [31:0] wuinstreth_r;

    logic [31:0] cycle_r;

    always_ff @(posedge clk) begin
        if (~simt_ready_i) begin
            cycle_r <= cycle_r + 32'd1;
        end else if (state_r == S_INIT_SIMT) begin
            cycle_r <= '0;
        end
    end

    // ---- Prints Submodule Wiring ----
    logic [(MAX_LEN*8)-1:0] prints_string_w;
    logic [HEX_COUNT:1][31:0] prints_hex_w;
    logic prints_start_w;
    logic prints_ready_w;

    always_comb begin
        prints_string_w = 'x;
        prints_hex_w    = 'x;
        prints_start_w  = 1'b0;

        unique case (state_r)
            S_INIT_MSG_WAITING: begin
                // "Waiting for SIMT core to finish...\r\n\0" = 37 chars
                prints_string_w = {{"Waiting for SIMT core to finish...", CRLF, NULL}, {(MAX_LEN-37){8'hX}}};
                prints_start_w  = 1'b1;
            end
            S_CHECK_PRINT_INIT: begin
                // Per-element: "[1]: exp=2 got=3\r\n\0" = 19 chars
                // hex slot 1 = address, slot 2 = expected, slot 3 = actual
                prints_string_w = {{"[", 8'h01, "]: exp=", 8'h02, " got=", 8'h03, CRLF, NULL}, {(MAX_LEN-19){8'hX}}};
                prints_hex_w[1] = {{(32-W_ADDR){1'b0}}, addr_r};
                prints_hex_w[2] = gen_exp_value(addr_r);
                prints_hex_w[3] = mem_actual_r;
                prints_start_w  = 1'b1;
            end
            S_INIT_MSG_RESULT: begin
                if (err_count_r == 0) begin
                    // "PASS: all X elements match!XXX" = 30 chars
                    prints_string_w = {{"PASS: all ", 8'h01, " elements match!", CRLF, NULL}, {(MAX_LEN-30){8'hX}}};
                    prints_hex_w[1] = EXP_SIZE;
                end else begin
                    // "FAIL: XXXXXXXX mismatches / XXXXXXXX\r\n\0" = 25 chars
                    prints_string_w = {{"FAIL: ", 8'h01, " mismatches / ", 8'h02, CRLF, NULL}, {(MAX_LEN-25){8'hX}}};
                    prints_hex_w[1] = err_count_r;
                    prints_hex_w[2] = EXP_SIZE;
                end
                prints_start_w = 1'b1;
            end
            S_INIT_MSG_HPM: begin
                // "WTINSTRET: XX    WUINSTRET: XXxxx" = 33 chars
                prints_string_w = {{"WTINSTRET: ", 8'h02, 8'h01, "    WUINSTRET: ", 8'h04, 8'h03, CRLF, NULL}, {(MAX_LEN-33){8'hX}}};
                prints_hex_w[1] = wtinstret_r;
                prints_hex_w[2] = wtinstreth_r;
                prints_hex_w[3] = wuinstret_r;
                prints_hex_w[4] = wuinstreth_r;
                prints_start_w  = 1'b1;
            end
            S_INIT_MSG_CYCLE: begin
                // "CYCLE: XXXX" = 11 chars
                prints_string_w = {{"CYCLE: ", 8'h01, CRLF, NULL}, {(MAX_LEN-11){8'hX}}};
                prints_hex_w[1] = cycle_r;
                prints_start_w  = 1'b1;
            end
            default: ;
        endcase
    end

    // ---- Main FSM ----
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            state_r        <= S_IDLE;
            addr_r         <= '0;
            err_count_r    <= '0;
            wait_counter_r <= '0;
        end else begin
            unique case (state_r)
                // ---------------------------------------------------------
                S_IDLE: begin
                    if (start_i) begin
                        addr_r  <= '0;
                        state_r <= S_MEM_WRITE;
                    end
                end

                // ---------------------------------------------------------
                // Write mem_init into block memory, one word per cycle
                // ---------------------------------------------------------
                S_MEM_WRITE: begin
                    if (addr_r == HCOM_SIZE - 1) begin
                        state_r <= S_INIT_SIMT;
                    end else begin
                        addr_r <= addr_r + 1'b1;
                    end
                end

                // ---------------------------------------------------------
                // Start SIMT core
                // ---------------------------------------------------------
                S_INIT_SIMT: begin
                    if (simt_ready_i) begin
                        state_r <= S_INIT_MSG_WAITING;
                    end
                end

                // ---------------------------------------------------------
                // Print "Waiting for SIMT..."
                // ---------------------------------------------------------
                S_INIT_MSG_WAITING: begin
                    if (prints_ready_w) begin
                        state_r <= S_WAIT_MSG_WAITING;
                    end
                end

                S_WAIT_MSG_WAITING: begin
                    if (prints_ready_w) begin
                        state_r <= S_WAIT_SIMT;
                    end
                end

                // ---------------------------------------------------------
                // Wait for SIMT to complete
                // ---------------------------------------------------------
                S_WAIT_SIMT: begin
                    if (simt_ready_i) begin
                        addr_r         <= '0;
                        err_count_r    <= '0;
                        wait_counter_r <= '0;
                        state_r        <= S_CHECK_READ;
                    end
                end

                // ---------------------------------------------------------
                // Issue read address and wait for memory latency
                // ---------------------------------------------------------
                S_CHECK_READ: begin
                    wait_counter_r <= wait_counter_next_w;
                    if (wait_counter_fin_w) begin
                        state_r <= S_CHECK_COMPARE;
                    end
                end

                // ---------------------------------------------------------
                // Latch actual data and compare with expected
                // ---------------------------------------------------------
                S_CHECK_COMPARE: begin
                    mem_actual_r <= block_mem_dout_i;
                    if (block_mem_dout_i !== gen_exp_value(addr_r)) begin
                        err_count_r <= err_count_r + 1'b1;
                    end
                    state_r <= S_CHECK_PRINT_INIT;
                end

                // ---------------------------------------------------------
                // Print per-element: [addr]: exp=XXXXXXXX got=XXXXXXXX
                // ---------------------------------------------------------
                S_CHECK_PRINT_INIT: begin
                    if (prints_ready_w) begin
                        state_r <= S_CHECK_PRINT_WAIT;
                    end
                end

                S_CHECK_PRINT_WAIT: begin
                    if (prints_ready_w) begin
                        if (addr_r == EXP_SIZE - 1'b1) begin
                            state_r <= S_INIT_MSG_RESULT;
                        end else begin
                            addr_r         <= addr_r + 1'b1;
                            wait_counter_r <= '0;
                            state_r        <= S_CHECK_READ;
                        end
                    end
                end

                // ---------------------------------------------------------
                // Print result message
                // ---------------------------------------------------------
                S_INIT_MSG_RESULT: begin
                    if (prints_ready_w) begin
                        state_r <= S_WAIT_MSG_RESULT;
                    end
                end

                S_WAIT_MSG_RESULT: begin
                    if (prints_ready_w) begin
                        addr_r <= HCOM_SIZE - N_WARPS * 2 * 2;
                        state_r <= S_LOAD_WTINSTRET;
                        wait_counter_r <= '0;
                    end
                end

                // ---------------------------------------------------------
                // Load HPM values
                // ---------------------------------------------------------

                S_LOAD_WTINSTRET: begin
                    wait_counter_r <= wait_counter_next_w;
                    if (wait_counter_fin_w) begin
                        wtinstret_r <= block_mem_dout_i;
                        addr_r <= addr_r + 1'b1;
                        state_r <= S_LOAD_WTINSTRETH;
                        wait_counter_r <= '0;
                    end
                end

                S_LOAD_WTINSTRETH: begin
                    wait_counter_r <= wait_counter_next_w;
                    if (wait_counter_fin_w) begin
                        wtinstreth_r <= block_mem_dout_i;
                        addr_r <= addr_r + 1'b1;
                        state_r <= S_LOAD_WUINSTRET;
                        wait_counter_r <= '0;
                    end
                end

                S_LOAD_WUINSTRET: begin
                    wait_counter_r <= wait_counter_next_w;
                    if (wait_counter_fin_w) begin
                        wuinstret_r <= block_mem_dout_i;
                        addr_r <= addr_r + 1'b1;
                        state_r <= S_LOAD_WUINSTRETH;
                        wait_counter_r <= '0;
                    end
                end

                S_LOAD_WUINSTRETH: begin
                    wait_counter_r <= wait_counter_next_w;
                    if (wait_counter_fin_w) begin
                        wuinstreth_r <= block_mem_dout_i;
                        addr_r <= addr_r + 1'b1;
                        state_r <= S_INIT_MSG_HPM;
                        wait_counter_r <= '0;
                    end
                end

                S_INIT_MSG_HPM: begin
                    if (prints_ready_w) begin
                        state_r <= S_WAIT_MSG_HPM;
                    end
                end

                S_WAIT_MSG_HPM: begin
                    if (prints_ready_w) begin
                        if (addr_r == HCOM_SIZE) begin
                            state_r <= S_INIT_MSG_CYCLE;
                        end else begin
                            state_r <= S_LOAD_WTINSTRET;
                            wait_counter_r <= '0;
                        end
                    end
                end

                S_INIT_MSG_CYCLE: begin
                    if (prints_ready_w) begin
                        state_r <= S_WAIT_MSG_CYCLE;
                    end
                end

                S_WAIT_MSG_CYCLE: begin
                    if (prints_ready_w) begin
                        state_r <= S_IDLE;
                    end
                end
            endcase
        end
    end

    // ---- Output Assignments ----
    assign simt_start_o = (state_r == S_INIT_SIMT);
    assign ready_o      = (state_r == S_IDLE);

    // ---- Prints Instance ----
    prints #(
        .MAX_LEN(MAX_LEN),
        .HEX_COUNT(HEX_COUNT)
    ) u_prints (
        .clk(clk),
        .rst_n(rst_n),
        .m_axi_awaddr_o(m_axi_awaddr_o),
        .m_axi_awvalid_o(m_axi_awvalid_o),
        .m_axi_awready_i(m_axi_awready_i),
        .m_axi_wdata_o(m_axi_wdata_o),
        .m_axi_wstrb_o(m_axi_wstrb_o),
        .m_axi_wvalid_o(m_axi_wvalid_o),
        .m_axi_wready_i(m_axi_wready_i),
        .m_axi_bresp_i(m_axi_bresp_i),
        .m_axi_bvalid_i(m_axi_bvalid_i),
        .m_axi_bready_o(m_axi_bready_o),
        .m_axi_araddr_o(m_axi_araddr_o),
        .m_axi_arvalid_o(m_axi_arvalid_o),
        .m_axi_arready_i(m_axi_arready_i),
        .m_axi_rdata_i(m_axi_rdata_i),
        .m_axi_rresp_i(m_axi_rresp_i),
        .m_axi_rvalid_i(m_axi_rvalid_i),
        .m_axi_rready_o(m_axi_rready_o),
        .string_i(prints_string_w),
        .hex_i(prints_hex_w),
        .start_i(prints_start_w),
        .ready_o(prints_ready_w)
    );

endmodule

`default_nettype wire