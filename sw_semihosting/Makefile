
# When you change the memory size below, make sure to also change it in:
#
# ./sw/sections.lds
# ./sw/start.S
# ./rtl/top.v

MEM_WORDS       = 1024
MEM_BYTES       = 4096

MARCH           = rv32ic
CPU_FREQ_MHZ    = 50
CC_OPT          = -Os

OBJ_FILES       = start.o main.o lib.o trap.o semihosting.o printf.o

OPENOCD_DIR     ?= /opt/openocd_vex
OPENOCD         ?= $(OPENOCD_DIR)/bin/openocd

# Downloaded from https://github.com/sifive/freedom-tools/releases
UNAME_S         = $(shell uname -s)
ifeq ($(UNAME_S),Linux)
    TOOLS_PREFIX    = /opt/riscv64-unknown-elf-toolchain-10.2.0-2020.12.8-x86_64-linux-ubuntu14/bin
endif
ifeq ($(UNAME_S),Darwin)
    TOOLS_PREFIX    = /opt/riscv64-unknown-elf-gcc-10.1.0-2020.08.2-x86_64-apple-darwin/bin
endif

TARGET          = $(TOOLS_PREFIX)/riscv64-unknown-elf

DEFINES         = -DCPU_FREQ=$(CPU_FREQ_MHZ)000000 
DEFINES         += -DPRINTF_INCLUDE_CONFIG_H

AS              = $(TARGET)-as
ASFLAGS         = -march=$(MARCH) -mabi=ilp32
LD              = $(TARGET)-gcc
LDFLAGS         = -march=$(MARCH) -g -ggdb -mabi=ilp32 -Wl,-Tsections.lds,-Map,progmem.map -ffreestanding -nostartfiles -Wl,--no-relax -Wl,--start-group,--end-group
CC              = $(TARGET)-gcc
CFLAGS          = -march=$(MARCH) -g -ggdb -mno-div -mabi=ilp32 -ffunction-sections -fdata-sections -Wall -Wextra -pedantic $(DEFINES) $(CC_OPT)
OBJCOPY         = $(TARGET)-objcopy
OBJDUMP         = $(TARGET)-objdump
READELF         = $(TARGET)-readelf

GDBGUI          = gdbgui

CREATE_MIF      = ../misc/create_mif.rb

.PHONY: all clean 

all: progmem.dis progmem.bin progmem0.hex progmem0.mif

progmem.dis: progmem_dis.elf
	$(OBJDUMP) -s -D $< > $@

progmem0.hex: progmem.bin
	$(CREATE_MIF) -f hex -d $(MEM_WORDS) -w 8 -o 0 -i 4 $< > progmem0.hex
	$(CREATE_MIF) -f hex -d $(MEM_WORDS) -w 8 -o 1 -i 4 $< > progmem1.hex
	$(CREATE_MIF) -f hex -d $(MEM_WORDS) -w 8 -o 2 -i 4 $< > progmem2.hex
	$(CREATE_MIF) -f hex -d $(MEM_WORDS) -w 8 -o 3 -i 4 $< > progmem3.hex

progmem0.mif: progmem.bin
	$(CREATE_MIF) -f mif -d $(MEM_WORDS) -w 8 -o 0 -i 4 $< > progmem0.mif
	$(CREATE_MIF) -f mif -d $(MEM_WORDS) -w 8 -o 1 -i 4 $< > progmem1.mif
	$(CREATE_MIF) -f mif -d $(MEM_WORDS) -w 8 -o 2 -i 4 $< > progmem2.mif
	$(CREATE_MIF) -f mif -d $(MEM_WORDS) -w 8 -o 3 -i 4 $< > progmem3.mif

progmem.bin: progmem.elf
	$(OBJCOPY) -O binary $< $@

progmem.elf: $(OBJ_FILES) top_defines.h sections.lds Makefile 
	$(LD) $(LDFLAGS) -o $@ $(OBJ_FILES) -lm 

progmem_dis.elf: $(OBJ_FILES) top_defines.h sections.lds Makefile
	$(LD) $(LDFLAGS) -o $@ $(OBJ_FILES) -lm 

$(OBJ_FILES): top_defines.h riscv.h semihosting.h reg.h printf.h printf_config.h lib.h

ocd_only:
	$(OPENOCD) -f interface/ftdi/digilent_jtag_smt2.cfg \
		-c "adapter speed 1000; transport select jtag" \
		-f "vexriscv_init.cfg"

ocd_only_sim:
	$(OPENOCD) \
                -d \
                -l openocd.log \
		-c "adapter driver jtag_tcp; adapter speed 1000; transport select jtag" \
		-f "vexriscv_init.cfg" \
		-c "arm semihosting enable"

gdb_only:
	$(TARGET)-gdb -q \
		progmem.elf \
		-ex "target extended-remote localhost:3333" \
		-ex "set remotetimeout unlimited"
gdb: 
	OPENOCD_DIR=$(OPENOCD_DIR) $(TARGET)-gdb -q \
		progmem.elf \
		-x ./gdb_ocd_open.cmd

gdbgui:
	$(GDBGUI) -g '$(TARGET)-gdb -q progmem.elf -ex "target extended-remote localhost:3333"'

clean:
	\rm -fr *.o *.hex *.elf *.dis *.bin *.coe *.map *.mif *.mem *.funcs *.globs
