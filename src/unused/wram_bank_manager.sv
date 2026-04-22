`default_nettype none

module wram_bank_manager 
    import params_pkg::*;
(
    input wire logic [N_THREADS-1:0] active_mask_i,
    input wire logic [N_THREADS-1:0][W_WRAM_ADDR-1:Z_ADDR] p_addr_i,
    output logic [N_THREADS-1:0] valid_mask_o,

    output logic [N_WRAM_BANKS-1:0][W_WRAM_BANK_ADDR-1:Z_ADDR] m_addr_o,
    output logic [N_WRAM_BANKS-1:0] m_en_o
);
    logic [W_WRAM_BANKS-1:0] bank_id_w [0:N_THREADS-1];
    logic [W_WRAM_BANK_ADDR-1:Z_ADDR] bank_addr_w [0:N_THREADS-1];

    logic [N_THREADS-1:0] valid_mask_w;
    logic [N_THREADS-1:0] access_thread_one_hot_list_w [0:N_WRAM_BANKS-1];
    
    generate
        for (genvar I = 0; I < N_THREADS; I++) begin
            assign bank_id_w[I] = p_addr_i[I][W_WRAM_BANKS-1:W_WRAM_BANK_ADDR];
            assign bank_addr_w[I] = p_addr_i[I][W_WRAM_BANK_ADDR-1:Z_ADDR];
            assign valid_mask_w[I] = access_thread_one_hot_list_w[bank_id_w[I]][I];
        end
    endgenerate

    generate
        for (genvar I = 0; I < N_WRAM_BANKS; I++) begin
            logic [N_THREADS-1:0] access_mask_i;
            for (genvar J = 0; J < N_THREADS; J++) begin
                assign access_mask_i[J] = active_mask_i[J] & (bank_id_w[J] == I);
            end

            logic [W_THREADS-1:0] access_thread_id_w;
            logic access_valid_w;

            priority_encoder #(
                .WIDTH(N_THREADS)
            ) u_priority_encoder (
                .input_i(access_mask_i),
                .one_hot_o(access_thread_one_hot_list_w[I]),
                .index_o(access_thread_id_w),
                .valid_o(access_valid_w)
            );

            assign m_addr_o[I] = bank_addr_w[access_thread_id_w];
            assign m_en_o[I] = access_valid_w; 
        end
    endgenerate

    assign valid_mask_o = valid_mask_w;

endmodule

`default_nettype wire