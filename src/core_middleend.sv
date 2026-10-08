`default_nettype none

/*
    Middle-end of the core. Responsible for instruction executing.
    - Read register file
    - Dispatch to FUs
    - Collect from FUs
*/

module core_middleend
    import params_pkg::*;
    import control_unit_pkg::*;
    import core_pkg::*;
#(
    parameter int OFQ_DEPTH = 2,
    localparam int W_OFQ = $clog2(OFQ_DEPTH)
)(
    input wire logic clk,
    input wire logic rst_n,

    // Input from front-end
    output logic [N_WARPS-1:0] me_ready_o,
    input wire logic [N_WARPS-1:0] me_valid_i,
    input wire me_operation_s me_op_i,

    // Register File - Port A
    output phys_reg_id_t rfa_idx_o,
    input wire logic rfa_write_en_i,
    input wire simd_data_t rfa_data_i,

    // Register File - Port B
    output phys_reg_id_t rfb_idx_o,
    input wire logic rfb_write_en_i,
    input wire simd_data_t rfb_data_i,

    // TODO: If I ever switch to true OoO, these have to be moved to the commit stage.
    output logic branch_complete_o,
    output simd_mask_t branch_mask_o,
    output branch_type_e branch_type_o,
    output warp_id_t branch_warp_id_o,
    output pc_t branch_pc_o,
    output pc_t branch_target_o,

    // FIXME: There is probably a better way to deal with this.
    input wire fpnew_pkg::status_t [N_WARPS-1:0][N_THREADS-1:0] fflags_i
);
    // Function Unit Signals
    logic [N_FUNCTION_UNITS-1:0] fu_in_ready_w;
    logic [N_FUNCTION_UNITS-1:0] fu_in_valid_w;
    fu_operation_s fu_in_operation_w;

    logic [N_FUNCTION_UNITS-1:0] fu_out_ready_w;
    logic [N_FUNCTION_UNITS-1:0] fu_out_valid_w;

    // Operand Fetch Queues
    me_operation_s [N_WARPS-1:0][OFQ_DEPTH-1:0] ofq_r;
    logic [N_WARPS-1:0][W_OFQ-1:0] ofq_wptr_r, ofq_rptr_r, ofq_wptr_p1_w, ofq_rptr_p1_w;

    always_comb begin
        for (int i = 0; i < N_WARPS; i++) begin
            ofq_wptr_p1_w[i] = ofq_wptr_r[i] + 1;
            ofq_rptr_p1_w[i] = ofq_rptr_r[i] + 1;
        end
    end

    logic [N_WARPS-1:0] ofq_empty_r, ofq_full_r;

    assign me_ready_o = ~ofq_full_r;

    logic [N_WARPS-1:0] me_handshake_w;
    assign me_handshake_w = me_valid_i & me_ready_o;

    // Operand Fetch Signals
    logic of_dispatch_ready_w;
    logic of_dispatch_w;
    logic of_valid_r;
    me_operation_s of_operation_r;
    warp_id_t of_warp_id_r;
    function_unit_e of_fu_sel_r;
    simd_data_t of_rs1_buffer_r, of_rs2_buffer_r, of_rs3_buffer_r;
    logic of_rs1_fetched_r, of_rs2_fetched_r, of_rs3_fetched_r;
    logic of_rs1_zero_r, of_rs2_zero_r, of_rs3_zero_r;

    // Next warp selection

    typedef struct packed {
        function_unit_e fu_sel;
        warp_id_t warp_id;
        logic valid;
    } reducer_tag_s;

    localparam int W_REDUCER_VAL = W_FUNCTION_UNITS + 3;

    logic [N_WARPS-1:0][W_REDUCER_VAL-1:0] reducer_vals_w;
    reducer_tag_s [N_WARPS-1:0] reducer_tags_w;
    always_comb begin
        // During simulation, an 'x causes the reducer to freak out.
        // I could have the simulator use bit instead of logic,
        // Which might actually lead to slightly lower LUT usage but...
        // It feels too risky. I might get a simulator-synthesis mismatch.
        // It's a micro-optimization anyway.
        localparam logic[$size(function_unit_e)-1:0] fu_sel_undefined = '1;

        static function_unit_e fu_sel;
        static logic[$size(function_unit_e)-1:0] fu_sel_wrap;
        static logic fu_valid;
        static logic fu_valid_wrap;
        static logic warp_empty;
        static logic warp_full;

        for (int i = 0; i < N_WARPS; i++) begin
            warp_empty = ofq_empty_r[i];
            warp_full = ofq_full_r[i];
            fu_sel = ofq_r[i][ofq_rptr_r[i]].instr.fu_sel;
            fu_sel_wrap = warp_empty ?
                fu_sel_undefined :
                fu_sel;
            fu_valid = fu_in_ready_w[ofq_r[i][ofq_rptr_r[i]].instr.fu_sel];
            fu_valid_wrap = !warp_empty && fu_valid;

            reducer_vals_w[i] = {warp_empty, !fu_valid_wrap, fu_sel_wrap, !warp_full};
            reducer_tags_w[i] = '{
                fu_sel: fu_sel,
                warp_id: W_WARPS'(unsigned'(i)),
                valid: !warp_empty
            };
        end
    end

    reducer_tag_s reducer_res_tag_w;

    function_unit_e ofq_drain_next_fu_sel_w;
    warp_id_t ofq_drain_next_warp_w;
    logic ofq_drain_valid_w;

    assign ofq_drain_next_fu_sel_w = reducer_res_tag_w.fu_sel;
    assign ofq_drain_next_warp_w = reducer_res_tag_w.warp_id;
    assign ofq_drain_valid_w = reducer_res_tag_w.valid;

    minmax_reducer #(
    	.COUNT (N_WARPS),
    	.TAG_TYPE  (reducer_tag_s),
    	.MAX   (0),
        .WIDTH (W_REDUCER_VAL)
     ) minmax_reducer (
        .vals_i(reducer_vals_w),
        .tags_i(reducer_tags_w),
        .res_tag_o(reducer_res_tag_w),

        // INFO: This is merely used as a priority.
        // slang lint_off empty-output-connection
        .res_val_o()
        // slang lint_on empty-output-connection
    );

    logic ofq_drain_w;
    assign ofq_drain_w = (of_dispatch_w || !of_valid_r) && ofq_drain_valid_w;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            ofq_r <= 'x;
            ofq_wptr_r <= '0;
            ofq_rptr_r <= '0;
            ofq_empty_r <= '1;
            ofq_full_r <= '0;
            of_valid_r <= 0;
        end else begin
            for (int i = 0; i < N_WARPS; i++) begin
                automatic logic ofq_drain = ofq_drain_w &&
                    ofq_drain_next_warp_w == warp_id_t'(i);

                if (me_handshake_w[i]) begin
                    ofq_r[i][ofq_wptr_r[i]] <= me_op_i;
                    ofq_wptr_r[i] <= ofq_wptr_p1_w[i];
                end

                if (me_handshake_w[i] && !ofq_drain) begin
                    ofq_empty_r[i] <= 0;
                    ofq_full_r[i] <= ofq_wptr_p1_w[i] == ofq_rptr_r[i];
                end else if (!me_handshake_w[i] && ofq_drain) begin
                    ofq_empty_r[i] <= ofq_rptr_p1_w[i] == ofq_wptr_r[i];
                    ofq_full_r[i] <= 0;
                end
            end

            if (ofq_drain_w) begin
                automatic me_operation_s op = ofq_r[ofq_drain_next_warp_w][ofq_rptr_r[ofq_drain_next_warp_w]];

                of_operation_r <= op;
                ofq_rptr_r[ofq_drain_next_warp_w] <= ofq_rptr_p1_w[ofq_drain_next_warp_w];
                of_warp_id_r <= ofq_drain_next_warp_w;
                of_fu_sel_r <= ofq_drain_next_fu_sel_w;
                of_valid_r <= 1;

                if (op.instr.rs1_used) begin
                    if (op.instr.rs1_idx == 0 && op.instr.rs1_regfile == REGFILE_SEL_I) begin
                        of_rs1_zero_r <= 1;
                    end else begin
                        of_rs1_zero_r <= 0;
                    end
                end else begin
                    of_rs1_zero_r <= 1;
                end

                if (op.instr.rs2_used) begin
                    if (op.instr.rs2_idx == 0 && op.instr.rs2_regfile == REGFILE_SEL_I) begin
                        of_rs2_zero_r <= 1;
                    end else begin
                        of_rs2_zero_r <= 0;
                    end
                end else begin
                    of_rs2_zero_r <= 1;
                end

                if (op.instr.rs3_used) begin
                    if (op.instr.rs3_idx == 0 && op.instr.rs3_regfile == REGFILE_SEL_I) begin
                        of_rs3_zero_r <= 1;
                    end else begin
                        of_rs3_zero_r <= 0;
                    end
                end else begin
                    of_rs3_zero_r <= 1;
                end
            end else if (of_dispatch_w && !ofq_drain_w) begin
                of_operation_r <= 'x;
                of_rs1_zero_r <= 'x;
                of_rs2_zero_r <= 'x;
                of_rs3_zero_r <= 'x;
                of_valid_r <= 0;
            end
        end
    end

    // Operand Fetch Logic
    phys_reg_id_t of_rs1_pidx_w;
    phys_reg_id_t of_rs2_pidx_w;
    phys_reg_id_t of_rs3_pidx_w;

    assign of_rs1_pidx_w = {of_warp_id_r, of_operation_r.instr.rs1_regfile, of_operation_r.instr.rs1_idx};
    assign of_rs2_pidx_w = {of_warp_id_r, of_operation_r.instr.rs2_regfile, of_operation_r.instr.rs2_idx};
    assign of_rs3_pidx_w = {of_warp_id_r, of_operation_r.instr.rs3_regfile, of_operation_r.instr.rs3_idx};

    logic of_rs1_fetching_r, of_rs1_needs_fetching_w;
    logic of_rs2_fetching_r, of_rs2_needs_fetching_w;
    logic of_rs3_fetching_r, of_rs3_needs_fetching_w;

    assign of_rs1_needs_fetching_w = !of_rs1_fetched_r && !of_rs1_zero_r;
    assign of_rs2_needs_fetching_w = !of_rs2_fetched_r && !of_rs2_zero_r;
    assign of_rs3_needs_fetching_w = !of_rs3_fetched_r && !of_rs3_zero_r;

    assign of_dispatch_ready_w = of_valid_r &&
        !of_rs1_needs_fetching_w &&
        !of_rs2_needs_fetching_w &&
        !of_rs3_needs_fetching_w;

    assign of_dispatch_w = of_dispatch_ready_w && fu_in_ready_w[of_fu_sel_r];

    logic rfb_sel_w;
    assign rfb_sel_w = !of_rs1_needs_fetching_w;

    assign rfa_idx_o = of_rs2_pidx_w;
    assign rfb_idx_o = rfb_sel_w ? of_rs3_pidx_w : of_rs1_pidx_w;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            of_rs1_fetching_r <= 0;
            of_rs2_fetching_r <= 0;
            of_rs3_fetching_r <= 0;
            of_rs1_fetched_r <= 0;
            of_rs2_fetched_r <= 0;
            of_rs3_fetched_r <= 0;
        end else begin
            if (ofq_drain_w) begin
                of_rs1_fetching_r <= 0;
                of_rs2_fetching_r <= 0;
                of_rs3_fetching_r <= 0;
                of_rs1_fetched_r <= 0;
                of_rs2_fetched_r <= 0;
                of_rs3_fetched_r <= 0;
            end

            if (of_valid_r && !of_dispatch_ready_w) begin
                // Port A: Used by rd and rs2
                if (!rfa_write_en_i) begin
                    if (of_rs2_needs_fetching_w) begin
                        of_rs2_fetching_r <= 1;
                    end
                end

                if (of_rs2_fetching_r) begin
                    of_rs2_fetching_r <= 0;
                    of_rs2_buffer_r <= rfa_data_i;
                    of_rs2_fetched_r <= 1;
                end

                // Port B: Used by rs1 and rs3
                //         let's still check write_en_i just for good measure
                //         synthesizer should optimize anyway
                if (!rfb_write_en_i) begin
                    if (rfb_sel_w) begin // rs3
                        if (of_rs3_needs_fetching_w) begin
                            of_rs3_fetching_r <= 1;
                        end
                    end else begin // rs1
                        if (of_rs1_needs_fetching_w) begin
                            of_rs1_fetching_r <= 1;
                        end
                    end
                end

                unique0 if (of_rs1_fetching_r) begin
                    of_rs1_fetching_r <= 0;
                    of_rs1_buffer_r <= rfb_data_i;
                    of_rs1_fetched_r <= 1;
                end else if (of_rs3_fetching_r) begin
                    of_rs3_fetching_r <= 0;
                    of_rs3_buffer_r <= rfb_data_i;
                    of_rs3_fetched_r <= 1;
                end
            end
        end
    end

    simd_data_t of_rs1_data_w, of_rs2_data_w, of_rs3_data_w;

    assign of_rs1_data_w = of_rs1_zero_r ? '{default: '0} : of_rs1_buffer_r;
    assign of_rs2_data_w = of_rs2_zero_r ? '{default: '0} : of_rs2_buffer_r;
    assign of_rs3_data_w = of_rs3_zero_r ? '{default: '0} : of_rs3_buffer_r;

    assign fu_in_operation_w = '{
        seq: of_operation_r.seq,
        warp_id: of_warp_id_r,
        instr: of_operation_r.instr,
        pc: of_operation_r.pc,
        mask: of_operation_r.mask,
        rs1_data: of_rs1_data_w,
        rs2_data: of_rs2_data_w,
        rs3_data: of_rs3_data_w
    };

    generate
        for (genvar i = 0; i < N_FUNCTION_UNITS; i++) begin : gen_fu_valid
            assign fu_in_valid_w[i] = of_valid_r && (of_fu_sel_r == i) && of_dispatch_ready_w;
        end
    endgenerate

    // - Function Units

    fu_result_s fu_result_w [0:N_FUNCTION_UNITS-1];

    fu_fpnew u_fpnew (
    	.clk            (clk),
    	.rst_n          (rst_n),
    	.in_valid_i     (fu_in_valid_w[FUNCTION_UNIT_FPU]),
    	.in_ready_o     (fu_in_ready_w[FUNCTION_UNIT_FPU]),
    	.out_valid_o    (fu_out_valid_w[FUNCTION_UNIT_FPU]),
    	.out_ready_i    (fu_out_ready_w[FUNCTION_UNIT_FPU]),
    	.in_operation_i (fu_in_operation_w),
        .out_result_o   (fu_result_w[FUNCTION_UNIT_FPU])
    );

    fu_multialu u_multialu (
    	.clk            (clk),
    	.rst_n          (rst_n),
    	.in_valid_i     (fu_in_valid_w[FUNCTION_UNIT_ALU]),
    	.in_ready_o     (fu_in_ready_w[FUNCTION_UNIT_ALU]),
    	.out_valid_o    (fu_out_valid_w[FUNCTION_UNIT_ALU]),
    	.out_ready_i    (fu_out_ready_w[FUNCTION_UNIT_ALU]),
    	.in_operation_i (fu_in_operation_w),
        .out_result_o   (fu_result_w[FUNCTION_UNIT_ALU])
    );

    fu_csru u_csru (
    	.clk            (clk),
    	.rst_n          (rst_n),
    	.in_valid_i     (fu_in_valid_w[FUNCTION_UNIT_CSRR]),
    	.in_ready_o     (fu_in_ready_w[FUNCTION_UNIT_CSRR]),
    	.out_valid_o    (fu_out_valid_w[FUNCTION_UNIT_CSRR]),
    	.out_ready_i    (fu_out_ready_w[FUNCTION_UNIT_CSRR]),
    	.in_operation_i (fu_in_operation_w),
        .out_result_o   (fu_result_w[FUNCTION_UNIT_CSRR]),
        .fflags_i       (fflags_i)
    );

    fu_bju u_bju (
    	.clk            (clk),
    	.rst_n          (rst_n),
    	.in_valid_i     (fu_in_valid_w[FUNCTION_UNIT_BJU]),
    	.in_ready_o     (fu_in_ready_w[FUNCTION_UNIT_BJU]),
    	.out_valid_o    (fu_out_valid_w[FUNCTION_UNIT_BJU]),
    	.out_ready_i    (fu_out_ready_w[FUNCTION_UNIT_BJU]),
    	.in_operation_i (fu_in_operation_w),
        .out_result_o   (fu_result_w[FUNCTION_UNIT_BJU]),
        .branch_complete_o(branch_complete_o),
        .branch_mask_o(branch_mask_o),
        .branch_type_o(branch_type_o),
        .branch_warp_id_o(branch_warp_id_o),
        .branch_pc_o(branch_pc_o),
        .branch_target_o(branch_target_o)
    );

endmodule

`default_nettype wire
