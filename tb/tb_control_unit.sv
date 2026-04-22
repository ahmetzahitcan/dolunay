// =============================================================================
// tb_control_unit.sv — Basic testbench for control_unit
// =============================================================================
`timescale 1ns/1ps
`default_nettype none

module tb_control_unit;

    // -----------------------------------------------------------------------
    // DUT ports
    // -----------------------------------------------------------------------
    logic [31:2] instr;
    logic        reg_write;
    logic  [1:0] result_src;
    logic        mem_write;
    logic        alu_src;
    logic  [2:0] imm_src;
    logic  [3:0] alu_control;

    // -----------------------------------------------------------------------
    // DUT
    // -----------------------------------------------------------------------
    control_unit dut (
        .instr_i       (instr),
        .reg_write_o   (reg_write),
        .result_src_o  (result_src),
        .mem_write_o   (mem_write),
        .alu_src_o     (alu_src),
        .imm_src_o     (imm_src),
        .alu_control_o (alu_control)
    );

    // -----------------------------------------------------------------------
    // Task: apply instruction and check key signals
    // -----------------------------------------------------------------------
    task automatic check(
        input string      name,
        input logic [31:2] instr_in,
        input logic        exp_reg_write,
        input logic        exp_mem_write,
        input logic        exp_alu_src,
        input logic  [3:0] exp_alu_control
    );
        instr = instr_in;
        #1;
        assert (reg_write   === exp_reg_write)
            else $error("%s: reg_write expected %0b got %0b",   name, exp_reg_write,   reg_write);
        assert (mem_write   === exp_mem_write)
            else $error("%s: mem_write expected %0b got %0b",   name, exp_mem_write,   mem_write);
        assert (alu_src     === exp_alu_src)
            else $error("%s: alu_src expected %0b got %0b",     name, exp_alu_src,     alu_src);
        assert (alu_control === exp_alu_control)
            else $error("%s: alu_control expected %0b got %0b", name, exp_alu_control, alu_control);
        $display("PASS  %s", name);
    endtask

    // -----------------------------------------------------------------------
    // Stimulus
    // -----------------------------------------------------------------------
    initial begin
        // instr_i is bits [31:2] of the RISC-V word → drop the bottom 2.
        // Each pattern below corresponds to the case entries in control_unit.

        // ADD: funct7=0000000, funct3=000, opcode=0110011
        //   full word: 0000000_00000_00000_000_00000_0110011
        //   [31:2]   : 0000000_00000_00000_000_00000_01100 | 11 (drop)
        check("ADD",
            30'b0000000_00000_00000_000_00000_01100,  // funct7=0, rs2=0, rs1=0, funct3=000, rd=0, op=0110011
            1'b1, 1'b0, 1'b0, 4'b0000);

        // SUB: funct7=0100000
        check("SUB",
            30'b0100000_00000_00000_000_00000_01100,
            1'b1, 1'b0, 1'b0, 4'b1000);

        // LW: funct3=010, opcode=0000011
        check("LW",
            30'b00000000000000000010_00000_00000,
            1'b1, 1'b0, 1'b1, 4'b0000);

        // SW: funct3=010, opcode=0100011
        check("SW",
            30'b00000000000000000010_00000_01000,
            1'b0, 1'b1, 1'b1, 4'b0000);

        // BEQ: funct3=000, opcode=1100011
        check("BEQ",
            30'b00000000000000000000_00000_11000,
            1'b0, 1'b0, 1'b0, 4'b0001);

        // CUST: custom-0 encoding from control_unit
        // instr[31:25]=0000000, instr[24:20]=10101, instr[14:12]=111, opcode=0000010
        check("CUST",
            30'b000000010101_00000_111_00000_00010,
            1'b1, 1'b0, 1'b1, 4'b1111);

        // INVALID: something that matches no case — reg_write and mem_write must be 0
        instr = 30'b111111111111111111111111111111;
        #1;
        assert (reg_write === 1'b0)
            else $error("INVALID: reg_write should default to 0");
        assert (mem_write === 1'b0)
            else $error("INVALID: mem_write should default to 0");
        $display("PASS  INVALID (default)");

        $display("\ntb_control_unit: all checks complete.");
        $finish;
    end

endmodule

`default_nettype wire
