module immediate_decoder 
    import params_pkg::*;
    import control_unit_pkg::*;
(
    input wire [31:2] undec_instr32_i,
    input imm_type_e imm_type_i,
    output logic [XLEN-1:0] imm_o
);

    logic sign;
    assign sign = undec_instr32_i[31];

    always_comb begin
        case (imm_type_i) inside
            IMM_TYPE_I: imm_o = {{XLEN-12{sign}}, undec_instr32_i[31:20]};
            IMM_TYPE_U: imm_o = {{XLEN-32{sign}}, undec_instr32_i[31:12], 12'b0};
            IMM_TYPE_B: begin 
                imm_o = {{XLEN-12{sign}}, undec_instr32_i[7], undec_instr32_i[30:25], undec_instr32_i[11:8], 1'b0};
                assert (imm_o[LOG_PC_ALIGN-1:0] == 0) else $error("Branch immediate is not aligned to PC_ALIGN");
            end
            IMM_TYPE_S: imm_o = {{XLEN-12{sign}}, undec_instr32_i[31:25], undec_instr32_i[11:7]};
            IMM_TYPE_J: begin
                imm_o = {{XLEN-20{sign}}, undec_instr32_i[19:12], undec_instr32_i[20], undec_instr32_i[30:21], 1'b0};
                assert (imm_o[LOG_PC_ALIGN-1:0] == 0) else $error("Jump immediate is not aligned to PC_ALIGN");
            end
            default: imm_o = 'x;
        endcase
    end

endmodule