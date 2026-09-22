`default_nettype none

module control_unit_ext
    import params_pkg::*;
    import control_unit_pkg::*;
(
`ifndef SYNTHESIS
    input  wire logic sim__runasserts_i,
`endif
    input  wire logic [31:2] undec_instr32_i,
    input  wire logic [XLEN-1:Z_PC] pc_i,
    input  wire logic bsync_1_i,
    output instr_s instr_o
);

    instr_s instr_w;

    control_unit u_control_unit(
`ifndef SYNTHESIS
        .sim__runasserts_i(sim__runasserts_i),
`endif
        .undec_instr32_i(undec_instr32_i),
        .pc_i(pc_i),
        .instr_o(instr_w)
    );

    always_comb begin
        instr_o = instr_w;
        if (bsync_1_i) begin // ~BSYNC_1,, "bsync $i($1)", I, ADDY, ADD, RS1, IMM, NEVER, 0, x, 0,1,0,1,STORE,WORD,BSYNC,x,0,0,0
            //instr_o.imm_type = IMM_TYPE_I; -- Right, this doesn't exist. Fortunately, this only means imm_type cannot change between runs; which is fine.
            instr_o.alu_funct = ALU_FUNCT_ADDY;
            instr_o.alu_addy_funct = ALU_ADDY_FUNCT_ADD;
            instr_o.alu_op1_sel = ALU_OP1_SEL_RS1;
            instr_o.alu_op2_sel = ALU_OP2_SEL_IMM;
            instr_o.branch_cond = BRANCH_COND_NEVER;
            instr_o.wb_active = 1'b0;
            instr_o.wb_source = WB_SOURCE_UNDEFINED;
            instr_o.barr_load = 1'b0;
            instr_o.barr_sync = 1'b1;
            instr_o.yield = 1'b0;
            instr_o.mem_active = 1'b1;
            instr_o.mem_loadstore = MEM_LOADSTORE_STORE;
            instr_o.mem_opsize = MEM_OPSIZE_WORD;
            instr_o.mem_store_source = MEM_STORE_SOURCE_BSYNC;
            instr_o.mem_extendmode = MEM_EXTENDMODE_UNDEFINED;
            instr_o.is_jalr = 1'b0;
            instr_o.is_lr = 1'b0;
            instr_o.is_sc = 1'b0;
            instr_o.is_wdone = 1'b0;
        end
    end

endmodule

`default_nettype wire
