// =============================================================================
// register_file.sv — SIMD register file (NUM_WARPS × NUM_REGISTERS × NUM_THREADS × XLEN)
// =============================================================================
module register_file
    import params_pkg::*;
(
    input  logic clk,
    input  logic rst_n,

    input logic [LOG_NUM_WARPS-1:0] read_warp_id_i,
    input logic [LOG_NUM_WARPS-1:0] write_warp_id_i,

    // Read port 1
    input  logic [LOG_NUM_REGISTERS-1:0]       rs1_addr_i,
    output logic [NUM_THREADS-1:0][XLEN-1:0]  rs1_data_o,

    // Read port 2
    input  logic [LOG_NUM_REGISTERS-1:0]       rs2_addr_i,
    output logic [NUM_THREADS-1:0][XLEN-1:0]  rs2_data_o,

    // Write port
    input  logic [NUM_THREADS-1:0]          write_en_mask_i,
    input  logic [LOG_NUM_REGISTERS-1:0]        write_addr_i,
    input  logic [NUM_THREADS-1:0][XLEN-1:0]   write_data_i
);

    assert property 
        (@(posedge clk) disable iff (!rst_n) (read_warp_id_i != write_warp_id_i) || (write_en_mask_i == '0)) 
        else $error("Register file read and write from same warp");

    // Storage: each register holds NUM_THREADS × XLEN bits

    logic [NUM_WARPS-1:0][NUM_REGISTERS:1][NUM_THREADS-1:0][XLEN-1:0] regs_r;

    // Synchronous reads and write

    logic [NUM_THREADS-1:0][XLEN-1:0] rs1_data_r, rs2_data_r;

    assign rs1_data_o = rs1_data_r;
    assign rs2_data_o = rs2_data_r;

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            for (int i = 0; i < NUM_WARPS; i++) begin
                for (int j = 0; j < NUM_THREADS; j++) begin
                    for (int k = 0; k < NUM_REGISTERS; k++) begin
                        regs_r[i][k][j] <= '0;
                    end
                end
            end
        end else begin
            for (int i = 0; i < NUM_THREADS; i++) begin
                if (write_en_mask_i[i] && (write_addr_i != '0)) begin
                    regs_r[write_warp_id_i][write_addr_i][i] <= write_data_i[i];
                end
            end

            rs1_data_r <= rs1_addr_i == 0 ? '0 : regs_r[read_warp_id_i][rs1_addr_i];
            rs2_data_r <= rs2_addr_i == 0 ? '0 : regs_r[read_warp_id_i][rs2_addr_i];
        end
    end

endmodule
