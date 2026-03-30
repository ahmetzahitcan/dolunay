module memory_access_unit 
    import control_unit_pkg::*;
#(
    parameter int NUM_THREADS = 32,
    parameter int DATA_WIDTH = 32,
    parameter int ADDR_WIDTH = 32,

    localparam int LOG_NUM_THREADS = $clog2(NUM_THREADS),
    localparam int MEM_DATA_WIDTH = DATA_WIDTH * NUM_THREADS,
    localparam int MEM_ADDR_WIDTH = ADDR_WIDTH - LOG_NUM_THREADS - 2 // -2 for word-alignment
) (
    input logic clk,
    input logic rst_n,
    input logic start_i,
    input mem_loadstore_e loadstore_i,
    input mem_opsize_e opsize_i,
    input mem_extendmode_e extendmode_i,
    input logic [NUM_THREADS-1:0][ADDR_WIDTH-1:0] addr_i,
    input logic [NUM_THREADS-1:0] active_mask_i,
    input logic [NUM_THREADS-1:0][DATA_WIDTH-1:0] data_i,
    output logic [NUM_THREADS-1:0][DATA_WIDTH-1:0] data_o,
    output logic busy_o,

    input logic [MEM_DATA_WIDTH-1:0] mem_data_i,
    output logic [MEM_DATA_WIDTH-1:0] mem_data_o,
    output logic mem_en_o,
    output logic mem_write_o,
    output logic [MEM_ADDR_WIDTH-1:0] mem_addr_o
);

typedef enum logic[2:0] {
    IDLE,
    COALESCE,
    READ1, READ2,
    GATHER, 
    SCATTER,
    WRITE
} state_e;

state_e state_r, next_state_w;

assign busy_o = (state_r != IDLE);

// Preserve inputs

mem_loadstore_e loadstore_r;
mem_opsize_e opsize_r;
mem_extendmode_e extendmode_r;
logic [NUM_THREADS-1:0] active_mask_r;
logic [NUM_THREADS-1:0][ADDR_WIDTH-1:0] addr_r;
//logic [NUM_THREADS-1:0][DATA_WIDTH-1:0] data_r; // Not needed, gather/scatter logic handles this
always_ff @(posedge clk) begin
    if (state_r == IDLE) begin
        loadstore_r   <= loadstore_i;
        opsize_r      <= opsize_i;
        extendmode_r  <= extendmode_i;
        active_mask_r <= active_mask_i;
        addr_r        <= addr_i;
        //data_r        <= data_i;
    end
end

// Priority encoder input/output

logic [NUM_THREADS-1:0] u_pe_input_r;
logic [LOG_NUM_THREADS-1:0] u_pe_output_w;

// Coalesce logic

logic [NUM_THREADS-1:0] coalesce_remaining_mask_r;
logic [LOG_NUM_THREADS-1:0] coalesce_leader_index_w;
assign coalesce_leader_index_w = u_pe_output_w;

logic [MEM_ADDR_WIDTH-1:0] coalesce_base_addr_w;
assign coalesce_base_addr_w = addr_r[coalesce_leader_index_w][ADDR_WIDTH-1:LOG_NUM_THREADS];

logic [NUM_THREADS-1:0] coalesce_mask_w;
always_comb begin
    for (int i = 0; i < NUM_THREADS; i++) begin
        coalesce_mask_w[i] = (addr_r[i][ADDR_WIDTH-1:LOG_NUM_THREADS] == coalesce_base_addr_w) && active_mask_r[i];
    end
end

logic coalesce_final_w;
assign coalesce_final_w = ~|(coalesce_remaining_mask_r & ~coalesce_mask_w);

logic coalesce_done_w;
assign coalesce_done_w = ~|coalesce_remaining_mask_r;

logic [MEM_ADDR_WIDTH-1:0] mem_addr_r;
always_ff @(posedge clk) begin
    if (state_r == COALESCE) mem_addr_r <= coalesce_base_addr_w;
end
assign mem_addr_o = mem_addr_r;


// Gather/scatter logic

logic [NUM_THREADS-1:0] gather_scatter_remaining_mask_r;
logic [LOG_NUM_THREADS-1:0] gather_scatter_working_index_w;
assign gather_scatter_working_index_w = u_pe_output_w;

logic gather_scatter_final_w;
assign gather_scatter_final_w = $onehot(gather_scatter_remaining_mask_r);

