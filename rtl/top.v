`default_nettype none

`define JTAG_ENABLED

module top(
        input  wire     clk,
        input  wire     button,
        output reg      led0,
        output reg      led1,
        output reg      led2,

        input  wire     jtag_tck,
        input  wire     jtag_tms,
        input  wire     jtag_tdi,
        output wire     jtag_tdo
    );

    wire                iBus_cmd_valid;
    wire                iBus_cmd_ready;
    wire  [31:0]        iBus_cmd_payload_pc;

    reg                 iBus_rsp_valid;
    wire                iBus_rsp_payload_error;
    reg   [31:0]        iBus_rsp_payload_inst;

    wire                dBus_cmd_valid;
    wire                dBus_cmd_ready;
    wire                dBus_cmd_payload_wr;
    wire  [31:0]        dBus_cmd_payload_address;
    wire  [31:0]        dBus_cmd_payload_data;
    wire  [1:0]         dBus_cmd_payload_size;

    reg                 dBus_rsp_ready;
    wire                dBus_rsp_error;
    wire  [31:0]        dBus_rsp_data;

    reg   [7:0]         reset_vec = 8'hff;
    wire                reset;

    // 8 clock cycles of active-high reset.
    always @(posedge clk) begin
        reset_vec       <= { reset_vec[6:0], 1'b0 };     
    end

    assign reset = reset_vec[7];

    VexRiscvWithDebug u_vex (
            .clk                        (clk),
            .reset                      (reset),

            .io_iBus_cmd_valid          (iBus_cmd_valid),
            .io_iBus_cmd_ready          (iBus_cmd_ready),
            .io_iBus_cmd_payload_pc     (iBus_cmd_payload_pc),

            .io_iBus_rsp_valid          (iBus_rsp_valid),
            .io_iBus_rsp_payload_error  (iBus_rsp_payload_error),
            .io_iBus_rsp_payload_inst   (iBus_rsp_payload_inst),

            .io_dBus_cmd_valid          (dBus_cmd_valid),
            .io_dBus_cmd_ready          (dBus_cmd_ready),
            .io_dBus_cmd_payload_wr     (dBus_cmd_payload_wr),
            .io_dBus_cmd_payload_address(dBus_cmd_payload_address),
            .io_dBus_cmd_payload_data   (dBus_cmd_payload_data),
            .io_dBus_cmd_payload_size   (dBus_cmd_payload_size),

            .io_dBus_rsp_ready          (dBus_rsp_ready),
            .io_dBus_rsp_error          (dBus_rsp_error),
            .io_dBus_rsp_data           (dBus_rsp_data),

            .io_timerInterrupt          (1'b0),
            .io_externalInterrupt       (1'b0),

`ifdef JTAG_ENABLED
            .io_jtag_tck                (jtag_tck),
            .io_jtag_tms                (jtag_tms),
            .io_jtag_tdi                (jtag_tdi),
            .io_jtag_tdo                (jtag_tdo)
`else
            .io_jtag_tck                (1'b0),
            .io_jtag_tms                (1'b1),
            .io_jtag_tdi                (1'b1),
            .io_jtag_tdo                ()
`endif
        );

    // When changing this value, checkout ./sw/Makefile for a list of 
    // all other files that must be changed as well.
    localparam mem_size_bytes   = 2048;
    localparam mem_addr_bits    = 11;

    reg [7:0] mem0[0:mem_size_bytes/4-1];
    reg [7:0] mem1[0:mem_size_bytes/4-1];
    reg [7:0] mem2[0:mem_size_bytes/4-1];
    reg [7:0] mem3[0:mem_size_bytes/4-1];

    initial begin
        $readmemh("../sw/progmem0.hex", mem0);
        $readmemh("../sw/progmem1.hex", mem1);
        $readmemh("../sw/progmem2.hex", mem2);
        $readmemh("../sw/progmem3.hex", mem3);
    end

    assign iBus_cmd_ready           = 1'b1;
    assign iBus_rsp_payload_error   = 1'b0;

    assign dBus_cmd_ready           = 1'b1;
    assign dBus_rsp_error           = 1'b0;

    wire [31:0] dBus_wdata;
    assign dBus_wdata = dBus_cmd_payload_data;

    wire [3:0] dBus_be;
    assign dBus_be    = (dBus_cmd_payload_size == 2'd0) ? (4'b0001 << dBus_cmd_payload_address[1:0]) : 
                        (dBus_cmd_payload_size == 2'd1) ? (4'b0011 << dBus_cmd_payload_address[1:0]) : 
                                                           4'b1111;

    //============================================================
    // CPU memory instruction read port
    //============================================================
    always @(posedge clk) begin
        iBus_rsp_valid  <= iBus_cmd_valid;
    end

    always @(posedge clk) begin 
        iBus_rsp_payload_inst[ 7: 0]  <= mem0[iBus_cmd_payload_pc[mem_addr_bits-1:2]];
        iBus_rsp_payload_inst[15: 8]  <= mem1[iBus_cmd_payload_pc[mem_addr_bits-1:2]];
        iBus_rsp_payload_inst[23:16]  <= mem2[iBus_cmd_payload_pc[mem_addr_bits-1:2]];
        iBus_rsp_payload_inst[31:24]  <= mem3[iBus_cmd_payload_pc[mem_addr_bits-1:2]];
    end

    //============================================================
    // CPU memory data read/write port
    //============================================================
    reg [31:0] mem_rdata;

    wire [3:0] mem_wr;
    assign mem_wr = {4{dBus_cmd_valid && !dBus_cmd_payload_address[31] && dBus_cmd_payload_wr}} & dBus_be;

    // Quartus 13.0sp1 (the last version that supports Cyclone II) is
    // very picky about how RTL should structured to infer a true dual-ported RAM...
    always @(posedge clk) begin
        if (mem_wr[0]) begin
            mem0[dBus_cmd_payload_address[mem_addr_bits-1:2]]    <= dBus_wdata[ 7: 0];
            mem_rdata[ 7: 0]  <= dBus_wdata[ 7: 0];
        end
        else 
            mem_rdata[ 7: 0]  <= mem0[dBus_cmd_payload_address[mem_addr_bits-1:2]];

        if (mem_wr[1]) begin
            mem1[dBus_cmd_payload_address[mem_addr_bits-1:2]]    <= dBus_wdata[15: 8];
            mem_rdata[15: 8]  <= dBus_wdata[15: 8];
        end
        else 
            mem_rdata[15: 8]  <= mem1[dBus_cmd_payload_address[mem_addr_bits-1:2]];

        if (mem_wr[2]) begin
            mem2[dBus_cmd_payload_address[mem_addr_bits-1:2]]    <= dBus_wdata[23:16];
            mem_rdata[23:16]  <= dBus_wdata[23:16];
        end
        else 
            mem_rdata[23:16]  <= mem2[dBus_cmd_payload_address[mem_addr_bits-1:2]];

        if (mem_wr[3]) begin
            mem3[dBus_cmd_payload_address[mem_addr_bits-1:2]]    <= dBus_wdata[31:24];
            mem_rdata[31:24]  <= dBus_wdata[31:24];
        end
        else 
            mem_rdata[31:24]  <= mem3[dBus_cmd_payload_address[mem_addr_bits-1:2]];
    end

    //============================================================
    // Peripherals
    //============================================================

    reg [31:0] periph_rdata;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            led0            <= 1'b1;
            led1            <= 1'b1;
            led2            <= 1'b1;
            periph_rdata    <= 32'd0;
        end
        else if (dBus_cmd_valid && dBus_cmd_payload_address[31]) begin

            // LED register
            if (dBus_cmd_payload_address[mem_addr_bits-1:2] == 10'h0) begin
                if (dBus_cmd_payload_wr) begin
                    // LEDs are active low...
                    led0        <= !dBus_wdata[0];
                    led1        <= !dBus_wdata[1];
                    led2        <= !dBus_wdata[2];
                end
                else begin
                    periph_rdata        <= 'd0;
                    periph_rdata[0]     <= !led0;
                    periph_rdata[1]     <= !led1;
                    periph_rdata[2]     <= !led2;
                end
            end

            // Status register
            if (dBus_cmd_payload_address[mem_addr_bits-1:2] == 10'h1) begin
                if (!dBus_cmd_payload_wr) begin
                    periph_rdata[0]     <= button_sync[1];

                    // I don't want to compile different 2 SW version for
                    // simulation and HW, so this status bit can be used by 
                    // the SW on which platform it's running.
`ifdef SIMULATION
                    periph_rdata[1]     <= 1'b1;
`else
                    periph_rdata[1]     <= 1'b0;
`endif
                end
            end
        end
    end

    reg [1:0] button_sync;

    always @(posedge clk) begin
        // double FF synchronizer
        button_sync <= { button_sync[0], button };
    end

    //============================================================
    // Merge read paths
    //============================================================

    reg periph_sel;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            dBus_rsp_ready  <= 1'b0;
            periph_sel      <= 1'b0;
        end
        else begin
            // Both memory reads and peripheral reads don't support wait
            // cycles. Data is always returned immediately the next cycle.
            dBus_rsp_ready  <= dBus_cmd_valid && !dBus_cmd_payload_wr;
            periph_sel      <= dBus_cmd_payload_address[31];
        end
    end

    assign dBus_rsp_data = periph_sel ? periph_rdata : mem_rdata;

endmodule

