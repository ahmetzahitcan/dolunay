`default_nettype none

module prints #(
    parameter int MAX_LEN = 64,
    localparam int IDX_WIDTH = $clog2(MAX_LEN),

    parameter int HEX_COUNT = 3,
    localparam int HEX_IDX_WIDTH = $clog2(HEX_COUNT+1)
) (
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

    // String to write
    input  wire logic [(MAX_LEN*8)-1:0]  string_i,
    input  wire logic [HEX_COUNT:1][31:0] hex_i,

    input  wire logic        start_i,
    output      logic        ready_o
);

    logic [(MAX_LEN*8)-1:0] string_r;
    logic [HEX_COUNT:1][31:0] hex_r;

    enum logic [1:0] { 
        S_IDLE,
        S_READ_CHAR,
        S_WRITE_CHAR,
        S_WRITE_HEX
    } state_r;

    logic [7:0] char_r;
    logic [IDX_WIDTH-1:0] char_idx_r;

    logic [IDX_WIDTH-1:0] char_idx_m1_w;
    assign char_idx_m1_w = char_idx_r - 1'b1;

    logic [7:0] char_w;
    assign char_w = string_r[char_idx_r*8 +: 8];

    logic [HEX_IDX_WIDTH-1:0] hex_idx_w;
    assign hex_idx_w = char_w[HEX_IDX_WIDTH-1:0];

    logic [2:0] hex_digit_idx_r;
    logic [3:0] hex_digit_idx_m1c_w;
    assign hex_digit_idx_m1c_w = hex_digit_idx_r - 1'b1;
    logic [2:0] hex_digit_idx_m1_w;
    assign hex_digit_idx_m1_w = hex_digit_idx_m1c_w[2:0];
    logic hex_digit_idx_c_w;
    assign hex_digit_idx_c_w = hex_digit_idx_m1c_w[3];

    logic [3:0] hex_digit_w;
    assign hex_digit_w = hex_r[hex_idx_w][hex_digit_idx_r*4 +: 4];

    logic [7:0] hex_digit_char_w;
    assign hex_digit_char_w = (hex_digit_w < 10) ? (hex_digit_w + "0") : (hex_digit_w + "A" - 10);

    logic c_start_w;
    assign c_start_w = (state_r == S_WRITE_CHAR || state_r == S_WRITE_HEX);

    logic c_ready_w;

    printc u_printc(
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

        .char_i(char_r),
        .start_i(c_start_w),
        .ready_o(c_ready_w)
    );

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            state_r <= S_IDLE;
        end else begin
            unique case (state_r)
                S_IDLE: begin
                    hex_digit_idx_r <= 3'd7;
                    char_idx_r <= MAX_LEN-1;
                    string_r <= string_i;
                    hex_r <= hex_i;
                    if (start_i) begin
                        state_r <= S_READ_CHAR;
                    end
                end
                S_READ_CHAR: begin
                    if (char_w == 8'h00) begin
                        state_r <= S_IDLE;
                    end else if (char_w <= HEX_COUNT) begin
                        char_r <= hex_digit_char_w;
                        hex_digit_idx_r <= 3'd6;
                        state_r <= S_WRITE_HEX;
                    end else begin
                        char_r <= char_w;
                        char_idx_r <= char_idx_m1_w;
                        state_r <= S_WRITE_CHAR;
                    end
                end
                S_WRITE_CHAR: begin
                    if (c_ready_w) begin
                        state_r <= S_READ_CHAR;
                    end
                end
                S_WRITE_HEX: begin
                    if (c_ready_w) begin
                        hex_digit_idx_r <= hex_digit_idx_m1_w;
                        char_r <= hex_digit_char_w;
                        if (hex_digit_idx_c_w) begin
                            char_idx_r <= char_idx_m1_w;
                            hex_digit_idx_r <= 3'd7;
                            state_r <= S_WRITE_CHAR;
                        end
                    end
                end
            endcase
        end
    end

    assign ready_o = (state_r == S_IDLE);

endmodule

`default_nettype wire