// =============================================================================
// memory.sv — Memory access stage: memory_access_unit + proto_sram
// =============================================================================
// `default_nettype none

module memory
    import proto_pkg::*;
    import control_unit_pkg::*;
(
    input  logic clk,
    input  logic rst_n,

    // Pipeline handshake
    input  logic           valid_i,
    output logic           done_o,

    // From execute
    input  decoded_instr_s                   decoded_i,
    input  logic [NUM_LANES-1:0][XLEN-1:0]  rs2_data_i,   // store data (rs2 per lane)
    input  logic [NUM_LANES-1:0][XLEN-1:0]  result_i,      // effective addresses (ALU result)
    input  logic [NUM_THREADS-1:0]           active_mask_i,

    // Pass-through to writeback
    output decoded_instr_s                   decoded_o,
    output logic [NUM_LANES-1:0][XLEN-1:0]  result_o
);

    // =========================================================================
    // MAU / SRAM wire widths (mirror memory_access_unit localparams)
    // =========================================================================
    localparam int MEM_DATA_WIDTH  = XLEN * NUM_THREADS;
    localparam int LOG_NUM_THREADS = $clog2(NUM_THREADS);
    localparam int MEM_ADDR_WIDTH  = 32 - LOG_NUM_THREADS - 2;

    // =========================================================================
    // MAU ↔ SRAM wires
    // =========================================================================
    logic [MEM_DATA_WIDTH-1:0]  sram_rdata_w;
    logic [MEM_DATA_WIDTH-1:0]  mau_wdata_w;
    logic                        mau_en_w;
    logic                        mau_write_w;
    logic [MEM_ADDR_WIDTH-1:0]  mau_addr_w;

    logic [NUM_THREADS-1:0][XLEN-1:0] mau_result_w;  // gathered load data
    logic                               mau_busy_w;

    // =========================================================================
    // Handshake / done logic
    //
    // start_w pulses for exactly one cycle:
    //   – valid_i is high (controller in S_MEMORY)
    //   – it's a memory instruction
    //   – MAU is idle  (!busy)
    //   – we haven't already started this transaction (!mau_active_r)
    //   – MAU hasn't already finished this transaction (!mau_done_r)
    //
    // done_o fires one cycle after:
    //   – non-mem: valid_i asserts
    //   – mem: MAU returns to idle (busy falls while mau_active_r is set)
    // =========================================================================
    logic done_r;
    logic mau_active_r;   // MAU is running
    logic mau_done_r;     // MAU finished, waiting for controller to advance

    assign done_o = done_r;

    logic start_w;
    assign start_w = valid_i
                   && decoded_i.control_signals.mem_active
                   && !mau_busy_w
                   && !mau_active_r
                   && !mau_done_r;

    // Latch decoded/result once per transaction (first valid cycle)
    decoded_instr_s                  decoded_r;
    logic [NUM_LANES-1:0][XLEN-1:0] result_r;
    logic captured_r;

    assign decoded_o = decoded_r;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            done_r      <= 1'b0;
            mau_active_r <= 1'b0;
            mau_done_r  <= 1'b0;
            captured_r  <= 1'b0;
            decoded_r   <= '0;
            result_r    <= '0;
        end else begin
            done_r <= 1'b0;

            // Clear per-transaction state when stage is idle
            if (!valid_i) begin
                captured_r   <= 1'b0;
                mau_done_r   <= 1'b0;
            end

            // Latch inputs once on the first cycle valid_i asserts
            if (valid_i && !captured_r) begin
                decoded_r  <= decoded_i;
                result_r   <= result_i;
                captured_r <= 1'b1;
            end

            // Non-memory instruction: done on next cycle
            if (valid_i && !decoded_i.control_signals.mem_active)
                done_r <= 1'b1;

            // Memory instruction: start MAU
            if (start_w)
                mau_active_r <= 1'b1;

            // MAU finished
            if (mau_active_r && !mau_busy_w) begin
                done_r       <= 1'b1;
                mau_active_r <= 1'b0;
                mau_done_r   <= 1'b1;
            end
        end
    end

    // Result mux: load → gathered MAU output, otherwise → pass-through ALU result
    assign result_o = (decoded_r.control_signals.mem_active
                        && decoded_r.control_signals.mem_loadstore == MEM_LOADSTORE_LOAD)
                     ? mau_result_w
                     : result_r;

    // =========================================================================
    // memory_access_unit instance
    // =========================================================================
    memory_access_unit #(
        .NUM_THREADS (NUM_THREADS),
        .DATA_WIDTH  (XLEN),
        .ADDR_WIDTH  (32)
    ) u_mau (
        .clk          (clk),
        .rst_n        (rst_n),
        .start_i      (start_w),
        .loadstore_i  (decoded_i.control_signals.mem_loadstore),
        .opsize_i     (decoded_i.control_signals.mem_opsize),
        .extendmode_i (decoded_i.control_signals.mem_extendmode),
        .addr_i       (result_i),        // ALU result = per-thread effective address
        .active_mask_i(active_mask_i),
        .data_i       (rs2_data_i),      // rs2 = store data
        .data_o       (mau_result_w),
        .busy_o       (mau_busy_w),
        .mem_data_i   (sram_rdata_w),
        .mem_data_o   (mau_wdata_w),
        .mem_en_o     (mau_en_w),
        .mem_write_o  (mau_write_w),
        .mem_addr_o   (mau_addr_w)
    );

    // =========================================================================
    // proto_sram instance
    // =========================================================================
    proto_sram u_sram (
        .clk         (clk),
        .mem_data_i  (mau_wdata_w),
        .mem_data_o  (sram_rdata_w),
        .mem_en_i    (mau_en_w),
        .mem_write_i (mau_write_w),
        .mem_addr_i  (mau_addr_w)
    );

endmodule

// `default_nettype wire
