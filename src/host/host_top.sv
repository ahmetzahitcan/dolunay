`default_nettype none

module host_top #(
    parameter int W_ADDR = 12,
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
    input  wire logic [31:0] block_mem_dout_i,

    // Start/Ready
    input  wire logic        start_i,
    output      logic        ready_o
);
    localparam VECADD_N = 64;
    logic [31:0] vecadd_x [VECADD_N];
    logic [31:0] vecadd_y [VECADD_N];
    logic [31:0] vecadd_out [VECADD_N];

    logic [31:0] vecadd_init [VECADD_N*3];
    logic [31:0] vecadd_exp [VECADD_N];

    initial begin
        for (int i = 0; i < VECADD_N; i++) begin
            vecadd_x[i] = $urandom();
            vecadd_y[i] = $urandom();
            vecadd_out[i] = vecadd_x[i] + vecadd_y[i];
        end
        for (int i = 0; i < VECADD_N; i++) begin
            vecadd_init[i] = 0;
            vecadd_init[i + VECADD_N] = vecadd_x[i];
            vecadd_init[i + VECADD_N*2] = vecadd_y[i];
        end
        for (int i = 0; i < VECADD_N; i++) begin
            vecadd_exp[i] = vecadd_out[i];
        end
    end

    localparam MEM_SIZE = 2**W_ADDR;
    logic [31:0] mem_init [MEM_SIZE];
    logic [31:0] mem_exp [MEM_SIZE];
    logic [31:0] mem_exp_datasize;

    initial begin
        for (int i = 0; i < VECADD_N*3; i++) begin
            mem_init[i] = vecadd_init[i];
        end
        for (int i = VECADD_N*3; i < MEM_SIZE; i++) begin
            mem_init[i] = 0;
        end
        for (int i = 0; i < VECADD_N; i++) begin
            mem_exp[i] = vecadd_exp[i];
        end
        for (int i = VECADD_N; i < MEM_SIZE; i++) begin
            mem_exp[i] = 'hX;
        end
        mem_exp_datasize = VECADD_N;
    end

    localparam CRLF = {8'h0D, 8'h0A};
    localparam NULL = 8'h00;

    localparam int MAX_LEN = 37;
    localparam int HEX_COUNT = 2;

    enum logic [3:0] { 
        S_IDLE,
        S_INIT_SIMT,
        S_INIT_MSG_WAITING,
        S_WAIT_MSG_WAITING,
        S_WAIT_SIMT,
        S_INIT_MEMDUMP,
        S_WAIT_MEMDUMP,
        S_INIT_MSG_FINISHED,
        S_WAIT_MSG_FINISHED
    } state_r;

    always_ff @( posedge clk ) begin
        if (!rst_n) begin
            state_r <= S_IDLE;
        end else begin
            unique case (state_r)
                S_IDLE: if (start_i) state_r <= S_INIT_SIMT;
                S_INIT_SIMT: if (simt_ready_i) state_r <= S_INIT_MSG_WAITING;
                S_INIT_MSG_WAITING: if (prints_ready_w) state_r <= S_WAIT_MSG_WAITING;
                S_WAIT_MSG_WAITING: if (prints_ready_w) state_r <= S_WAIT_SIMT;
                S_WAIT_SIMT: if (simt_ready_i) state_r <= S_INIT_MEMDUMP;
                S_INIT_MEMDUMP: if (memdump_ready_w) state_r <= S_WAIT_MEMDUMP;
                S_WAIT_MEMDUMP: if (memdump_ready_w) state_r <= S_INIT_MSG_FINISHED;
                S_INIT_MSG_FINISHED: if (prints_ready_w) state_r <= S_WAIT_MSG_FINISHED;
                S_WAIT_MSG_FINISHED: if (prints_ready_w) state_r <= S_IDLE;
            endcase
        end
    end

    logic [(7*8)-1:0] memdump_string_w;
    logic [2:1][31:0] memdump_hex_w;

    logic [(MAX_LEN*8)-1:0] memdump_string_ext_w;
    logic [HEX_COUNT:1][31:0] memdump_hex_ext_w;

    assign memdump_string_ext_w = {memdump_string_w, {(MAX_LEN-7){8'hX}}};
    assign memdump_hex_ext_w = {{(HEX_COUNT-2){32'hX}}, memdump_hex_w};

    logic [(MAX_LEN*8)-1:0] prints_string_w;
    logic [HEX_COUNT:1][31:0] prints_hex_w;

    always_comb begin
        unique case (state_r)
            S_IDLE: begin
                prints_string_w = 'x;
                prints_hex_w = 'x;
            end
            S_INIT_SIMT: begin 
                prints_string_w = 'x;
                prints_hex_w = 'x;
            end
            S_INIT_MSG_WAITING: begin
                prints_string_w = {"Waiting for SIMT core to finish...", CRLF, NULL, {MAX_LEN-37{8'hX}}};
                prints_hex_w = 'x;
            end
            S_WAIT_MSG_WAITING: begin
                prints_string_w = 'x;
                prints_hex_w = 'x;
            end
            S_WAIT_SIMT: begin
                prints_string_w = 'x;
                prints_hex_w = 'x;
            end
            S_INIT_MEMDUMP: begin
                prints_string_w = memdump_string_ext_w;
                prints_hex_w = memdump_hex_ext_w;
            end
            S_WAIT_MEMDUMP: begin
                prints_string_w = memdump_string_ext_w;
                prints_hex_w = memdump_hex_ext_w;
            end
            S_INIT_MSG_FINISHED: begin
                prints_string_w = {"Finished!", CRLF, NULL, {MAX_LEN-12{8'hX}}};
                prints_hex_w = 'x;
            end
            S_WAIT_MSG_FINISHED: begin
                prints_string_w = 'x;
                prints_hex_w = 'x;
            end
        endcase
    end

    logic memdump_to_prints_start_w;

    logic memdump_start_w;
    logic memdump_ready_w;

    logic prints_start_w;
    logic prints_ready_w;

    always_comb begin
        unique case (state_r)
            S_IDLE: prints_start_w = 0;
            S_INIT_SIMT: prints_start_w = 0;
            S_INIT_MSG_WAITING: prints_start_w = 1;
            S_WAIT_MSG_WAITING: prints_start_w = 0;
            S_WAIT_SIMT: prints_start_w = 0;
            S_INIT_MEMDUMP: prints_start_w = memdump_to_prints_start_w;
            S_WAIT_MEMDUMP: prints_start_w = memdump_to_prints_start_w;
            S_INIT_MSG_FINISHED: prints_start_w = 1;
            S_WAIT_MSG_FINISHED: prints_start_w = 0;
        endcase
    end

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

    memdump #(
        .W_ADDR(W_ADDR),
        .MEM_DELAY(MEM_DELAY)
    ) u_memdump (
        .clk(clk),
        .rst_n(rst_n),
        .string_o(memdump_string_w),
        .hex_o(memdump_hex_w),
        .prints_start_o(memdump_to_prints_start_w),
        .prints_ready_i(prints_ready_w),
        .mem_addr_o(block_mem_addr_o),
        .mem_dout_i(block_mem_dout_i),
        .addr_start_i(0), // FIXME
        .addr_end_i(8), // FIXME
        .start_i(memdump_start_w),
        .ready_o(memdump_ready_w)
    );


    assign simt_start_o = (state_r == S_INIT_SIMT);
    assign memdump_start_w = (state_r == S_INIT_MEMDUMP);

    assign ready_o = (state_r == S_IDLE);

endmodule

`default_nettype wire