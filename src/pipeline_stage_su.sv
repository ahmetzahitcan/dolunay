`default_nettype none

module pipeline_stage_su
    import params_pkg::*;
    import control_unit_pkg::*;
    import pipeline_pkg::*;
(
    input wire instr_s masu_instr_r,
    input wire logic [N_THREADS-1:0][XLEN-1:0] masu_alu_result_r,
    input wire logic [Z_ADDR-1:0] masu_leader_alignment_r,

    input wire logic [N_THREADS-1:0][XLEN-1:0] su_tlocal_rdata_w,
    input wire logic [XLEN-1:0] su_wram_rdata_w,
    input wire logic [31:0] su_irom_data_w,

    output logic [N_THREADS-1:0][XLEN-1:0] su_tlocal_rdata_fmt_w,
    output logic [XLEN-1:0] su_wram_rdata_fmt_w,
    output logic [XLEN-1:0] su_irom_data_fmt_w
);

    logic [N_THREADS+1:0][XLEN-1:0] su_rfmt_in_w;
    always_comb begin
        for (int i = 0; i < N_THREADS; i++) begin
            su_rfmt_in_w[i] = su_tlocal_rdata_w[i];
        end
        su_rfmt_in_w[N_THREADS] = su_wram_rdata_w;
        su_rfmt_in_w[N_THREADS+1] = su_irom_data_w;
    end

    logic [N_THREADS+1:0][XLEN-1:0] su_rfmt_out_w;
    always_comb begin
        for (int i = 0; i < N_THREADS; i++) begin
            su_tlocal_rdata_fmt_w[i] = su_rfmt_out_w[i];
        end
        su_wram_rdata_fmt_w = su_rfmt_out_w[N_THREADS];
        su_irom_data_fmt_w = su_rfmt_out_w[N_THREADS+1];
    end

    logic [N_THREADS+1:0][Z_ADDR-1:0] su_rfmt_alignment_w;
    always_comb begin
        for (int i = 0; i < N_THREADS; i++) begin
            su_rfmt_alignment_w[i] = masu_alu_result_r[i][Z_ADDR-1:0];
        end
        su_rfmt_alignment_w[N_THREADS] = masu_leader_alignment_r;
        su_rfmt_alignment_w[N_THREADS+1] = masu_leader_alignment_r;
    end

    mem_read_formatter #(
        .DATA_LEN(N_THREADS + 2)
    ) u_rfmt (
        .opsize_i(masu_instr_r.mem_opsize),
        .extendmode_i(masu_instr_r.mem_extendmode),
        .m_data_i(su_rfmt_in_w),
        .alignment_i(su_rfmt_alignment_w),
        .p_data_o(su_rfmt_out_w)
    );

endmodule

`default_nettype wire
