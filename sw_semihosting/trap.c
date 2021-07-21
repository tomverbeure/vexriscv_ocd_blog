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

        if (mcause == 0x00000003 && mtval == 0x00100073){
            // This trap was triggered by an EBREAK instruction that
            // was not the one right here below.
            // There can be 2 reasons for this:
            // * the EBREAK was created by GDB to serve as a soft breakpoint.
            //   In this case, the VexRiscv will halt, because it will always halt on EBREAK
            //   as soon as openocd has connected to the DebugPlugin at least once.
            //   When GDB is done dealing with the breakpoint, it will itself set the PC
            //   to whichever value is needed, and continue. In this case, the instruction
            //   below doesn't matter.
            // * the EBREAK was part of the semihosting call. (See semihosting.c)
            //   When a debugger is connected, this will once again result in a CPU halt,
            //   OpenOCD will service the semihosting call, and the OpenOCD will again
            //   set the PC to whichever value is necessary. The instruction below will, again,
            //   not be executed.
            //   HOWEVER, if the semihosting function is called when no debugger was ever attached,
            //   then this trap will still be called. The best course of action, then, is
            //   to simply return from the trap and let the semihosting function continue to
            //   prevent the CPU from hanging in the trap handler. This way, you can test the
            //   firmware that runs on the VexRiscv without debugger attached, but with semihosting
            //   calls active.
            csr_write(mepc, mepc+4);
            return;
        }
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

