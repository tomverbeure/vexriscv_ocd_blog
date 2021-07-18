#include <stdint.h>
#include <stdlib.h>
#include <math.h>

#include "riscv.h"
#include "reg.h"
#include "top_defines.h"
#include "lib.h"

int exception_addr;
int exception_instr;
int exception_cause;

// This should not be called by anything unless something goes very bad...
void trap()
{
    static int trap_induced_ebreak = 0;

    int mepc    = csr_read(mepc);       // Address of trap
    int mtval   = csr_read(mtval);      // Instruction value of trap
    int mcause  = csr_read(mcause);     // Reason for the trap

    // Grab trap exception status registers and store them in some global
    // variables for each access by debugger. 
    if (!trap_induced_ebreak){
        exception_addr  = mepc;
        exception_instr = mtval;
        exception_cause = mcause;
    }

    // Insert an EBREAK instruction so that the CPU will halt, and a connected debugger
    // will report the halt to the user.
    // However, only do this once, because when a debugger isn't connect, you get
    // an endless cascade of EBREAKs which will ultimately crash the stack.
    if (!trap_induced_ebreak){
        trap_induced_ebreak = 1;
        asm volatile (
            "ebreak\n"
        );
    }

    // Add endless loop so that we stay in the trap function after the first EBREAK, or when 
    // the VexRiscv has been configured without EBREAK instruction support.
    while(1)
        ;
}

