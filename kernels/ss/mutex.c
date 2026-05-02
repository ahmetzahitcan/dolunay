#include "mutex.h"

void mutex_lock(mutex_t *lock) {
    int tmp;
    
    __asm__ __volatile__ (
        "li      t0, 1               \n" // Prepare the 'locked' value
        "1:                          \n"
        ".insn i 0x0b, 0x4, x0, x0, 0\n" // YIELD
        "lr.w    %0, (%1)            \n" // LR: Load current lock state and reserve address
        "bnez    %0, 1b              \n" // If not 0, lock is held; spin-wait
        "sc.w.aq %0, t0, (%1)        \n" // SC: Try to write 1 with Acquire memory ordering
        "bnez    %0, 1b              \n" // If SC failed (tmp != 0), retry the whole sequence
        : "=&r" (tmp)                    // Output: tmp (success/failure flag)
        : "r" (lock)                     // Input: address of the lock
        : "t0", "memory"                 // Clobbers
    );
}

void mutex_unlock(mutex_t *lock) {
    // A simple atomic store with Release ordering is enough to free the lock.
    // This ensures all previous 'buyruk' results are visible before the lock is 0.
    __asm__ __volatile__ (
        "fence rw, w                \n" // Ensure prior writes complete
        "sw zero, 0(%0)             \n" // Store 0 to unlock
        :
        : "r" (lock)
        : "memory"
    );
}