logic [NUM_THREADS-1:0][DATA_WIDTH-1:0] data_r;
logic [NUM_THREADS-1:0][DATA_WIDTH-1:0] mem_data_r;

logic [LOG_NUM_THREADS-1:0] gather_scatter_thread_lowaddr_w;
assign gather_scatter_thread_lowaddr_w = addr_r[gather_scatter_working_index_w][LOG_NUM_THREADS-1:2];

logic gather_scatter_half_offset;
assign gather_scatter_half_offset = addr_r[gather_scatter_working_index_w][1];

logic [1:0] gather_scatter_byte_offset;
assign gather_scatter_byte_offset = addr_r[gather_scatter_working_index_w][1:0];

`ifndef SYNTHESIS
always_comb begin
    case (opsize_r)
        MEM_OPSIZE_HALF: assert(gather_scatter_byte_offset[1] == 1'b0) else $error("Invalid half offset");
        MEM_OPSIZE_WORD: assert(gather_scatter_byte_offset == 2'b00) else $error("Invalid word offset");
    endcase
end
`endif

logic extend_w;
always_comb begin
    unique case (extendmode_r)
        MEM_EXTENDMODE_SIGN: begin
            unique case (gather_scatter_byte_offset)
                2'b00: extend_w = mem_data_r[gather_scatter_thread_lowaddr_w][7];
                2'b01: extend_w = mem_data_r[gather_scatter_thread_lowaddr_w][15];
                2'b10: extend_w = mem_data_r[gather_scatter_thread_lowaddr_w][23];
                2'b11: extend_w = mem_data_r[gather_scatter_thread_lowaddr_w][31];
            endcase
        end
        MEM_EXTENDMODE_ZERO: extend_w = 1'b0;
    endcase
end

always_ff @(posedge clk) begin
    unique0 case (state_r)
        IDLE: begin
            data_r <= data_i;
        end
        READ2: begin
            mem_data_r <= mem_data_i;
        end
        GATHER: begin
            unique case (opsize_r)
                MEM_OPSIZE_BYTE: begin
                    unique case (gather_scatter_byte_offset)
                        2'b00: data_r[gather_scatter_working_index_w] <= {{DATA_WIDTH-8{extend_w}}, mem_data_r[gather_scatter_thread_lowaddr_w][7:0]};
                        2'b01: data_r[gather_scatter_working_index_w] <= {{DATA_WIDTH-8{extend_w}}, mem_data_r[gather_scatter_thread_lowaddr_w][15:8]};
                        2'b10: data_r[gather_scatter_working_index_w] <= {{DATA_WIDTH-8{extend_w}}, mem_data_r[gather_scatter_thread_lowaddr_w][23:16]};
                        2'b11: data_r[gather_scatter_working_index_w] <= {{DATA_WIDTH-8{extend_w}}, mem_data_r[gather_scatter_thread_lowaddr_w][31:24]};
                    endcase
                end 
                MEM_OPSIZE_HALF: begin
                    unique case (gather_scatter_half_offset)
                        1'b0: data_r[gather_scatter_working_index_w] <= {{DATA_WIDTH-16{extend_w}}, mem_data_r[gather_scatter_thread_lowaddr_w][15:0]};
                        1'b1: data_r[gather_scatter_working_index_w] <= {{DATA_WIDTH-16{extend_w}}, mem_data_r[gather_scatter_thread_lowaddr_w][31:16]};
                    endcase
                end 
                MEM_OPSIZE_WORD: data_r[gather_scatter_working_index_w] <= mem_data_r[gather_scatter_thread_lowaddr_w];
            endcase
        end
        SCATTER: begin
            unique case (opsize_r)
                MEM_OPSIZE_BYTE: begin
                    unique case (gather_scatter_byte_offset)
                        2'b00: mem_data_r[gather_scatter_thread_lowaddr_w][7:0] <= data_r[gather_scatter_working_index_w][7:0];
                        2'b01: mem_data_r[gather_scatter_thread_lowaddr_w][15:8] <= data_r[gather_scatter_working_index_w][7:0];
                        2'b10: mem_data_r[gather_scatter_thread_lowaddr_w][23:16] <= data_r[gather_scatter_working_index_w][7:0];
                        2'b11: mem_data_r[gather_scatter_thread_lowaddr_w][31:24] <= data_r[gather_scatter_working_index_w][7:0];
                    endcase
                end 
                MEM_OPSIZE_HALF: begin
                    unique case (gather_scatter_half_offset)
                        1'b0: mem_data_r[gather_scatter_thread_lowaddr_w][15:0] <= data_r[gather_scatter_working_index_w][15:0];
                        1'b1: mem_data_r[gather_scatter_thread_lowaddr_w][31:16] <= data_r[gather_scatter_working_index_w][15:0];
                    endcase
                end 
                MEM_OPSIZE_WORD: mem_data_r[gather_scatter_thread_lowaddr_w] <= data_r[gather_scatter_working_index_w];
            endcase
        end
    endcase
