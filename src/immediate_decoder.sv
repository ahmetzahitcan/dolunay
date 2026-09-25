`default_nettype none

module immediate_decoder
    import params_pkg::*;
    import control_unit_pkg::*;
(
`ifndef SYNTHESIS
    input wire logic [RLEN-1:Z_PC] sim__pc_i,
    input wire logic sim__runasserts_i,
`endif
    input wire logic [31:2] undec_instr32_i,
    input wire imm_type_e imm_type_i,
    output logic [RLEN-1:0] imm_o
);

    logic sign;
    assign sign = undec_instr32_i[31];

    always_comb begin
        imm_o = 'x;
        unique case (imm_type_i)
            IMM_TYPE_I: imm_o = {{RLEN-12{sign}}, undec_instr32_i[31:20]};
            IMM_TYPE_U: imm_o = {{RLEN-32{sign}}, undec_instr32_i[31:12], 12'b0};
            /*IMM_TYPE_B: begin
                imm_o = {{RLEN-12{sign}}, undec_instr32_i[7], undec_instr32_i[30:25], undec_instr32_i[11:8], 1'b0};
                // FIXME: Spurious errors due to IROM data
                assert (~sim__runasserts_i || imm_o[Z_PC-1:0] == 0) else $error("PC=%0d: Branch immediate is not aligned to PC_ALIGN", sim__pc_i);
            end
            IMM_TYPE_S: imm_o = {{RLEN-12{sign}}, undec_instr32_i[31:25], undec_instr32_i[11:7]};
            IMM_TYPE_J: begin
                imm_o = {{RLEN-20{sign}}, undec_instr32_i[19:12], undec_instr32_i[20], undec_instr32_i[30:21], 1'b0};
                // FIXME: Spurious errors due to IROM data
                assert (~sim__runasserts_i || imm_o[Z_PC-1:0] == 0) else $error("PC=%0d: Jump immediate is not aligned to PC_ALIGN", sim__pc_i);
                end*/
        endcase
    end

endmodule

`default_nettype wire
