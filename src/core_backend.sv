`default_nettype none

module core_backend
    import params_pkg::*;
    import core_pkg::*;
    import control_unit_pkg::*;
(
    input wire logic clk,
    input wire logic rst_n,

    input wire logic [N_FUNCTION_UNITS-1:0] fu_out_valid_i,
    output logic [N_FUNCTION_UNITS-1:0] fu_out_ready_o,
    input wire fu_result_s fu_out_result_i [0:N_FUNCTION_UNITS-1],

    output warp_id_t sb_warp_id_o,
    output reg_id_t sb_rel_idx_o,
    output regfile_sel_e sb_rel_regfile_o,
    output seq_t sb_rel_seq_o,
    output logic sb_rel_en_o,
    input wire logic sb_rel_valid_i,

    output warp_id_t rf_warp_id_o,
    output simd_mask_t rf_write_en_mask_o,
    output reg_id_t rf_rd_idx_o,
    output regfile_sel_e rf_rd_regfile_o,
    output simd_data_t  rf_write_data_o,

    output warp_id_t hsb_warp_id_o,
    output hazard_mask_t hsb_rel_mask_o,
    output seq_t hsb_rel_seq_o,
    input wire hazard_mask_t hsb_rel_valid_i
);
    // Pipeline control
    logic cl_fu_handshake_w;

    // - Indicate whether a stage contains a valid instruction.
    logic wb_stage_valid_r, cm_stage_valid_r;

    // - Indicate whether ROB has a valid output
    logic rob_output_valid_w;

    // - Indicate whether a stage should stall.
    logic cl_stage_stall_w, wb_stage_stall_w, rob_stall_w, cm_stage_stall_w;

    assign cl_stage_stall_w = wb_stage_stall_w;
    assign wb_stage_stall_w = rob_stall_w;
    assign rob_stall_w = '0;

    assign cm_stage_stall_w = '0;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            wb_stage_valid_r <= '0;
        end else begin
            if (!wb_stage_stall_w) wb_stage_valid_r <= !cl_stage_stall_w && cl_fu_handshake_w;
            if (!cm_stage_stall_w) cm_stage_valid_r <= rob_output_valid_w;
        end
    end

    // Writeback stage registers
    fu_result_s wb_fu_result_r;

    // ROB registers
    fu_result_s rob_fu_result_r;

    // Commit stage registers
    fu_result_s cm_fu_result_r;

    // Collect stage
    logic [W_FUNCTION_UNITS-1:0] cl_fu_index_w;

    fu_result_s cl_fu_result_w;
    assign cl_fu_result_w = fu_out_result_i[cl_fu_index_w];

    logic [N_FUNCTION_UNITS-1:0] fu_sel_w;
    assign fu_out_ready_o = !cl_stage_stall_w ? fu_sel_w : '0;

    logic cl_pe_valid_w;
    assign cl_fu_handshake_w = !cl_stage_stall_w ? cl_pe_valid_w : 0;

    priority_encoder #(
        .WIDTH   (N_FUNCTION_UNITS)
     ) u_fu_handshake_unit (
    	.input_i  (fu_out_valid_i),
    	.one_hot_o(fu_sel_w),
    	.index_o  (cl_fu_index_w),
       	.valid_o  (cl_pe_valid_w)
    );

    always_ff @(posedge clk) begin
        if (!wb_stage_stall_w) begin
            wb_fu_result_r <= cl_fu_result_w;
        end
    end

    // Writeback stage

    assign sb_warp_id_o = wb_fu_result_r.warp_id;
    assign sb_rel_idx_o = wb_fu_result_r.instr.rd_idx;
    assign sb_rel_regfile_o = wb_fu_result_r.instr.rd_regfile;
    assign sb_rel_seq_o = wb_fu_result_r.seq;
    assign sb_rel_en_o = wb_stage_valid_r &&
        wb_fu_result_r.instr.rd_used &&
        !(wb_fu_result_r.instr.rd_idx == 0 && wb_fu_result_r.instr.rd_regfile == REGFILE_SEL_I);

    logic rf_writeback_w;
    assign rf_writeback_w = wb_stage_valid_r && wb_fu_result_r.instr.rd_used && sb_rel_valid_i;

    assign rf_warp_id_o = wb_fu_result_r.warp_id;
    assign rf_write_en_mask_o = rf_writeback_w ? wb_fu_result_r.mask : 0;
    assign rf_rd_idx_o = wb_fu_result_r.instr.rd_idx;
    assign rf_rd_regfile_o = wb_fu_result_r.instr.rd_regfile;
    assign rf_write_data_o = wb_fu_result_r.result;

    always_ff @(posedge clk) begin
        if (!rob_stall_w) begin
            rob_fu_result_r <= wb_fu_result_r;
        end
    end

    // ROB

    fu_result_s rob_r [0:N_WARPS-1][0:ROB_SIZE-1];
    logic [N_WARPS-1:0][ROB_SIZE-1:0] rob_valid_r;
    logic [N_WARPS-1:0][W_ROB_ADDR-1:0] rob_head_r;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            rob_valid_r <= '0;
            rob_head_r <= '0;
        end else begin
            if (!rob_stall_w) begin
                rob_r[rob_fu_result_r.warp_id][rob_fu_result_r.seq] <= rob_fu_result_r;
                rob_valid_r[rob_fu_result_r.warp_id][rob_fu_result_r.seq] <= 1;
            end

            rob_output_valid_w <= 0;
            if (!cm_stage_stall_w) begin
                for (int i = 0; i < N_WARPS; i++) begin
                    if (rob_valid_r[i][rob_head_r[i]]) begin
                        cm_fu_result_r <= rob_r[i][rob_head_r[i]];

                        // INFO:    These are the same values stored in the ROB.
                        //          My hope is that if I add them like this,
                        //          synthesizer optimizes ROB to eliminate these.
                        //
                        // TODO:    Check if the ROB is actually optimized.
                        //          (If not, instr_s might be a problem in general)
                        cm_fu_result_r.warp_id <= i[W_WARPS-1:0];
                        cm_fu_result_r.seq <= rob_head_r[i];

                        rob_valid_r[i][rob_head_r[i]] <= 0;
                        rob_head_r[i] <= rob_head_r[i] + 1;

                        rob_output_valid_w <= 1;
                        break;
                    end
                end
            end
        end
    end

    // Commit stage

    // - Hazards Scoreboard Release

    assign hsb_warp_id_o = cm_fu_result_r.warp_id;
    assign hsb_rel_seq_o = cm_fu_result_r.seq;

    always_comb begin
        hsb_rel_mask_o = '0;
        if (cm_stage_valid_r) begin
            for(int i = 0; i < N_HAZARDS; i++) begin
                unique case(cm_fu_result_r.instr.hazards[i])
                    HAZARDS_IGN: hsb_rel_mask_o[i] = 0;
                    HAZARDS_AQ: hsb_rel_mask_o[i] = 1;
                    HAZARDS_CK: hsb_rel_mask_o[i] = 0;
                endcase
            end
        end
    end

endmodule

`default_nettype wire