end

assign data_o = data_r;
assign mem_data_o = mem_data_r;

// Priority encoder logic

always_comb begin
    case (state_r)
        COALESCE: u_pe_input_r = coalesce_remaining_mask_r;
        GATHER, SCATTER: u_pe_input_r = gather_scatter_remaining_mask_r;
        default: u_pe_input_r = 'x;
    endcase
end

priority_encoder #(
    .WIDTH(NUM_THREADS)
) u_pe (
    .input_i(u_pe_input_r),
    .index_o(u_pe_output_w)
);


// Iteration logic

logic [NUM_THREADS-1:0] next_coalesce_remaining_mask_w;
logic [NUM_THREADS-1:0] next_gather_scatter_remaining_mask_w;

always_comb begin
    next_coalesce_remaining_mask_w = coalesce_remaining_mask_r;
    next_gather_scatter_remaining_mask_w = gather_scatter_remaining_mask_r;
    case (state_r)
        IDLE: begin
            next_coalesce_remaining_mask_w = active_mask_i;
        end
        COALESCE: begin
            next_gather_scatter_remaining_mask_w = coalesce_mask_w;
        end
        GATHER, SCATTER: begin
            if (gather_scatter_final_w) begin
                next_coalesce_remaining_mask_w = coalesce_remaining_mask_r & ~coalesce_mask_w;
            end
            next_gather_scatter_remaining_mask_w[gather_scatter_working_index_w] = 1'b0;
        end
    endcase
end

always_ff @(posedge clk) begin
    coalesce_remaining_mask_r <= next_coalesce_remaining_mask_w;
    gather_scatter_remaining_mask_r <= next_gather_scatter_remaining_mask_w;
end

// State logic

always_comb begin
    next_state_w = state_r;
    unique case (state_r)
        IDLE: begin
            if (start_i) begin
                next_state_w = COALESCE;
            end
        end
        COALESCE: begin
            next_state_w = READ1;
        end
        GATHER: begin
            if (gather_scatter_final_w) begin
                if (coalesce_final_w) begin
                    // check coalesce_final_w instead of coalesce_done_w
                    // because coalesce_remaining_mask_r is updated
                    // at the end of the gather/scatter logic
                    // meaning, it will be updated in the next cycle
                    // as load logic goes 
                    // IDLE -> COALESCE -> READ1/2 -> GATHER (xN) -> COALESCE|IDLE
                    next_state_w = IDLE;
                end else begin
                    next_state_w = COALESCE;
                end
            end
        end
        SCATTER: begin
            if (gather_scatter_final_w) begin
                next_state_w = WRITE;
            end
        end
        READ1: begin
            next_state_w = READ2;
        end
        READ2: begin
            unique case (loadstore_r)
                MEM_LOADSTORE_STORE: next_state_w = SCATTER;
                MEM_LOADSTORE_LOAD: next_state_w = GATHER;
            endcase
        end
        WRITE: begin
            if (coalesce_done_w) begin
                // check coalesce_done_w instead of coalesce_final_w
                // because coalesce_remaining_mask_r is updated
                // at the end of the gather/scatter logic
                // meaning, it is already up to date
                // as store logic goes
                // IDLE -> COALESCE -> READ1/2 -> SCATTER (xN) -> WRITE -> COALESCE|IDLE
                next_state_w = IDLE;
            end else begin
                next_state_w = COALESCE;
            end
        end
    endcase
end

always_ff @(posedge clk) begin
    if (!rst_n) begin
        state_r <= IDLE;
    end else begin
        state_r <= next_state_w;
    end
end

assign mem_en_o    = (state_r == READ1) || (state_r == READ2) || (state_r == WRITE);
assign mem_write_o = (state_r == WRITE);

endmodule