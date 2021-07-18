#include <stdint.h>
#include <stdlib.h>
#include <math.h>

#include "riscv.h"
#include "reg.h"
#include "top_defines.h"
#include "lib.h"
#include "semihosting.h"

int exception_addr;
int exception_instr;
int exception_cause;

void trap()
{
    int mepc    = csr_read(mepc);       // Address of trap
    int mtval   = csr_read(mtval);      // Instruction value of trap
    int mcause  = csr_read(mcause);     // Reason for the trap

    exception_addr  = mepc;
    exception_instr = mtval;
    exception_cause = mcause;

    if (mcause == 0x00000003 && mtval == 0x00100073){
        // Break instruction
        csr_write(mepc, mepc+4);
    }

    return;
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

int main() 
{
    char str[] = "Hello World!\n";

    trace_write(str, 13);

    while(1){
        int wait_time = REG_RD_FIELD(STATUS, BUTTON) ? 200 : 100;
        trace_write(".", 1);
        REG_WR(LED_CONFIG, 0x01);
        wait_led_cycle(wait_time);

        REG_WR(LED_CONFIG, 0x02);
        wait_led_cycle(wait_time);

        REG_WR(LED_CONFIG, 0x04);
        wait_led_cycle(wait_time);

        global_cntr++;
    }
}
