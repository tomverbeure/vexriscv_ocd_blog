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
    int mepc    = csr_read(mepc);       // Address of trap
    int mtval   = csr_read(mtval);      // Instruction value of trap
    int mcause  = csr_read(mcause);     // Reason for the trap

    // Grab trap exception status registers and store them in some global
    // variables for each access by debugger...
    exception_addr  = mepc;
    exception_instr = mtval;
    exception_cause = mcause;

    // Insert an EBREAK instruction so that the CPU will halt, and a connected debugger
    // will report the halt to the user.
    asm volatile (
        " ebreak \n"
    );

    // Add endless loop so that we stay in the trap function when the VexRiscv has been
    // compiled without EBREAK instruction support.
    while(1)
        ;
}

void wait_led_cycle(int ms)
{
    if (REG_RD_FIELD(STATUS, SIMULATION) == 1){
        // Wait for a much shorter time when simulation...
        wait_cycles(100);
    }
    else{
        wait_ms(ms);
    }
}

int global_cntr = 0;
int mul_result = 0;

int main() 
{
    global_cntr = 0;

    while(1){
        int wait_time = REG_RD_FIELD(STATUS, BUTTON) ? 100 : 200;

#if 0
        if (!REG_RD_FIELD(STATUS, BUTTON)){
            // By default, the Makefile specifies "MARCH = rv32ic", but if we change that
            // to "MARCH = rv32imc", then this code will result in a trap if we press the button.
            mul_result = global_cntr * global_cntr;
        }
#endif

        REG_WR(LED_CONFIG, 0x01);
        wait_led_cycle(wait_time);

        REG_WR(LED_CONFIG, 0x02);
        wait_led_cycle(wait_time);

        REG_WR(LED_CONFIG, 0x04);
        wait_led_cycle(wait_time);

        global_cntr++;
    }
}
