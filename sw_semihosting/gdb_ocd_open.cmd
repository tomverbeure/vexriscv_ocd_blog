
target extended-remote | \
    $OPENOCD_DIR/bin/openocd -f interface/ftdi/digilent_jtag_smt2.cfg \
                -c "adapter speed 1000; transport select jtag" \
                -c "gdb_port pipe; log_output openocd.log" \
		-f "vexriscv_init.cfg"
