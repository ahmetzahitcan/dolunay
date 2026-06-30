`default_nettype none

module pipeline_stage_ls
    import params_pkg::*;
    import control_unit_pkg::*;
    import pipeline_pkg::*;
(
    input wire logic clk,
    input wire logic rst_n,
    
    input wire instr_s exls_instr_r,
    input wire logic [N_THREADS-1:0][XLEN-1:0] exls_alu_result_r,
    input wire logic [N_THREADS-1:0][XLEN-1:0] exls_rs2_data_r,
    input wire logic [N_THREADS-1:0] exls_mask_r,
    input wire logic [W_WARPS-1:0] exls_warp_id_r,
    input wire logic [XLEN-1:Z_PC] exls_pc_r,
    
    input wire logic ls_stage_valid_r,
    input wire logic [N_WARPS-1:0][N_THREADS-1:0] barr_sync_total_w,
    input wire logic [N_WARPS-1:0][N_THREADS-1:0] barr_sync_parked_next_w,

    output logic [N_WARPS-1:0][N_THREADS-1:0] ls_reservation_r,
    
    output msel_e [N_THREADS-1:0] ls_msel_w,
    output logic [W_THREADS-1:0] ls_leader_id_w,
    output logic [N_THREADS-1:0] ls_leader_one_hot_w,
    output logic ls_leader_valid_w,
    
    output logic [N_THREADS-1:0][XLEN-1:0] ls_store_data_fmt_w,
    output logic [N_THREADS-1:0][ADDR_ALIGN-1:0] ls_store_wen_w,
    output logic [N_THREADS-1:0] ls_coalesced_w,
    output logic [XLEN-1:0] ls_leader_target_w
);

    logic [N_WARPS-1:0][N_THREADS-1:0] ls_reservation_next_w;

    always_ff @( posedge clk ) begin
        if (!rst_n) begin
            ls_reservation_r <= '0;
        end else if (ls_stage_valid_r) begin
            ls_reservation_r <= ls_reservation_next_w;
        end
    end

    always_comb begin
        ls_reservation_next_w = ls_reservation_r;
        if (exls_instr_r.is_lr) begin
            ls_reservation_next_w[exls_warp_id_r] = ls_reservation_r[exls_warp_id_r] | exls_mask_r;
        end else if (exls_instr_r.is_sc) begin
            ls_reservation_next_w = '0;
        end
    end

    always_comb begin
        for (int i = 0; i < N_THREADS; i++) begin
            case (exls_alu_result_r[i][XLEN-1:XLEN-2]) inside
                2'b00: ls_msel_w[i] = MSEL_IROM;
                2'b01: ls_msel_w[i] = MSEL_WRAM;
                2'b1?: ls_msel_w[i] = MSEL_TLOCAL;
                default: ls_msel_w[i] = MSEL_UNDEFINED;
            endcase
        end
    end

    logic [N_THREADS-1:0] ls_leader_candidates_w;

    always_comb begin
        if (exls_instr_r.mem_active) begin
            for (int i = 0; i < N_THREADS; i++) begin
                case (ls_msel_w[i])
                    MSEL_IROM: ls_leader_candidates_w[i] = exls_mask_r[i] & (exls_instr_r.mem_loadstore == MEM_LOADSTORE_LOAD);
                    MSEL_WRAM: begin
                        if (exls_instr_r.is_sc) begin
                            ls_leader_candidates_w[i] = ls_reservation_r[exls_warp_id_r][i] & exls_mask_r[i];
                        end else begin
                            ls_leader_candidates_w[i] = exls_mask_r[i];
                        end
                    end
                    MSEL_TLOCAL: ls_leader_candidates_w[i] = '0;
                    default: ls_leader_candidates_w[i] = '0;
                endcase
            end
        end else begin
            ls_leader_candidates_w = exls_mask_r;
        end
    end

    priority_encoder #(
        .WIDTH(N_THREADS)
    ) u_ls_leader_pe (
        .input_i(ls_leader_candidates_w),
        .index_o(ls_leader_id_w),
        .one_hot_o(ls_leader_one_hot_w),
        .valid_o(ls_leader_valid_w)
    );

    logic [N_THREADS-1:0][XLEN-1:0] ls_store_data_w;

    always_comb begin
        case (exls_instr_r.mem_store_source)
            MEM_STORE_SOURCE_RS2: ls_store_data_w = exls_rs2_data_r;
            MEM_STORE_SOURCE_BINIT: for(int i = 0; i < N_THREADS; i++) begin
                ls_store_data_w[i] = {{(XLEN-N_THREADS*2){1'b0}}, exls_mask_r, {N_THREADS{1'b0}}};
            end
            MEM_STORE_SOURCE_BSYNC: for(int i = 0; i < N_THREADS; i++) begin
                ls_store_data_w[i] = {{(XLEN-N_THREADS*2){1'b0}}, barr_sync_total_w[exls_warp_id_r], barr_sync_parked_next_w[exls_warp_id_r]};
            end
            default: ls_store_data_w = 'x;
        endcase
    end

    logic [N_THREADS-1:0][Z_ADDR-1:0] ls_mem_alignment_w;

    always_comb begin
        for (int i = 0; i < N_THREADS; i++) begin
            ls_mem_alignment_w[i] = exls_alu_result_r[i][Z_ADDR-1:0];
        end
    end

    mem_write_formatter #(
        .DATA_LEN(N_THREADS)
    ) u_wfmt (
        .p_data_i(ls_store_data_w),
        .opsize_i(exls_instr_r.mem_opsize),
        .alignment_i(ls_mem_alignment_w),
        .m_data_o(ls_store_data_fmt_w),
        .m_wen_o(ls_store_wen_w)
    );

    assign ls_leader_target_w = exls_alu_result_r[ls_leader_id_w][XLEN-1:0];

    generate
        for(genvar I = 0; I < N_THREADS; I++) begin : gen_ls_coalesced
            assign ls_coalesced_w[I] = exls_alu_result_r[I][XLEN-1:0] == ls_leader_target_w;
        end
    endgenerate

endmodule

`default_nettype wire
