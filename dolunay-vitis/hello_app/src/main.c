#include <stdio.h>
#include "xparameters.h"
#include "xil_io.h"
#include "xil_printf.h"
#include "sleep.h"

// Define Base Addresses
#define BRAM_BASE_ADDR   0xC0000000
#define UART_BASE_ADDR   0x40600000

// Uartlite Register Offsets
#define UART_TX_FIFO     0x04
#define UART_STATUS_REG  0x08
#define UART_TX_FULL     0x08 // Bit 3 of Status Reg

void uart_put_char(char c) {
    // Wait while the TX FIFO is full
    while (Xil_In32(UART_BASE_ADDR + UART_STATUS_REG) & UART_TX_FULL);
    
    // Write the character to the TX FIFO
    Xil_Out32(UART_BASE_ADDR + UART_TX_FIFO, (u32)c);
}

int main() {
    xil_printf("Test test");
    
    // 1) Sleep for a short bit (500ms)
    usleep(500000);

    // Pointer to the string in BRAM
    char *bram_ptr = (char *)BRAM_BASE_ADDR;

    // 2 & 3) Read null-terminated string and output to UART
    while (*bram_ptr != '\0') {
        uart_put_char(*bram_ptr);
        bram_ptr++;
    }

    return 0;
}