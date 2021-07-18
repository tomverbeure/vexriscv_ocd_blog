#include <stdint.h>
#include <stdlib.h>
#include <math.h>

#include "riscv.h"
#include "reg.h"
#include "top_defines.h"
#include "lib.h"

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

            void (*func)(void) = (void (*)(void))0x00004000;
            func();
#if 0
        if (!REG_RD_FIELD(STATUS, BUTTON)){
            // Jump to an address that falls outside instruction RAM.
            // This will result in a bus error, and thus a trap.
            void (*func)(void) = (void (*)(void))0x00004000;
            func();
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
