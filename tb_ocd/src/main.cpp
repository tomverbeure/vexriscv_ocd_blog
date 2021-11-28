#include "Vtop.h"
#include "Vtop_top.h"
#include "verilated.h"
#include "verilated_fst_c.h"
#include "verilated_vcd_c.h"

#include "./common/framework.h"
#include "./common/jtag.h"
#include "./common/uart.h"

class topWorkspace : public Workspace<Vtop>{
public:
	topWorkspace() : Workspace("top"){
		ClockDomain *clk = new ClockDomain(&top->clk,NULL,83333,300000);
//		UartRx *uartRx = new UartRx(&top->io_uart_txd,1.0e12/115200);
//		UartTx *uartTx = new UartTx(&top->io_uart_rxd,1.0e12/115200);

		timeProcesses.push_back(clk);
//		timeProcesses.push_back(uartRx);
//		timeProcesses.push_back(uartTx);

		Jtag *jtag = new Jtag(&top->jtag_tms,&top->jtag_tdi,&top->jtag_tdo,&top->jtag_tck,83333*4);
		timeProcesses.push_back(jtag);

		#ifdef TRACE
		//speedFactor = 10e-3;
		//cout << "Simulation caped to " << speedFactor << " of real time"<< endl;
		#endif
	}
};


struct timespec timer_start(){
    struct timespec start_time;
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start_time);
    return start_time;
}

long timer_end(struct timespec start_time){
    struct timespec end_time;
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &end_time);
    uint64_t diffInNanos = end_time.tv_sec*1e9 + end_time.tv_nsec -  start_time.tv_sec*1e9 - start_time.tv_nsec;
    return diffInNanos;
}



int main(int argc, char **argv, char **env) {

	Verilated::randReset(2);
	Verilated::commandArgs(argc, argv);

	printf("BOOT\n");
	timespec startedAt = timer_start();

	topWorkspace().run(100e6);

	uint64_t duration = timer_end(startedAt);
	cout << endl << "****************************************************************" << endl;
	cout << "Had simulate " << workspaceCycles << " clock cycles in " << duration*1e-9 << " s (" << workspaceCycles / (duration*1e-9) << " Khz)" << endl;
	cout << "****************************************************************" << endl << endl;


	exit(0);
}
