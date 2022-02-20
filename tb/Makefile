# Do 'TRACE_FST=yes make' to dump FST instead of VCD waveforms.
TRACE_FST   ?= no

VERILOG_FILES 	= tb.v ../rtl/top.v ../spinal/VexRiscvWithDebug.v
SW_FILES 		= ../sw/progmem0.hex ../sw/progmem1.hex ../sw/progmem2.hex ../sw/progmem3.hex

ifeq ($(TRACE_FST),yes)
    # -fst tells iverilog/VVP to dump waveforms in FST format.
    # +fst tells tb.v testbench to use waves.fst instead of waves.vcd as waveform file.
	VVP_ARGS += -fst +fst
endif

# Use vvp instead of calling ./tb directly, because that's the only to provide
# additional parameter.
all: ./tb $(SW_FILES)
	vvp ./tb $(VVP_ARGS)

waves_vcd:
	gtkwave waves.vcd waves.gtkw

waves_fst:
	gtkwave waves.fst waves.gtkw

./tb: $(VERILOG_FILES) 
	iverilog -D SIMULATION=1 -o $@ $(VERILOG_FILES)

$(SW_FILES):
	cd ../sw && make

# Run gdbwave
gdbwave: 
	~/projects/gdbwave/src/gdbwave -w waves.fst -c ./configParams.txt

clean:
	\rm -fr *.vcd ./tb *.fst *.fst.hier

