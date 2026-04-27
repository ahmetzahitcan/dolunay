`default_nettype none

module memdump #(
    parameter int W_ADDR = 30,
    parameter int MEM_DELAY = 2
) (
    input  wire logic        clk,
    input  wire logic        rst_n,

    // prints interface
    output      logic [(7*8)-1:0]  string_o,
    output      logic [2:1][31:0] hex_o,

    output      logic        prints_start_o,
    input  wire logic        prints_ready_i,

    // Memory interface
    output      logic [W_ADDR-1:0] mem_addr_o,
    input  wire logic [31:0] mem_dout_i,
    
    // My interface
    input  wire logic [W_ADDR-1:0] addr_start_i,
    input  wire logic [W_ADDR-1:0] addr_end_i,

    input  wire logic        start_i,
    output      logic        ready_o
);

    localparam CRLF = {8'h0D, 8'h0A};

    logic [W_ADDR-1:0] addr_end_r;

    logic [W_ADDR-1:0] addr_r;
    logic [W_ADDR-1:0] addr_p1_w;
    assign addr_p1_w = addr_r + 1'b1;

    logic [MEM_DELAY-1:0] wait_counter_r;
    logic [MEM_DELAY-1:0] wait_counter_next_w;
    assign wait_counter_next_w = {wait_counter_r[MEM_DELAY-2:0], 1'b1};
    logic wait_counter_fin_w;
    assign wait_counter_fin_w = wait_counter_r[MEM_DELAY-1];

    assign mem_addr_o = addr_r;
    assign hex_o[1] = addr_r;
    assign hex_o[2] = mem_dout_i;
    assign string_o = {8'h01, ": ", 8'h02, CRLF, 8'h00};

    assign prints_start_o = (state_r == S_MEMREAD) & wait_counter_fin_w;

    enum logic [1:0] {
        S_IDLE,
        S_MEMREAD,
        S_PRINT,
        S_NEXT
    } state_r;

    assign ready_o = (state_r == S_IDLE);

    always_ff @(posedge clk) begin
        if (~rst_n) begin
            state_r <= S_IDLE;
        end else begin
            unique case (state_r)
                S_IDLE: begin
                    if (start_i) begin
                        state_r <= S_MEMREAD;
                        wait_counter_r <= '0;
                        addr_r <= addr_start_i;
                        addr_end_r <= addr_end_i;
                    end
                end
                S_MEMREAD: begin
                    wait_counter_r <= wait_counter_next_w;
                    if (wait_counter_fin_w) begin
                        state_r <= S_PRINT;
                    end
                end
                S_PRINT: begin
                    if (prints_ready_i) begin
                        state_r <= S_NEXT;
                    end
                end
                S_NEXT: begin
                    wait_counter_r <= '0;
                    addr_r <= addr_p1_w;
                    if (addr_r == addr_end_r) begin
                        state_r <= S_IDLE;
                    end else begin
                        state_r <= S_MEMREAD;
                    end
                end
            endcase
        end
    end

endmodule

`default_nettype wire