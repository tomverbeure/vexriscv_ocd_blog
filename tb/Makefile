

VERILOG_FILES 	= tb.v ../rtl/top.v ../spinal/ ../spinal/VexRiscvWithDebug.v
SW_FILES 		= ../sw/progmem0.hex

all: ./tb $(SW_FILES)
	./tb

waves:
	gtkwave waves.vcd

./tb: $(VERILOG_FILES) 
	iverilog -D SIMULATION=1 -o $@ $(VERILOG_FILES)

$(SW_FILES):
	cd ../sw && make

clean:
	\rm -fr *.vcd ./tb

