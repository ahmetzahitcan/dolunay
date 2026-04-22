// =============================================================================
// fetch.sv — Fetch stage with thread scheduler (main prototype focus)
// =============================================================================
// `default_nettype none

module fetch
    import proto_pkg::*;
#(
    parameter int N_THREADS = proto_pkg::N_THREADS,
    parameter int PC_WIDTH    = proto_pkg::PC_WIDTH
) (
    input wire  wire logic clk,
    input wire  wire logic rst_n,

    // Pipeline handshake
    input wire  wire logic                valid_i,
    output logic                done_o,

    // Branch feedback from execute
    input wire  wire logic                branch_taken_i,
    input wire  wire logic [N_THREADS-1:0] branch_mask_i,
    input wire  wire logic [PC_WIDTH-1:0] branch_target_i,
    input wire  wire logic                yield_i,
    input wire  wire logic                binit_i,
    input wire  wire logic                bwait_i,

    // output to instruction memory
    output logic [PC_WIDTH-1:0] pc_o,
    output logic [N_THREADS-1:0] active_mask_o
);

    // =========================================================================
    //  Fetch FSM to pulse thread_scheduler safely
    // =========================================================================
    typedef enum logic [1:0] {
        IDLE     = 2'd0,
        DO_FETCH = 2'd1,
        DONE     = 2'd2
    } state_t;

    state_t state_r, next_state_w;

    logic sched_fetch_w;
    logic sched_branch_w;
    logic sched_yield_w;
    logic sched_binit_w;
    logic sched_bwait_w;
    logic done_w;

    always_comb begin
        next_state_w   = state_r;
        sched_fetch_w  = 1'b0;
        sched_branch_w = 1'b0;
        sched_yield_w  = 1'b0;
        sched_binit_w  = 1'b0;
        sched_bwait_w  = 1'b0;
        done_w         = 1'b0;

        case (state_r)
            IDLE: begin
                if (valid_i) begin
                    if (branch_taken_i) begin
                        sched_branch_w = 1'b1;
                        next_state_w   = DO_FETCH;
                    end else if (yield_i) begin
                        sched_yield_w  = 1'b1;
                        next_state_w   = DO_FETCH;
                    end else if (binit_i) begin
                        sched_binit_w  = 1'b1;
                        next_state_w   = DO_FETCH;
                    end else if (bwait_i) begin
                        sched_bwait_w  = 1'b1;
                        next_state_w   = DO_FETCH;
                    end else begin
                        sched_fetch_w  = 1'b1;
                        next_state_w   = DONE;
                    end
                end
            end
            DO_FETCH: begin
                sched_fetch_w = 1'b1;
                next_state_w  = DONE;
            end
            DONE: begin
                done_w = 1'b1;
                if (!valid_i) begin
                    next_state_w = IDLE;
                end
            end
            default: next_state_w = IDLE;
        endcase
    end

    always_ff @(posedge clk) begin
        if (!rst_n) state_r <= IDLE;
        else        state_r <= next_state_w;
    end

    assign done_o = done_w;

    // =========================================================================
    //  Thread Scheduler Instance
    // =========================================================================
    thread_scheduler #(
        .N_THREADS  (N_THREADS),
        .PC_WIDTH     (PC_WIDTH),
        .N_BARRIERS (8) // Default
    ) u_scheduler (
        .clk           (clk),
        .rst_n         (rst_n),
        .fetch_i       (sched_fetch_w),
        .yield_i       (sched_yield_w),
        .binit_i       (sched_binit_w),
        .bwait_i       (sched_bwait_w),
        .bsel_i        ('0),
        .branch_i      (sched_branch_w),
        .pc_branch_i   (branch_target_i),
        .mask_branch_i (branch_mask_i),
        .pc_o          (pc_o),
        .mask_o        (active_mask_o)
    );

endmodule

// `default_nettype wire
