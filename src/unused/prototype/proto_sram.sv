// =============================================================================
// proto_sram.sv — Synchronous SRAM stub for prototype MAU
// 1-cycle read latency: address+en on cycle N → data valid on cycle N+1
// =============================================================================
// `default_nettype none

module proto_sram
    import proto_pkg::*;
#(
    parameter int DEPTH = 256,

    // Mirror MAU localparams so widths match automatically
    localparam int MEM_DATA_WIDTH  = XLEN * NUM_THREADS,
    localparam int LOG_NUM_THREADS = $clog2(NUM_THREADS),
    localparam int MEM_ADDR_WIDTH  = 32 - LOG_NUM_THREADS - 2,
    localparam int ADDR_BITS       = $clog2(DEPTH)
) (
    input  logic clk,

    input  logic [MEM_DATA_WIDTH-1:0] mem_data_i,   // write data
    output logic [MEM_DATA_WIDTH-1:0] mem_data_o,   // read data (registered)
    input  logic                       mem_en_i,
    input  logic                       mem_write_i,
    input  logic [MEM_ADDR_WIDTH-1:0] mem_addr_i
);

    logic [MEM_DATA_WIDTH-1:0] mem_r [0:DEPTH-1];

    // Initialise to zero so simulation starts clean
    initial begin
        for (int i = 0; i < DEPTH; i++) mem_r[i] = '0;
        mem_data_o = '0;
    end

    always_ff @(posedge clk) begin
        if (mem_en_i) begin
            if (mem_write_i)
                mem_r[mem_addr_i[ADDR_BITS-1:0]] <= mem_data_i;
            else
                mem_data_o <= mem_r[mem_addr_i[ADDR_BITS-1:0]];
        end
    end

endmodule

// `default_nettype wire
