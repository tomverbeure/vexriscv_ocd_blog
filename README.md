
# VexRiscv and OpenOCD Example Repo

This repo contains the example project that goes with my [VexRiscv and OpenOCD](https://tomverbeure.github.io/2021/03/06/VexRiscv-and-OpenOCD.html)
blog post.

The example design contains a small VexRiscv CPU system.

## VexRiscv Configuration

**CPU Configuration**

The VexRiscv can be configured into a thousand different ways. The exact details
of the configuration parameters can be found in 
[`VexRiscvWithDebug.scala`](blob/main/spinal/src/main/scala/cpu/VexRiscvWithDebug.scala).

A short summary is:

* 5-stage pipeline configuration for a good trade-off between clock speed and area
* Debug feature enabled
* Compressed instructions support for optimal instruction RAM usage.
* No HW multiplier/divide support to save on FPGA resources.
* 64-bit RISC-V cycle counter support.
* trap on EBREAK enabled

    This is not necessary for basic debug support, but it will be useful for semi-hosting
    support. See later.

**Dual-ported CPU Memory**

In many FPGAs, all block RAMs are true dual-ported, and there's no extra cost to use them.
The VexRiscv has a traditional Harvard architecture with separate instruction and data bus.

In this design, I use one port of the RAM for the CPU instruction bus, and the other port 
for the CPU data bus.  This removes the need for arbitration logic that selects between iBus or
dBus requests to memory, because they can happen in parallel.

The 32-bit memory is implemented with 4 8-bit wide RAMs, one for each byte lane. This way, 
I don't rely on the synthesis tool having to infer byte-enable logic...

**Peripheral registers**

The peripheral section contains 1 control register to set the LED values, and 1 status
register to read back the value of a button.

There's also a status bit that indicates whether or not the CPU is running on real
HW or in simulation. I use this bit for cases when I want the same SW image to behave
slightly different between FPGA and testbench. In this case, I use to change
the speed at which LEDs toggle. 

**No interrupts or external timer**

The CPU is generated with external and timer interrupt support enabled, but the inputs
are strapped to 0 in this minimal example.

