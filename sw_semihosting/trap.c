#include <stdint.h>
#include <stdlib.h>
#include <math.h>

#include "riscv.h"
#include "reg.h"
#include "top_defines.h"
#include "lib.h"

#define EBREAK_OPCODE   0x00100073
#define EBREAK_MCAUSE   0x00000003

#define SLLI_X0_X0_0X1F_OPCODE  0x01f01013
#define SRAI_X0_X0_0X07_OPCODE  0x40705013

int sh_missing_host = 0;

void trap()
{
    uint32_t mepc   = csr_read(mepc);       // Address of trap
    uint32_t mtval  = csr_read(mtval);      // Instruction value of trap
    uint32_t mcause = csr_read(mcause);     // Reason for the trap

    sh_missing_host = 0;

    if (mcause == EBREAK_MCAUSE && mtval == EBREAK_OPCODE){
        // This trap was caused by an EBREAK...

        int aligned = ((mepc-4) & 0x0f) == 0;
        if (aligned 
            && *(uint32_t *)mepc     == EBREAK_OPCODE 
            && *(uint32_t *)(mepc-4) == SLLI_X0_X0_0X1F_OPCODE
            && *(uint32_t *)(mepc+4) == SRAI_X0_X0_0X07_OPCODE)
        {
            // The EBREAK was part of the semihosting call. (See semihosting.c)
            //
            // If a debugger were connected, this would have resulted in a CPU halt,
            // and the debugger would have serviced the the semihosting call.
            // 
            // However, the semihosting function was called without a debugger being 
            // attached. The best course of action is to simply return from the trap 
            // and let the semihosting function continue after the call to EBREAK to 
            // prevent the CPU from hanging in the trap handler. 
            csr_write(mepc, mepc+4);

            // Set a global variable to tell the semihosting code the the semihosting 
            // call
            // didn't execute on the host.
            sh_missing_host = 1;

            return;
        }

        // EBREAK was not part of a semihosting call. This should not have happened. 
        // Hang forever.
        while(1)
            ;
    }

    // Trap was issued for another reason than an EBREAK.
    // Replace the code below with whatever trap handler you'd normally use. (e.g. interrupt 
    // processing.)
    while(1)
        ;
}
