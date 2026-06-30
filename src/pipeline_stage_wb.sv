`default_nettype none

module pipeline_stage_wb
    import params_pkg::*;
    import control_unit_pkg::*;
    import pipeline_pkg::*;
(
    input wire logic wb_stage_valid_r,
    input wire instr_s suwb_instr_r,
    input wire logic [N_THREADS-1:0][XLEN-1:0] suwb_alu_result_r,
    input wire logic [XLEN-1:Z_PC] suwb_pc_r,
    input wire logic [N_THREADS-1:0] suwb_mask_r,
    input wire logic [N_THREADS-1:0] suwb_leader_one_hot_r,
    input wire msel_e [N_THREADS-1:0] suwb_msel_r,
    
    input wire logic [N_THREADS-1:0][XLEN-1:0] suwb_tlocal_rdata_fmt_r,
    input wire logic [XLEN-1:0] suwb_wram_rdata_fmt_r,
    input wire logic [XLEN-1:0] suwb_irom_data_fmt_r,

    output logic [N_THREADS-1:0][XLEN-1:0] wb_write_data_w,
    output logic [N_THREADS-1:0] wb_write_en_mask_w,
    
    output logic [N_THREADS-1:0] barr_load_total_w,
    output logic [N_THREADS-1:0] barr_load_parked_w
);

    logic [N_THREADS-1:0] wb_sc_output_w;
    assign wb_sc_output_w = ~suwb_leader_one_hot_r;

    logic [XLEN-1:0] wb_pc_p4_w;
    assign wb_pc_p4_w = {suwb_pc_r + 1'b1, 2'b00};

    always_comb begin
        wb_write_data_w = 'x;

        if (wb_stage_valid_r & suwb_instr_r.wb_active) begin
            case (suwb_instr_r.wb_source)
                WB_SOURCE_ALU: wb_write_data_w = suwb_alu_result_r;
                WB_SOURCE_MEM: for (int i = 0; i < N_THREADS; i++) begin
                    case (suwb_msel_r[i])
                        MSEL_IROM: wb_write_data_w[i] = suwb_irom_data_fmt_r;
                        MSEL_WRAM: wb_write_data_w[i] = suwb_wram_rdata_fmt_r;
                        MSEL_TLOCAL: wb_write_data_w[i] = suwb_tlocal_rdata_fmt_r[i];
                        default: wb_write_data_w[i] = 'x;
                    endcase
                end
                WB_SOURCE_PC_P4: for (int i = 0; i < N_THREADS; i++) wb_write_data_w[i] = wb_pc_p4_w;
                WB_SOURCE_SC: for (int i = 0; i < N_THREADS; i++) wb_write_data_w[i] = {{(XLEN-1){1'b0}}, wb_sc_output_w[i]};
                default: wb_write_data_w = 'x;
            endcase
        end 
    end

    assign wb_write_en_mask_w = suwb_instr_r.wb_active ? suwb_mask_r : '0;

    assign barr_load_total_w = suwb_wram_rdata_fmt_r[N_THREADS*2-1:N_THREADS];
    assign barr_load_parked_w = suwb_wram_rdata_fmt_r[N_THREADS-1:0];

endmodule

`default_nettype wire
