`default_nettype none

// =============================================================================
// register_file.sv — SIMD register file (N_WARPS × N_REGISTERS × N_THREADS × XLEN)
// =============================================================================
module register_file
    import params_pkg::*;
(
    input logic clk,

    input logic [W_WARPS-1:0] read_warp_id_i,
    input logic [W_WARPS-1:0] write_warp_id_i,

    // Read port 1
    input  logic [W_REGISTERS-1:0]       rs1_idx_i,
    output logic [N_THREADS-1:0][XLEN-1:0]  rs1_data_o,

    // Read port 2
    input  logic [W_REGISTERS-1:0]       rs2_idx_i,
    output logic [N_THREADS-1:0][XLEN-1:0]  rs2_data_o,

    // Write port
    input  logic [N_THREADS-1:0]          write_en_mask_i,
    input  logic [W_REGISTERS-1:0]        rd_idx_i,
    input  logic [N_THREADS-1:0][XLEN-1:0]   write_data_i
);

    `ifndef SYNTHESIS
        assert property 
            (@(posedge clk) (read_warp_id_i != write_warp_id_i) || (write_en_mask_i == '0)) 
            else $error("Register file read and write from same warp");
    `endif

    logic [N_THREADS-1:0][XLEN-1:0] rs1_data_r;
    logic [N_THREADS-1:0][XLEN-1:0] rs2_data_r;

    generate
        for (genvar T = 0; T < N_THREADS; T++) begin
            (* ram_style = "block" *)    
            logic [XLEN-1:0] regs_r [0:(N_WARPS * N_REGISTERS) - 1];
            
            always_ff @(posedge clk) begin
                if (write_en_mask_i[T]) begin
                    regs_r[write_warp_id_i * N_REGISTERS + rd_idx_i] <= write_data_i[T];
                end
            end

            always_ff @( posedge clk ) begin
                rs1_data_r[T] <= regs_r[read_warp_id_i * N_REGISTERS + rs1_idx_i];
                rs2_data_r[T] <= regs_r[read_warp_id_i * N_REGISTERS + rs2_idx_i];
            end
        end
    endgenerate

    logic rs1_zero_r, rs2_zero_r;
    always_ff @( posedge clk ) begin
        rs1_zero_r <= (rs1_idx_i == 0);
        rs2_zero_r <= (rs2_idx_i == 0);
    end

    assign rs1_data_o = rs1_zero_r ? '0 : rs1_data_r;
    assign rs2_data_o = rs2_zero_r ? '0 : rs2_data_r;

endmodule

`default_nettype wire