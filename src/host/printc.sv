`default_nettype none

module printc(
    input  wire logic        clk,
    input  wire logic        rst_n,

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

    // Character to write
    input  wire logic [7:0]  char_i,
    input  wire logic        start_i,
    output      logic        ready_o
);
    // -------------------------------------------------------------------------
    // XilinxUARTLite register map
    // -------------------------------------------------------------------------
    
    localparam logic [6:0] UART_STAT_REG = 7'h8; // status register
    localparam logic [6:0] UART_TX_FIFO  = 7'h4; // write byte here to transmit
    localparam integer     TX_FIFO_FULL  = 3;     // bit 3 of status register

    // -------------------------------------------------------------------------
    // Character
    // -------------------------------------------------------------------------
    logic [7:0] char_r;

    // -------------------------------------------------------------------------
    // FSM
    // -------------------------------------------------------------------------
    typedef enum logic [2:0] { 
        S_IDLE, // Waiting
        S_SETUP_STAT, // Setup STAT_REG read
        S_CHECK_STAT, // Read STAT_REG, check if TX_FIFO_FULL
        S_SETUP_TX, // Setup TX_FIFO write
        S_WRITE_TX, // Write to TX_FIFO, wait for READY
        S_WAIT_BRESP // Wait for BRESP
    } state_e;

    state_e state_r;
    logic awready_recv_r;
    logic wready_recv_r;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            state_r <= S_IDLE;
            ready_o <= 1'b1;
        end else begin
            unique case(state_r)
                S_IDLE: begin
                    if (start_i) begin
                        state_r <= S_SETUP_STAT;
                        char_r <= char_i;
                        ready_o <= 1'b0;
                    end else begin
                        ready_o <= 1'b1;
                    end
                end
                S_SETUP_STAT: begin
                    m_axi_araddr_o <= UART_STAT_REG;
                    m_axi_arvalid_o <= 1'b1;
                    state_r <= S_CHECK_STAT;
                end
                S_CHECK_STAT: begin
                    if (m_axi_arready_i) begin
                        m_axi_arvalid_o <= 1'b0;
                        m_axi_rready_o <= 1'b1;
                    end else if (m_axi_rvalid_i) begin
                        m_axi_rready_o <= 1'b0;
                        if (m_axi_rdata_i[TX_FIFO_FULL]) begin
                            state_r <= S_SETUP_STAT;
                        end else begin
                            state_r <= S_SETUP_TX;
                        end
                    end
                end
                S_SETUP_TX: begin
                    m_axi_awaddr_o <= UART_TX_FIFO;
                    m_axi_awvalid_o <= 1'b1;
                    m_axi_wdata_o <= {24'b0, char_r};
                    m_axi_wstrb_o <= 4'b1111;
                    m_axi_wvalid_o <= 1'b1;
                    awready_recv_r <= 1'b0;
                    wready_recv_r <= 1'b0;
                    state_r <= S_WRITE_TX;
                end
                S_WRITE_TX: begin
                    if (m_axi_awready_i) begin
                        awready_recv_r <= 1'b1;
                        m_axi_awvalid_o <= 1'b0;
                    end
                    if (m_axi_wready_i) begin
                        wready_recv_r <= 1'b1;
                        m_axi_wvalid_o <= 1'b0;
                    end
                    if (awready_recv_r & wready_recv_r) begin
                        m_axi_bready_o <= 1'b1;
                        state_r <= S_WAIT_BRESP;
                    end
                end
                S_WAIT_BRESP: begin
                    if (m_axi_bvalid_i) begin
                        m_axi_bready_o <= 1'b0;
                        ready_o <= 1'b1;
                        state_r <= S_IDLE;
                    end
                end
            endcase
        end
    end


endmodule

`default_nettype wire