DEBUG?=no
TRACE_FST?=yes
TRACE_VCD?=no
PRINT_PERF?=no
TRACE_START=0
ADDCFLAGS += -CFLAGS -pthread -LDFLAGS -pthread

VERILATOR_ARGS += -DSIMULATION -DSEMIHOSTING_SW

ifeq ($(TRACE_FST),yes)
	VERILATOR_ARGS += --trace-fst
	ADDCFLAGS += -CFLAGS -DTRACE_FST
endif
ifeq ($(TRACE_VCD),yes)
	VERILATOR_ARGS += --trace
	ADDCFLAGS += -CFLAGS -DTRACE_VCD
endif

ifeq ($(DEBUG),yes)
	ADDCFLAGS += -CFLAGS "-g3 -O0"
endif
ifneq ($(DEBUG),yes)
	ADDCFLAGS += -CFLAGS "-O3"
endif
ifeq ($(PRINT_PERF),yes)
	ADDCFLAGS += -CFLAGS -DPRINT_PERF
endif

ADDCFLAGS += -CFLAGS -DTRACE_START=${TRACE_START}



all: clean compile 

run: 
	./obj_dir/Vtop

waves:
	gtkwave top.fst waves.gtkw

verilate: ../rtl/top.v ../spinal/VexRiscvWithDebug.v
	verilator -I../../../.. -cc  $^ -CFLAGS -std=c++11  ${ADDCFLAGS} --gdbbt ${VERILATOR_ARGS} -Wno-WIDTH -Wno-UNOPTFLAT --x-assign unique --exe src/main.cpp
 	
compile: verilate
	make -j -C obj_dir/ -f Vtop.mk Vtop
 	
clean:
	rm -rf obj_dir


 	
