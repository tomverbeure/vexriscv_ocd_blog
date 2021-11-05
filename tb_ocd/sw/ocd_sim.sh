#/opt/openocd_vex/bin/openocd -c "adapter driver remote_bitbang; remote_bitbang host localhost; remote_bitbang port 7894"
/opt/openocd_vex/bin/openocd -c "adapter driver jtag_tcp; adapter speed 1000" -f vexriscv_init.cfg
