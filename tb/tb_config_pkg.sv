// =============================================================================
// tb_config_pkg.sv — Shared configuration for all testbenches
//
// Edit parameters here; every testbench that imports this package picks up
// the change automatically without touching the individual TB files.
// =============================================================================
`timescale 1ns/1ps

package tb_config_pkg;

    // -------------------------------------------------------------------------
    // Reset duration
    //
    // Minimum number of clock cycles rst_n must be held low.
    // Every synchronous register in the DUT must see at least one active
    // clock edge while reset is asserted to reach a defined idle state.
    // Raise this value if the DUT has a deep reset-synchroniser chain.
    // -------------------------------------------------------------------------
    localparam int RST_CYCLES = 16;

endpackage : tb_config_pkg
