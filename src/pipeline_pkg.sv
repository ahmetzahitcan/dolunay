`default_nettype none

package pipeline_pkg;
    typedef enum logic [1:0] {
        MSEL_IROM,
        MSEL_WRAM,
        MSEL_TLOCAL,
        MSEL_UNDEFINED='x
    } msel_e;
endpackage

`default_nettype wire
