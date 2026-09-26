`default_nettype none

package fu_pkg;
    import params_pkg::*;

    typedef struct packed {
        seq_t seq;
        warp_id_t warp_id;
        control_unit_pkg::instr_s instr;
        pc_t pc;
        simd_mask_t mask;
        simd_data_t rs1_data;
        simd_data_t rs2_data;
        simd_data_t rs3_data;
    } fu_operation_s;

    typedef struct packed {
        seq_t seq;
        warp_id_t warp_id;
        control_unit_pkg::instr_s instr;
        pc_t pc;
        simd_mask_t mask;
        simd_data_t result;
        fpnew_pkg::status_t [N_THREADS-1:0] fpu_status ;
    } fu_result_s;

endpackage

`default_nettype wire
