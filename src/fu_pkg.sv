`default_nettype none

package fu_pkg;
    import params_pkg::*;

    typedef struct packed {
        warp_id_t warp_id;
        control_unit_pkg::instr_s instr;
        simd_data_t rs1_data;
        simd_data_t rs2_data;
        simd_data_t rs3_data;
        pc_t pc;
    } operation_s;

    localparam int N_FUNCTION_UNITS = 2;
    localparam int W_FUNCTION_UNIT = $clog2(N_FUNCTION_UNITS);
    typedef enum logic [W_FUNCTION_UNIT-1:0] {
        FUNCTION_UNIT_ALU,
        FUNCTION_UNIT_FPU
    } function_unit_e;

endpackage

`default_nettype wire
