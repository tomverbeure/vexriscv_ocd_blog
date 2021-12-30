How to:


- Terminal 1: SW window: `cd ./sw_semihosting`
- Terminal 2: Sim window: `cd ./tb_ocd`
- Terminal 3: GDB window: `cd ./sw_semihosting`

SW window:


* Build firmware: `make`

Sim window:

* Build simulator: `make`
* Start simulation: `make run`

    After this, the CPU will be running. Since OpenOCD hasn't started yet, 
    all EBREAKs of semihosting calls will result in an EBREAK trap, which 
    will result in the continuing to run.

SW window:

* Start OpenOCD: `make ocd_only_sim`

    Starting OpenOCD results in EBREAKs resulting in a HALT. The first semihosting
    call will halt the CPU. 
    There is an "arm semihosting enable" in the startup script, but that command
    gets executed by OpenOCD after the CPU has already halted.

GDB window:

* Start GDB: `make gdb_only`

    GDB will find the CPU in halted state.

* Continue running: `c`

    Since semihosting has been enabled, the EBREAK of the next semihosting
    call won't result in GDB stopping. 


SW window:

* Type a word in the OpenOCD window and press enter. The CPU will read each character
  and print its ASCII value back.

Sim window:

* Stop the simulation.
* `make waves`

