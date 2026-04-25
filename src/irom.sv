`default_nettype none

module irom 
    import params_pkg::*;
    import control_unit_pkg::*;

#(
    parameter int IROM_SIZE,
    localparam int W_IROM_ADDR = $clog2(IROM_SIZE),
    localparam int IROM_DEPTH = IROM_SIZE / ADDR_ALIGN
) (
    input wire  logic clk,
    input wire  logic [W_IROM_ADDR-1:Z_PC]   port_a_addr_i,
    output logic [XLEN-1:0]   port_a_data_o,
    input wire  logic [W_IROM_ADDR-1:Z_PC]   port_b_addr_i,
    output logic [XLEN-1:0]   port_b_data_o
);
    // -------------------------------------------------------------------------
    // Instruction ROM
    // -------------------------------------------------------------------------
    logic [XLEN-1:0] mem_r [0:IROM_DEPTH-1];

    initial begin
        $readmemh("irom.mem", mem_r);
    end

    // -------------------------------------------------------------------------
    // Instruction Disassembly
    // -------------------------------------------------------------------------
    `ifndef SYNTHESIS
    sim__disasm_t sim__disasm_w [IROM_DEPTH];

    instr_s sim__instr_w;
    logic [31:2] sim__undec_instr32_w;
    logic [XLEN-1:Z_PC] sim__pc_w;
    control_unit sim__u_cu(
        .undec_instr32_i(sim__undec_instr32_w),
        .pc_i(sim__pc_w),
        .instr_o(sim__instr_w)
    );

    int instr_count;
    
    initial begin
        for (instr_count = 0; instr_count < $size(mem_r); instr_count++) begin
            if (mem_r[instr_count] === 32'bx) begin 
                break;
            end
        end
        
        for (int i = 0; i < instr_count; i++) begin
            sim__undec_instr32_w = mem_r[i][31:2];
            sim__pc_w = i;
            repeat(10) #0;
            sim__disasm_w[i] = sim__instr_w.sim__disasm;
        end

        for (int i = instr_count; i < IROM_DEPTH; i++) begin
            sim__disasm_w[i] = "INVALID";
        end
    end

    `endif

    // -------------------------------------------------------------------------
    // Synchronous read
    // -------------------------------------------------------------------------
    logic [XLEN-1:0] port_a_data_r;
    assign port_a_data_o = port_a_data_r;

    logic [XLEN-1:0] port_b_data_r;
    assign port_b_data_o = port_b_data_r;

    always_ff @(posedge clk) begin
        port_a_data_r <= mem_r[port_a_addr_i];
        port_b_data_r <= mem_r[port_b_addr_i];
    end

endmodule

`default_nettype wire