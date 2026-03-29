module memory_access_unit #(
    parameter int NUM_THREADS = 32,
    parameter int DATA_WIDTH = 32,
    parameter int ADDR_WIDTH = 32,

    localparam int LOG_NUM_THREADS = $clog2(NUM_THREADS),
    localparam int MEM_DATA_WIDTH = DATA_WIDTH * NUM_THREADS,
    localparam int MEM_ADDR_WIDTH = ADDR_WIDTH - LOG_NUM_THREADS
) (
    input logic clk,
    input logic rst_n,
    input logic start_i,
    input logic store_i,
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

logic store_r;
logic [NUM_THREADS-1:0] active_mask_r;
logic [NUM_THREADS-1:0][ADDR_WIDTH-1:0] addr_r;
logic [NUM_THREADS-1:0][DATA_WIDTH-1:0] data_r;
always_ff @(posedge clk) begin
    if (state_r == IDLE) begin
        store_r       <= store_i;
        active_mask_r <= active_mask_i;
        addr_r        <= addr_i;
        data_r        <= data_i;
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

// logic [NUM_THREADS-1:0][DATA_WIDTH-1:0] data_r; -- This is already defined above
logic [MEM_DATA_WIDTH-1:0] mem_data_r;

logic [LOG_NUM_THREADS-1:0] gather_scatter_thread_lowaddr_w;
assign gather_scatter_thread_lowaddr_w = addr_r[gather_scatter_working_index_w][LOG_NUM_THREADS-1:0];

always_ff @(posedge clk) begin
    unique0 case (state_r)
    /* -- Not needed anymore, since "preserve inputs" part also does this
        IDLE: begin
            data_r <= data_i;
        end
    */
        READ2: begin
            mem_data_r <= mem_data_i;
        end
        GATHER: begin
            data_r[gather_scatter_working_index_w] <= mem_data_r[gather_scatter_thread_lowaddr_w * DATA_WIDTH +: DATA_WIDTH];
        end
        SCATTER: begin
            mem_data_r[gather_scatter_thread_lowaddr_w * DATA_WIDTH +: DATA_WIDTH] <= data_r[gather_scatter_working_index_w];
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
            if (store_r) begin
                next_state_w = SCATTER;
            end else begin
                next_state_w = GATHER;
            end
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