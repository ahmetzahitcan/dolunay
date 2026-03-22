// =============================================================================
// pipeline_controller.sv — FSM cycling through pipeline stages
// =============================================================================
`default_nettype none

module pipeline_controller (
    input  logic clk,
    input  logic rst_n,

    // Done signals from each stage
    input  logic fetch_done_i,
    input  logic rom_done_i,
    input  logic decode_done_i,
    input  logic execute_done_i,
    input  logic writeback_done_i,

    // Valid signals to each stage
    output logic fetch_valid_o,
    output logic rom_read_en_o,
    output logic decode_valid_o,
    output logic execute_valid_o,
    output logic writeback_valid_o
);

    // -------------------------------------------------------------------------
    // State enumeration
    // -------------------------------------------------------------------------
    typedef enum logic [2:0] {
        S_FETCH     = 3'd0,
        S_ROM_WAIT  = 3'd1,
        S_DECODE    = 3'd2,
        S_EXECUTE   = 3'd3,
        S_WRITEBACK = 3'd4
    } state_t;

    state_t state_r, next_state_w;

    // -------------------------------------------------------------------------
    // Next-state logic
    // -------------------------------------------------------------------------
    always_comb begin
        next_state_w = state_r;

        case (state_r)
            S_FETCH:     if (fetch_done_i)     next_state_w = S_ROM_WAIT;
            S_ROM_WAIT:  if (rom_done_i)       next_state_w = S_DECODE;
            S_DECODE:    if (decode_done_i)     next_state_w = S_EXECUTE;
            S_EXECUTE:   if (execute_done_i)    next_state_w = S_WRITEBACK;
            S_WRITEBACK: if (writeback_done_i)  next_state_w = S_FETCH;
            default:                            next_state_w = S_FETCH;
        endcase
    end

    // -------------------------------------------------------------------------
    // Output logic
    // -------------------------------------------------------------------------
    assign fetch_valid_o     = (state_r == S_FETCH);
    assign rom_read_en_o     = (state_r == S_FETCH);   // kick ROM read in FETCH
    assign decode_valid_o    = (state_r == S_DECODE);
    assign execute_valid_o   = (state_r == S_EXECUTE);
    assign writeback_valid_o = (state_r == S_WRITEBACK);

    // -------------------------------------------------------------------------
    // State register
    // -------------------------------------------------------------------------
    always_ff @(posedge clk) begin
        if (!rst_n)
            state_r <= S_FETCH;
        else
            state_r <= next_state_w;
    end

endmodule

`default_nettype wire
