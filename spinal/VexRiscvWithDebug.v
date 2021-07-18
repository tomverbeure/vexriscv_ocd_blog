// Generator : SpinalHDL v1.5.0    git head : 83a031922866b078c411ec5529e00f1b6e79f8e7
// Component : VexRiscvWithDebug
// Git hash  : 27725770a4c3541155ea7b67b42f03db1df69c49


`define BranchCtrlEnum_defaultEncoding_type [1:0]
`define BranchCtrlEnum_defaultEncoding_INC 2'b00
`define BranchCtrlEnum_defaultEncoding_B 2'b01
`define BranchCtrlEnum_defaultEncoding_JAL 2'b10
`define BranchCtrlEnum_defaultEncoding_JALR 2'b11

`define ShiftCtrlEnum_defaultEncoding_type [1:0]
`define ShiftCtrlEnum_defaultEncoding_DISABLE 2'b00
`define ShiftCtrlEnum_defaultEncoding_SLL 2'b01
`define ShiftCtrlEnum_defaultEncoding_SRL 2'b10
`define ShiftCtrlEnum_defaultEncoding_SRA 2'b11

`define AluBitwiseCtrlEnum_defaultEncoding_type [1:0]
`define AluBitwiseCtrlEnum_defaultEncoding_XOR 2'b00
`define AluBitwiseCtrlEnum_defaultEncoding_OR 2'b01
`define AluBitwiseCtrlEnum_defaultEncoding_AND 2'b10

`define EnvCtrlEnum_defaultEncoding_type [1:0]
`define EnvCtrlEnum_defaultEncoding_NONE 2'b00
`define EnvCtrlEnum_defaultEncoding_XRET 2'b01
`define EnvCtrlEnum_defaultEncoding_EBREAK 2'b10

`define AluCtrlEnum_defaultEncoding_type [1:0]
`define AluCtrlEnum_defaultEncoding_ADD_SUB 2'b00
`define AluCtrlEnum_defaultEncoding_SLT_SLTU 2'b01
`define AluCtrlEnum_defaultEncoding_BITWISE 2'b10

`define Src2CtrlEnum_defaultEncoding_type [1:0]
`define Src2CtrlEnum_defaultEncoding_RS 2'b00
`define Src2CtrlEnum_defaultEncoding_IMI 2'b01
`define Src2CtrlEnum_defaultEncoding_IMS 2'b10
`define Src2CtrlEnum_defaultEncoding_PC 2'b11

`define Src1CtrlEnum_defaultEncoding_type [1:0]
`define Src1CtrlEnum_defaultEncoding_RS 2'b00
`define Src1CtrlEnum_defaultEncoding_IMU 2'b01
`define Src1CtrlEnum_defaultEncoding_PC_INCREMENT 2'b10
`define Src1CtrlEnum_defaultEncoding_URS1 2'b11

`define JtagState_defaultEncoding_type [3:0]
`define JtagState_defaultEncoding_RESET 4'b0000
`define JtagState_defaultEncoding_IDLE 4'b0001
`define JtagState_defaultEncoding_IR_SELECT 4'b0010
`define JtagState_defaultEncoding_IR_CAPTURE 4'b0011
`define JtagState_defaultEncoding_IR_SHIFT 4'b0100
`define JtagState_defaultEncoding_IR_EXIT1 4'b0101
`define JtagState_defaultEncoding_IR_PAUSE 4'b0110
`define JtagState_defaultEncoding_IR_EXIT2 4'b0111
`define JtagState_defaultEncoding_IR_UPDATE 4'b1000
`define JtagState_defaultEncoding_DR_SELECT 4'b1001
`define JtagState_defaultEncoding_DR_CAPTURE 4'b1010
`define JtagState_defaultEncoding_DR_SHIFT 4'b1011
`define JtagState_defaultEncoding_DR_EXIT1 4'b1100
`define JtagState_defaultEncoding_DR_PAUSE 4'b1101
`define JtagState_defaultEncoding_DR_EXIT2 4'b1110
`define JtagState_defaultEncoding_DR_UPDATE 4'b1111


module VexRiscvWithDebug (
  output              io_iBus_cmd_valid,
  input               io_iBus_cmd_ready,
  output     [31:0]   io_iBus_cmd_payload_pc,
  input               io_iBus_rsp_valid,
  input               io_iBus_rsp_payload_error,
  input      [31:0]   io_iBus_rsp_payload_inst,
  output              io_dBus_cmd_valid,
  input               io_dBus_cmd_ready,
  output              io_dBus_cmd_payload_wr,
  output     [31:0]   io_dBus_cmd_payload_address,
  output     [31:0]   io_dBus_cmd_payload_data,
  output     [1:0]    io_dBus_cmd_payload_size,
  input               io_dBus_rsp_ready,
  input               io_dBus_rsp_error,
  input      [31:0]   io_dBus_rsp_data,
  input               io_timerInterrupt,
  input               io_externalInterrupt,
  input               io_jtag_tms,
  input               io_jtag_tdi,
  output              io_jtag_tdo,
  input               io_jtag_tck,
  input               clk,
  input               reset
);
  wire       [7:0]    cpu_debug_bus_cmd_payload_address;
  wire                cpu_iBus_cmd_valid;
  wire       [31:0]   cpu_iBus_cmd_payload_pc;
  wire                cpu_debug_bus_cmd_ready;
  wire       [31:0]   cpu_debug_bus_rsp_data;
  wire                cpu_debug_resetOut;
  wire                cpu_dBus_cmd_valid;
  wire                cpu_dBus_cmd_payload_wr;
  wire       [31:0]   cpu_dBus_cmd_payload_address;
  wire       [31:0]   cpu_dBus_cmd_payload_data;
  wire       [1:0]    cpu_dBus_cmd_payload_size;
  wire                jtagBridge_1_io_jtag_tdo;
  wire                jtagBridge_1_io_remote_cmd_valid;
  wire                jtagBridge_1_io_remote_cmd_payload_last;
  wire       [0:0]    jtagBridge_1_io_remote_cmd_payload_fragment;
  wire                jtagBridge_1_io_remote_rsp_ready;
  wire                systemDebugger_1_io_remote_cmd_ready;
  wire                systemDebugger_1_io_remote_rsp_valid;
  wire                systemDebugger_1_io_remote_rsp_payload_error;
  wire       [31:0]   systemDebugger_1_io_remote_rsp_payload_data;
  wire                systemDebugger_1_io_mem_cmd_valid;
  wire       [31:0]   systemDebugger_1_io_mem_cmd_payload_address;
  wire       [31:0]   systemDebugger_1_io_mem_cmd_payload_data;
  wire                systemDebugger_1_io_mem_cmd_payload_wr;
  wire       [1:0]    systemDebugger_1_io_mem_cmd_payload_size;
  reg                 _zz_io_mem_rsp_valid;

  VexRiscv cpu (
    .iBus_cmd_valid                   (cpu_iBus_cmd_valid                        ), //o
    .iBus_cmd_ready                   (io_iBus_cmd_ready                         ), //i
    .iBus_cmd_payload_pc              (cpu_iBus_cmd_payload_pc                   ), //o
    .iBus_rsp_valid                   (io_iBus_rsp_valid                         ), //i
    .iBus_rsp_payload_error           (io_iBus_rsp_payload_error                 ), //i
    .iBus_rsp_payload_inst            (io_iBus_rsp_payload_inst                  ), //i
    .timerInterrupt                   (io_timerInterrupt                         ), //i
    .externalInterrupt                (io_externalInterrupt                      ), //i
    .softwareInterrupt                (1'b0                                      ), //i
    .debug_bus_cmd_valid              (systemDebugger_1_io_mem_cmd_valid         ), //i
    .debug_bus_cmd_ready              (cpu_debug_bus_cmd_ready                   ), //o
    .debug_bus_cmd_payload_wr         (systemDebugger_1_io_mem_cmd_payload_wr    ), //i
    .debug_bus_cmd_payload_address    (cpu_debug_bus_cmd_payload_address         ), //i
    .debug_bus_cmd_payload_data       (systemDebugger_1_io_mem_cmd_payload_data  ), //i
    .debug_bus_rsp_data               (cpu_debug_bus_rsp_data                    ), //o
    .debug_resetOut                   (cpu_debug_resetOut                        ), //o
    .dBus_cmd_valid                   (cpu_dBus_cmd_valid                        ), //o
    .dBus_cmd_ready                   (io_dBus_cmd_ready                         ), //i
    .dBus_cmd_payload_wr              (cpu_dBus_cmd_payload_wr                   ), //o
    .dBus_cmd_payload_address         (cpu_dBus_cmd_payload_address              ), //o
    .dBus_cmd_payload_data            (cpu_dBus_cmd_payload_data                 ), //o
    .dBus_cmd_payload_size            (cpu_dBus_cmd_payload_size                 ), //o
    .dBus_rsp_ready                   (io_dBus_rsp_ready                         ), //i
    .dBus_rsp_error                   (io_dBus_rsp_error                         ), //i
    .dBus_rsp_data                    (io_dBus_rsp_data                          ), //i
    .clk                              (clk                                       ), //i
    .reset                            (reset                                     )  //i
  );
  JtagBridge jtagBridge_1 (
    .io_jtag_tms                       (io_jtag_tms                                   ), //i
    .io_jtag_tdi                       (io_jtag_tdi                                   ), //i
    .io_jtag_tdo                       (jtagBridge_1_io_jtag_tdo                      ), //o
    .io_jtag_tck                       (io_jtag_tck                                   ), //i
    .io_remote_cmd_valid               (jtagBridge_1_io_remote_cmd_valid              ), //o
    .io_remote_cmd_ready               (systemDebugger_1_io_remote_cmd_ready          ), //i
    .io_remote_cmd_payload_last        (jtagBridge_1_io_remote_cmd_payload_last       ), //o
    .io_remote_cmd_payload_fragment    (jtagBridge_1_io_remote_cmd_payload_fragment   ), //o
    .io_remote_rsp_valid               (systemDebugger_1_io_remote_rsp_valid          ), //i
    .io_remote_rsp_ready               (jtagBridge_1_io_remote_rsp_ready              ), //o
    .io_remote_rsp_payload_error       (systemDebugger_1_io_remote_rsp_payload_error  ), //i
    .io_remote_rsp_payload_data        (systemDebugger_1_io_remote_rsp_payload_data   ), //i
    .clk                               (clk                                           ), //i
    .reset                             (reset                                         )  //i
  );
  SystemDebugger systemDebugger_1 (
    .io_remote_cmd_valid               (jtagBridge_1_io_remote_cmd_valid              ), //i
    .io_remote_cmd_ready               (systemDebugger_1_io_remote_cmd_ready          ), //o
    .io_remote_cmd_payload_last        (jtagBridge_1_io_remote_cmd_payload_last       ), //i
    .io_remote_cmd_payload_fragment    (jtagBridge_1_io_remote_cmd_payload_fragment   ), //i
    .io_remote_rsp_valid               (systemDebugger_1_io_remote_rsp_valid          ), //o
    .io_remote_rsp_ready               (jtagBridge_1_io_remote_rsp_ready              ), //i
    .io_remote_rsp_payload_error       (systemDebugger_1_io_remote_rsp_payload_error  ), //o
    .io_remote_rsp_payload_data        (systemDebugger_1_io_remote_rsp_payload_data   ), //o
    .io_mem_cmd_valid                  (systemDebugger_1_io_mem_cmd_valid             ), //o
    .io_mem_cmd_ready                  (cpu_debug_bus_cmd_ready                       ), //i
    .io_mem_cmd_payload_address        (systemDebugger_1_io_mem_cmd_payload_address   ), //o
    .io_mem_cmd_payload_data           (systemDebugger_1_io_mem_cmd_payload_data      ), //o
    .io_mem_cmd_payload_wr             (systemDebugger_1_io_mem_cmd_payload_wr        ), //o
    .io_mem_cmd_payload_size           (systemDebugger_1_io_mem_cmd_payload_size      ), //o
    .io_mem_rsp_valid                  (_zz_io_mem_rsp_valid                          ), //i
    .io_mem_rsp_payload                (cpu_debug_bus_rsp_data                        ), //i
    .clk                               (clk                                           ), //i
    .reset                             (reset                                         )  //i
  );
  assign io_iBus_cmd_valid = cpu_iBus_cmd_valid;
  assign io_iBus_cmd_payload_pc = cpu_iBus_cmd_payload_pc;
  assign io_dBus_cmd_valid = cpu_dBus_cmd_valid;
  assign io_dBus_cmd_payload_wr = cpu_dBus_cmd_payload_wr;
  assign io_dBus_cmd_payload_address = cpu_dBus_cmd_payload_address;
  assign io_dBus_cmd_payload_data = cpu_dBus_cmd_payload_data;
  assign io_dBus_cmd_payload_size = cpu_dBus_cmd_payload_size;
  assign cpu_debug_bus_cmd_payload_address = systemDebugger_1_io_mem_cmd_payload_address[7:0];
  assign io_jtag_tdo = jtagBridge_1_io_jtag_tdo;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      _zz_io_mem_rsp_valid <= 1'b0;
    end else begin
      _zz_io_mem_rsp_valid <= (systemDebugger_1_io_mem_cmd_valid && cpu_debug_bus_cmd_ready);
    end
  end


endmodule

module SystemDebugger (
  input               io_remote_cmd_valid,
  output              io_remote_cmd_ready,
  input               io_remote_cmd_payload_last,
  input      [0:0]    io_remote_cmd_payload_fragment,
  output              io_remote_rsp_valid,
  input               io_remote_rsp_ready,
  output              io_remote_rsp_payload_error,
  output     [31:0]   io_remote_rsp_payload_data,
  output              io_mem_cmd_valid,
  input               io_mem_cmd_ready,
  output     [31:0]   io_mem_cmd_payload_address,
  output     [31:0]   io_mem_cmd_payload_data,
  output              io_mem_cmd_payload_wr,
  output     [1:0]    io_mem_cmd_payload_size,
  input               io_mem_rsp_valid,
  input      [31:0]   io_mem_rsp_payload,
  input               clk,
  input               reset
);
  reg        [66:0]   dispatcher_dataShifter;
  reg                 dispatcher_dataLoaded;
  reg        [7:0]    dispatcher_headerShifter;
  wire       [7:0]    dispatcher_header;
  reg                 dispatcher_headerLoaded;
  reg        [2:0]    dispatcher_counter;
  wire                when_Fragment_l346;
  wire                when_Fragment_l349;
  wire       [66:0]   _zz_io_mem_cmd_payload_address;
  wire                when_Fragment_l372;

  assign dispatcher_header = dispatcher_headerShifter[7 : 0];
  assign when_Fragment_l346 = (dispatcher_headerLoaded == 1'b0);
  assign when_Fragment_l349 = (dispatcher_counter == 3'b111);
  assign io_remote_cmd_ready = (! dispatcher_dataLoaded);
  assign _zz_io_mem_cmd_payload_address = dispatcher_dataShifter[66 : 0];
  assign io_mem_cmd_payload_address = _zz_io_mem_cmd_payload_address[31 : 0];
  assign io_mem_cmd_payload_data = _zz_io_mem_cmd_payload_address[63 : 32];
  assign io_mem_cmd_payload_wr = _zz_io_mem_cmd_payload_address[64];
  assign io_mem_cmd_payload_size = _zz_io_mem_cmd_payload_address[66 : 65];
  assign io_mem_cmd_valid = (dispatcher_dataLoaded && (dispatcher_header == 8'h0));
  assign when_Fragment_l372 = ((dispatcher_headerLoaded && dispatcher_dataLoaded) && (! (io_mem_cmd_valid && (! io_mem_cmd_ready))));
  assign io_remote_rsp_valid = io_mem_rsp_valid;
  assign io_remote_rsp_payload_error = 1'b0;
  assign io_remote_rsp_payload_data = io_mem_rsp_payload;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      dispatcher_dataLoaded <= 1'b0;
      dispatcher_headerLoaded <= 1'b0;
      dispatcher_counter <= 3'b000;
    end else begin
      if(io_remote_cmd_valid) begin
        if(when_Fragment_l346) begin
          dispatcher_counter <= (dispatcher_counter + 3'b001);
          if(when_Fragment_l349) begin
            dispatcher_headerLoaded <= 1'b1;
          end
        end
        if(io_remote_cmd_payload_last) begin
          dispatcher_headerLoaded <= 1'b1;
          dispatcher_dataLoaded <= 1'b1;
          dispatcher_counter <= 3'b000;
        end
      end
      if(when_Fragment_l372) begin
        dispatcher_headerLoaded <= 1'b0;
        dispatcher_dataLoaded <= 1'b0;
      end
    end
  end

  always @(posedge clk) begin
    if(io_remote_cmd_valid) begin
      if(when_Fragment_l346) begin
        dispatcher_headerShifter <= ({io_remote_cmd_payload_fragment,dispatcher_headerShifter} >>> 1);
      end else begin
        dispatcher_dataShifter <= ({io_remote_cmd_payload_fragment,dispatcher_dataShifter} >>> 1);
      end
    end
  end


endmodule

module JtagBridge (
  input               io_jtag_tms,
  input               io_jtag_tdi,
  output              io_jtag_tdo,
  input               io_jtag_tck,
  output              io_remote_cmd_valid,
  input               io_remote_cmd_ready,
  output              io_remote_cmd_payload_last,
  output     [0:0]    io_remote_cmd_payload_fragment,
  input               io_remote_rsp_valid,
  output              io_remote_rsp_ready,
  input               io_remote_rsp_payload_error,
  input      [31:0]   io_remote_rsp_payload_data,
  input               clk,
  input               reset
);
  wire                flowCCByToggle_1_io_input_payload_last;
  wire                flowCCByToggle_1_io_output_valid;
  wire                flowCCByToggle_1_io_output_payload_last;
  wire       [0:0]    flowCCByToggle_1_io_output_payload_fragment;
  wire       [1:0]    _zz_JtagBridge_jtag_tap_instructionShift;
  wire                system_cmd_valid;
  wire                system_cmd_payload_last;
  wire       [0:0]    system_cmd_payload_fragment;
  (* async_reg = "true" *) reg                 system_rsp_valid;
  (* async_reg = "true" *) reg                 system_rsp_payload_error;
  (* async_reg = "true" *) reg        [31:0]   system_rsp_payload_data;
  wire                when_SystemDebugger_l71;
  wire       `JtagState_defaultEncoding_type jtag_tap_fsm_stateNext;
  reg        `JtagState_defaultEncoding_type jtag_tap_fsm_state = `JtagState_defaultEncoding_RESET;
  reg        `JtagState_defaultEncoding_type _zz_jtag_tap_fsm_stateNext;
  reg        [3:0]    jtag_tap_instruction;
  reg        [3:0]    jtag_tap_instructionShift;
  reg                 jtag_tap_bypass;
  reg                 jtag_tap_tdoUnbufferd;
  reg                 jtag_tap_tdoDr;
  wire                jtag_tap_tdoIr;
  reg                 jtag_tap_tdoUnbufferd_regNext;
  wire                _zz_JtagBridge_1;
  reg        [31:0]   _zz_jtag_tap_tdoDr;
  wire                when_JtagTap_l115;
  wire                _zz_io_input_valid;
  wire                _zz_io_input_valid_1;
  wire       [0:0]    _zz_io_input_payload_fragment;
  reg                 _zz_io_input_valid_2;
  reg                 _zz_io_input_payload_fragment_1;
  wire                _zz_JtagBridge_2;
  reg        [33:0]   _zz_jtag_tap_tdoDr_1;
  `ifndef SYNTHESIS
  reg [79:0] jtag_tap_fsm_stateNext_string;
  reg [79:0] jtag_tap_fsm_state_string;
  reg [79:0] _zz_jtag_tap_fsm_stateNext_string;
  `endif


  assign _zz_JtagBridge_jtag_tap_instructionShift = 2'b01;
  FlowCCByToggle flowCCByToggle_1 (
    .io_input_valid                (_zz_io_input_valid_2                         ), //i
    .io_input_payload_last         (flowCCByToggle_1_io_input_payload_last       ), //i
    .io_input_payload_fragment     (_zz_io_input_payload_fragment                ), //i
    .io_output_valid               (flowCCByToggle_1_io_output_valid             ), //o
    .io_output_payload_last        (flowCCByToggle_1_io_output_payload_last      ), //o
    .io_output_payload_fragment    (flowCCByToggle_1_io_output_payload_fragment  ), //o
    .io_jtag_tck                   (io_jtag_tck                                  ), //i
    .clk                           (clk                                          ), //i
    .reset                         (reset                                        )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(jtag_tap_fsm_stateNext)
      `JtagState_defaultEncoding_RESET : jtag_tap_fsm_stateNext_string = "RESET     ";
      `JtagState_defaultEncoding_IDLE : jtag_tap_fsm_stateNext_string = "IDLE      ";
      `JtagState_defaultEncoding_IR_SELECT : jtag_tap_fsm_stateNext_string = "IR_SELECT ";
      `JtagState_defaultEncoding_IR_CAPTURE : jtag_tap_fsm_stateNext_string = "IR_CAPTURE";
      `JtagState_defaultEncoding_IR_SHIFT : jtag_tap_fsm_stateNext_string = "IR_SHIFT  ";
      `JtagState_defaultEncoding_IR_EXIT1 : jtag_tap_fsm_stateNext_string = "IR_EXIT1  ";
      `JtagState_defaultEncoding_IR_PAUSE : jtag_tap_fsm_stateNext_string = "IR_PAUSE  ";
      `JtagState_defaultEncoding_IR_EXIT2 : jtag_tap_fsm_stateNext_string = "IR_EXIT2  ";
      `JtagState_defaultEncoding_IR_UPDATE : jtag_tap_fsm_stateNext_string = "IR_UPDATE ";
      `JtagState_defaultEncoding_DR_SELECT : jtag_tap_fsm_stateNext_string = "DR_SELECT ";
      `JtagState_defaultEncoding_DR_CAPTURE : jtag_tap_fsm_stateNext_string = "DR_CAPTURE";
      `JtagState_defaultEncoding_DR_SHIFT : jtag_tap_fsm_stateNext_string = "DR_SHIFT  ";
      `JtagState_defaultEncoding_DR_EXIT1 : jtag_tap_fsm_stateNext_string = "DR_EXIT1  ";
      `JtagState_defaultEncoding_DR_PAUSE : jtag_tap_fsm_stateNext_string = "DR_PAUSE  ";
      `JtagState_defaultEncoding_DR_EXIT2 : jtag_tap_fsm_stateNext_string = "DR_EXIT2  ";
      `JtagState_defaultEncoding_DR_UPDATE : jtag_tap_fsm_stateNext_string = "DR_UPDATE ";
      default : jtag_tap_fsm_stateNext_string = "??????????";
    endcase
  end
  always @(*) begin
    case(jtag_tap_fsm_state)
      `JtagState_defaultEncoding_RESET : jtag_tap_fsm_state_string = "RESET     ";
      `JtagState_defaultEncoding_IDLE : jtag_tap_fsm_state_string = "IDLE      ";
      `JtagState_defaultEncoding_IR_SELECT : jtag_tap_fsm_state_string = "IR_SELECT ";
      `JtagState_defaultEncoding_IR_CAPTURE : jtag_tap_fsm_state_string = "IR_CAPTURE";
      `JtagState_defaultEncoding_IR_SHIFT : jtag_tap_fsm_state_string = "IR_SHIFT  ";
      `JtagState_defaultEncoding_IR_EXIT1 : jtag_tap_fsm_state_string = "IR_EXIT1  ";
      `JtagState_defaultEncoding_IR_PAUSE : jtag_tap_fsm_state_string = "IR_PAUSE  ";
      `JtagState_defaultEncoding_IR_EXIT2 : jtag_tap_fsm_state_string = "IR_EXIT2  ";
      `JtagState_defaultEncoding_IR_UPDATE : jtag_tap_fsm_state_string = "IR_UPDATE ";
      `JtagState_defaultEncoding_DR_SELECT : jtag_tap_fsm_state_string = "DR_SELECT ";
      `JtagState_defaultEncoding_DR_CAPTURE : jtag_tap_fsm_state_string = "DR_CAPTURE";
      `JtagState_defaultEncoding_DR_SHIFT : jtag_tap_fsm_state_string = "DR_SHIFT  ";
      `JtagState_defaultEncoding_DR_EXIT1 : jtag_tap_fsm_state_string = "DR_EXIT1  ";
      `JtagState_defaultEncoding_DR_PAUSE : jtag_tap_fsm_state_string = "DR_PAUSE  ";
      `JtagState_defaultEncoding_DR_EXIT2 : jtag_tap_fsm_state_string = "DR_EXIT2  ";
      `JtagState_defaultEncoding_DR_UPDATE : jtag_tap_fsm_state_string = "DR_UPDATE ";
      default : jtag_tap_fsm_state_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_jtag_tap_fsm_stateNext)
      `JtagState_defaultEncoding_RESET : _zz_jtag_tap_fsm_stateNext_string = "RESET     ";
      `JtagState_defaultEncoding_IDLE : _zz_jtag_tap_fsm_stateNext_string = "IDLE      ";
      `JtagState_defaultEncoding_IR_SELECT : _zz_jtag_tap_fsm_stateNext_string = "IR_SELECT ";
      `JtagState_defaultEncoding_IR_CAPTURE : _zz_jtag_tap_fsm_stateNext_string = "IR_CAPTURE";
      `JtagState_defaultEncoding_IR_SHIFT : _zz_jtag_tap_fsm_stateNext_string = "IR_SHIFT  ";
      `JtagState_defaultEncoding_IR_EXIT1 : _zz_jtag_tap_fsm_stateNext_string = "IR_EXIT1  ";
      `JtagState_defaultEncoding_IR_PAUSE : _zz_jtag_tap_fsm_stateNext_string = "IR_PAUSE  ";
      `JtagState_defaultEncoding_IR_EXIT2 : _zz_jtag_tap_fsm_stateNext_string = "IR_EXIT2  ";
      `JtagState_defaultEncoding_IR_UPDATE : _zz_jtag_tap_fsm_stateNext_string = "IR_UPDATE ";
      `JtagState_defaultEncoding_DR_SELECT : _zz_jtag_tap_fsm_stateNext_string = "DR_SELECT ";
      `JtagState_defaultEncoding_DR_CAPTURE : _zz_jtag_tap_fsm_stateNext_string = "DR_CAPTURE";
      `JtagState_defaultEncoding_DR_SHIFT : _zz_jtag_tap_fsm_stateNext_string = "DR_SHIFT  ";
      `JtagState_defaultEncoding_DR_EXIT1 : _zz_jtag_tap_fsm_stateNext_string = "DR_EXIT1  ";
      `JtagState_defaultEncoding_DR_PAUSE : _zz_jtag_tap_fsm_stateNext_string = "DR_PAUSE  ";
      `JtagState_defaultEncoding_DR_EXIT2 : _zz_jtag_tap_fsm_stateNext_string = "DR_EXIT2  ";
      `JtagState_defaultEncoding_DR_UPDATE : _zz_jtag_tap_fsm_stateNext_string = "DR_UPDATE ";
      default : _zz_jtag_tap_fsm_stateNext_string = "??????????";
    endcase
  end
  `endif

  assign io_remote_cmd_valid = system_cmd_valid;
  assign io_remote_cmd_payload_last = system_cmd_payload_last;
  assign io_remote_cmd_payload_fragment = system_cmd_payload_fragment;
  assign when_SystemDebugger_l71 = (io_remote_rsp_valid && io_remote_rsp_ready);
  assign io_remote_rsp_ready = 1'b1;
  always @(*) begin
    case(jtag_tap_fsm_state)
      `JtagState_defaultEncoding_IDLE : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_defaultEncoding_DR_SELECT : `JtagState_defaultEncoding_IDLE);
      end
      `JtagState_defaultEncoding_IR_SELECT : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_defaultEncoding_RESET : `JtagState_defaultEncoding_IR_CAPTURE);
      end
      `JtagState_defaultEncoding_IR_CAPTURE : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_defaultEncoding_IR_EXIT1 : `JtagState_defaultEncoding_IR_SHIFT);
      end
      `JtagState_defaultEncoding_IR_SHIFT : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_defaultEncoding_IR_EXIT1 : `JtagState_defaultEncoding_IR_SHIFT);
      end
      `JtagState_defaultEncoding_IR_EXIT1 : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_defaultEncoding_IR_UPDATE : `JtagState_defaultEncoding_IR_PAUSE);
      end
      `JtagState_defaultEncoding_IR_PAUSE : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_defaultEncoding_IR_EXIT2 : `JtagState_defaultEncoding_IR_PAUSE);
      end
      `JtagState_defaultEncoding_IR_EXIT2 : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_defaultEncoding_IR_UPDATE : `JtagState_defaultEncoding_IR_SHIFT);
      end
      `JtagState_defaultEncoding_IR_UPDATE : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_defaultEncoding_DR_SELECT : `JtagState_defaultEncoding_IDLE);
      end
      `JtagState_defaultEncoding_DR_SELECT : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_defaultEncoding_IR_SELECT : `JtagState_defaultEncoding_DR_CAPTURE);
      end
      `JtagState_defaultEncoding_DR_CAPTURE : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_defaultEncoding_DR_EXIT1 : `JtagState_defaultEncoding_DR_SHIFT);
      end
      `JtagState_defaultEncoding_DR_SHIFT : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_defaultEncoding_DR_EXIT1 : `JtagState_defaultEncoding_DR_SHIFT);
      end
      `JtagState_defaultEncoding_DR_EXIT1 : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_defaultEncoding_DR_UPDATE : `JtagState_defaultEncoding_DR_PAUSE);
      end
      `JtagState_defaultEncoding_DR_PAUSE : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_defaultEncoding_DR_EXIT2 : `JtagState_defaultEncoding_DR_PAUSE);
      end
      `JtagState_defaultEncoding_DR_EXIT2 : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_defaultEncoding_DR_UPDATE : `JtagState_defaultEncoding_DR_SHIFT);
      end
      `JtagState_defaultEncoding_DR_UPDATE : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_defaultEncoding_DR_SELECT : `JtagState_defaultEncoding_IDLE);
      end
      default : begin
        _zz_jtag_tap_fsm_stateNext = (io_jtag_tms ? `JtagState_defaultEncoding_RESET : `JtagState_defaultEncoding_IDLE);
      end
    endcase
  end

  assign jtag_tap_fsm_stateNext = _zz_jtag_tap_fsm_stateNext;
  always @(*) begin
    jtag_tap_tdoUnbufferd = jtag_tap_bypass;
    case(jtag_tap_fsm_state)
      `JtagState_defaultEncoding_IR_SHIFT : begin
        jtag_tap_tdoUnbufferd = jtag_tap_tdoIr;
      end
      `JtagState_defaultEncoding_DR_SHIFT : begin
        jtag_tap_tdoUnbufferd = jtag_tap_tdoDr;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    jtag_tap_tdoDr = 1'b0;
    if(_zz_JtagBridge_1) begin
      jtag_tap_tdoDr = _zz_jtag_tap_tdoDr[0];
    end
    if(_zz_io_input_valid) begin
      jtag_tap_tdoDr = 1'b0;
    end
    if(_zz_JtagBridge_2) begin
      jtag_tap_tdoDr = _zz_jtag_tap_tdoDr_1[0];
    end
  end

  assign jtag_tap_tdoIr = jtag_tap_instructionShift[0];
  assign io_jtag_tdo = jtag_tap_tdoUnbufferd_regNext;
  assign _zz_JtagBridge_1 = (jtag_tap_instruction == 4'b0001);
  assign when_JtagTap_l115 = (jtag_tap_fsm_state == `JtagState_defaultEncoding_RESET);
  assign _zz_io_input_payload_fragment[0] = _zz_io_input_payload_fragment_1;
  assign flowCCByToggle_1_io_input_payload_last = (! (_zz_io_input_valid && _zz_io_input_valid_1));
  assign system_cmd_valid = flowCCByToggle_1_io_output_valid;
  assign system_cmd_payload_last = flowCCByToggle_1_io_output_payload_last;
  assign system_cmd_payload_fragment = flowCCByToggle_1_io_output_payload_fragment;
  assign _zz_io_input_valid = (jtag_tap_instruction == 4'b0010);
  assign _zz_io_input_valid_1 = (jtag_tap_fsm_state == `JtagState_defaultEncoding_DR_SHIFT);
  assign _zz_JtagBridge_2 = (jtag_tap_instruction == 4'b0011);
  always @(posedge clk) begin
    if(io_remote_cmd_valid) begin
      system_rsp_valid <= 1'b0;
    end
    if(when_SystemDebugger_l71) begin
      system_rsp_valid <= 1'b1;
      system_rsp_payload_error <= io_remote_rsp_payload_error;
      system_rsp_payload_data <= io_remote_rsp_payload_data;
    end
  end

  always @(posedge io_jtag_tck) begin
    jtag_tap_fsm_state <= jtag_tap_fsm_stateNext;
    jtag_tap_bypass <= io_jtag_tdi;
    case(jtag_tap_fsm_state)
      `JtagState_defaultEncoding_IR_CAPTURE : begin
        jtag_tap_instructionShift <= {2'd0, _zz_JtagBridge_jtag_tap_instructionShift};
      end
      `JtagState_defaultEncoding_IR_SHIFT : begin
        jtag_tap_instructionShift <= ({io_jtag_tdi,jtag_tap_instructionShift} >>> 1);
      end
      `JtagState_defaultEncoding_IR_UPDATE : begin
        jtag_tap_instruction <= jtag_tap_instructionShift;
      end
      `JtagState_defaultEncoding_DR_SHIFT : begin
        jtag_tap_instructionShift <= ({io_jtag_tdi,jtag_tap_instructionShift} >>> 1);
      end
      default : begin
      end
    endcase
    if(_zz_JtagBridge_1) begin
      if((jtag_tap_fsm_state == `JtagState_defaultEncoding_DR_SHIFT)) begin
        _zz_jtag_tap_tdoDr <= ({io_jtag_tdi,_zz_jtag_tap_tdoDr} >>> 1);
      end
    end
    if((jtag_tap_fsm_state == `JtagState_defaultEncoding_DR_CAPTURE)) begin
      _zz_jtag_tap_tdoDr <= 32'h10001fff;
    end
    if(when_JtagTap_l115) begin
      jtag_tap_instruction <= 4'b0001;
    end
    _zz_io_input_valid_2 <= (_zz_io_input_valid && _zz_io_input_valid_1);
    _zz_io_input_payload_fragment_1 <= io_jtag_tdi;
    if(_zz_JtagBridge_2) begin
      if((jtag_tap_fsm_state == `JtagState_defaultEncoding_DR_CAPTURE)) begin
        _zz_jtag_tap_tdoDr_1 <= {{system_rsp_payload_data,system_rsp_payload_error},system_rsp_valid};
      end
      if((jtag_tap_fsm_state == `JtagState_defaultEncoding_DR_SHIFT)) begin
        _zz_jtag_tap_tdoDr_1 <= ({io_jtag_tdi,_zz_jtag_tap_tdoDr_1} >>> 1);
      end
    end
  end

  always @(negedge io_jtag_tck) begin
    jtag_tap_tdoUnbufferd_regNext <= jtag_tap_tdoUnbufferd;
  end


endmodule

module VexRiscv (
  output              iBus_cmd_valid,
  input               iBus_cmd_ready,
  output     [31:0]   iBus_cmd_payload_pc,
  input               iBus_rsp_valid,
  input               iBus_rsp_payload_error,
  input      [31:0]   iBus_rsp_payload_inst,
  input               timerInterrupt,
  input               externalInterrupt,
  input               softwareInterrupt,
  input               debug_bus_cmd_valid,
  output reg          debug_bus_cmd_ready,
  input               debug_bus_cmd_payload_wr,
  input      [7:0]    debug_bus_cmd_payload_address,
  input      [31:0]   debug_bus_cmd_payload_data,
  output reg [31:0]   debug_bus_rsp_data,
  output              debug_resetOut,
  output              dBus_cmd_valid,
  input               dBus_cmd_ready,
  output              dBus_cmd_payload_wr,
  output     [31:0]   dBus_cmd_payload_address,
  output     [31:0]   dBus_cmd_payload_data,
  output     [1:0]    dBus_cmd_payload_size,
  input               dBus_rsp_ready,
  input               dBus_rsp_error,
  input      [31:0]   dBus_rsp_data,
  input               clk,
  input               reset
);
  wire                IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_ready;
  reg        [31:0]   _zz_VexRiscv_RegFilePlugin_regFile_port0;
  reg        [31:0]   _zz_VexRiscv_RegFilePlugin_regFile_port1;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_c_io_push_ready;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_error;
  wire       [31:0]   IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_inst;
  wire       [0:0]    IBusSimplePlugin_rspJoin_rspBuffer_c_io_occupancy;
  wire       [31:0]   _zz_VexRiscv_decode_FORMAL_PC_NEXT;
  wire       [2:0]    _zz_VexRiscv_decode_FORMAL_PC_NEXT_1;
  wire       [2:0]    _zz_VexRiscv__zz_IBusSimplePlugin_jump_pcLoad_payload_1;
  reg        [31:0]   _zz_VexRiscv_IBusSimplePlugin_jump_pcLoad_payload;
  wire       [1:0]    _zz_VexRiscv_IBusSimplePlugin_jump_pcLoad_payload_1;
  wire       [31:0]   _zz_VexRiscv_IBusSimplePlugin_fetchPc_pc;
  wire       [2:0]    _zz_VexRiscv_IBusSimplePlugin_fetchPc_pc_1;
  wire       [31:0]   _zz_VexRiscv_IBusSimplePlugin_decodePc_pcPlus;
  wire       [2:0]    _zz_VexRiscv_IBusSimplePlugin_decodePc_pcPlus_1;
  wire       [31:0]   _zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed;
  wire                _zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed_1;
  wire                _zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed_2;
  wire       [6:0]    _zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed_3;
  wire       [4:0]    _zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed_4;
  wire                _zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed_5;
  wire       [4:0]    _zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed_6;
  wire       [11:0]   _zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed_7;
  wire       [11:0]   _zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed_8;
  wire       [11:0]   _zz_VexRiscv__zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch;
  wire       [31:0]   _zz_VexRiscv_IBusSimplePlugin_decodePrediction_cmd_hadBranch;
  wire       [19:0]   _zz_VexRiscv__zz_IBusSimplePlugin_predictionJumpInterface_payload;
  wire       [11:0]   _zz_VexRiscv__zz_IBusSimplePlugin_predictionJumpInterface_payload_2;
  wire       [0:0]    _zz_VexRiscv_IBusSimplePlugin_predictionJumpInterface_payload;
  wire       [7:0]    _zz_VexRiscv_IBusSimplePlugin_predictionJumpInterface_payload_1;
  wire                _zz_VexRiscv_IBusSimplePlugin_predictionJumpInterface_payload_2;
  wire       [0:0]    _zz_VexRiscv_IBusSimplePlugin_predictionJumpInterface_payload_3;
  wire       [0:0]    _zz_VexRiscv_IBusSimplePlugin_predictionJumpInterface_payload_4;
  wire       [2:0]    _zz_VexRiscv_IBusSimplePlugin_pending_next;
  wire       [2:0]    _zz_VexRiscv_IBusSimplePlugin_pending_next_1;
  wire       [0:0]    _zz_VexRiscv_IBusSimplePlugin_pending_next_2;
  wire       [2:0]    _zz_VexRiscv_IBusSimplePlugin_pending_next_3;
  wire       [0:0]    _zz_VexRiscv_IBusSimplePlugin_pending_next_4;
  wire       [2:0]    _zz_VexRiscv_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter;
  wire       [0:0]    _zz_VexRiscv_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_1;
  wire       [2:0]    _zz_VexRiscv_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_2;
  wire       [0:0]    _zz_VexRiscv_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_3;
  wire       [2:0]    _zz_VexRiscv_DBusSimplePlugin_memoryExceptionPort_payload_code;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_1;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_2;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_3;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_4;
  wire       [1:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_5;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_6;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_7;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_8;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_9;
  wire       [1:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_10;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_11;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_12;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_13;
  wire       [0:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_14;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_15;
  wire       [20:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_16;
  wire       [0:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_17;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_18;
  wire       [0:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_19;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_20;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_21;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_22;
  wire       [0:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_23;
  wire       [17:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_24;
  wire       [0:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_25;
  wire       [0:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_26;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_27;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_28;
  wire       [0:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_29;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_30;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_31;
  wire       [14:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_32;
  wire       [0:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_33;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_34;
  wire       [0:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_35;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_36;
  wire       [1:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_37;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_38;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_39;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_40;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_41;
  wire       [1:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_42;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_43;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_44;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_45;
  wire       [0:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_46;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_47;
  wire       [10:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_48;
  wire       [0:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_49;
  wire       [0:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_50;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_51;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_52;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_53;
  wire       [0:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_54;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_55;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_56;
  wire       [2:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_57;
  wire       [0:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_58;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_59;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_60;
  wire       [0:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_61;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_62;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_63;
  wire       [0:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_64;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_65;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_66;
  wire       [7:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_67;
  wire       [0:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_68;
  wire       [0:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_69;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_70;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_71;
  wire       [1:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_72;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_73;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_74;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_75;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_76;
  wire       [1:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_77;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_78;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_79;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_80;
  wire       [0:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_81;
  wire       [3:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_82;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_83;
  wire       [0:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_84;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_85;
  wire       [1:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_86;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_87;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_88;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_89;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_90;
  wire       [3:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_91;
  wire       [3:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_92;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_93;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_94;
  wire       [0:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_95;
  wire       [2:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_96;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_97;
  wire       [31:0]   _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_98;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_99;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_100;
  wire       [2:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_101;
  wire       [1:0]    _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_102;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_103;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_104;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_105;
  wire                _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_106;
  wire                _zz_VexRiscv_RegFilePlugin_regFile_port;
  wire                _zz_VexRiscv_decode_RegFilePlugin_rs1Data;
  wire                _zz_VexRiscv_RegFilePlugin_regFile_port_1;
  wire                _zz_VexRiscv_decode_RegFilePlugin_rs2Data;
  wire       [0:0]    _zz_VexRiscv__zz_execute_REGFILE_WRITE_DATA;
  wire       [2:0]    _zz_VexRiscv__zz_decode_SRC1_1;
  wire       [4:0]    _zz_VexRiscv__zz_decode_SRC1_1_1;
  wire       [11:0]   _zz_VexRiscv__zz_decode_SRC2_4;
  wire       [31:0]   _zz_VexRiscv_execute_SrcPlugin_addSub;
  wire       [31:0]   _zz_VexRiscv_execute_SrcPlugin_addSub_1;
  wire       [31:0]   _zz_VexRiscv_execute_SrcPlugin_addSub_2;
  wire       [31:0]   _zz_VexRiscv_execute_SrcPlugin_addSub_3;
  wire       [31:0]   _zz_VexRiscv_execute_SrcPlugin_addSub_4;
  wire       [31:0]   _zz_VexRiscv_execute_SrcPlugin_addSub_5;
  wire       [31:0]   _zz_VexRiscv_execute_SrcPlugin_addSub_6;
  wire       [31:0]   _zz_VexRiscv__zz_decode_RS2_3;
  wire       [32:0]   _zz_VexRiscv__zz_decode_RS2_3_1;
  wire       [19:0]   _zz_VexRiscv__zz_execute_BranchPlugin_branch_src2_2;
  wire       [11:0]   _zz_VexRiscv__zz_execute_BranchPlugin_branch_src2_4;
  wire                _zz_VexRiscv_execute_BranchPlugin_branch_src2;
  wire                _zz_VexRiscv_execute_BranchPlugin_branch_src2_1;
  wire                _zz_VexRiscv_execute_BranchPlugin_branch_src2_2;
  wire       [2:0]    _zz_VexRiscv_execute_BranchPlugin_branch_src2_3;
  wire       [31:0]   memory_MEMORY_READ_DATA;
  wire       [31:0]   execute_BRANCH_CALC;
  wire                execute_BRANCH_DO;
  wire       [31:0]   writeBack_REGFILE_WRITE_DATA;
  wire       [31:0]   execute_REGFILE_WRITE_DATA;
  wire       [1:0]    memory_MEMORY_ADDRESS_LOW;
  wire       [1:0]    execute_MEMORY_ADDRESS_LOW;
  wire                decode_DO_EBREAK;
  wire                decode_PREDICTION_HAD_BRANCHED2;
  wire       [31:0]   decode_SRC2;
  wire       [31:0]   decode_SRC1;
  wire                decode_SRC2_FORCE_ZERO;
  wire       `BranchCtrlEnum_defaultEncoding_type _zz_decode_to_execute_BRANCH_CTRL;
  wire       `BranchCtrlEnum_defaultEncoding_type _zz_decode_to_execute_BRANCH_CTRL_1;
  wire       `ShiftCtrlEnum_defaultEncoding_type decode_SHIFT_CTRL;
  wire       `ShiftCtrlEnum_defaultEncoding_type _zz_decode_SHIFT_CTRL;
  wire       `ShiftCtrlEnum_defaultEncoding_type _zz_decode_to_execute_SHIFT_CTRL;
  wire       `ShiftCtrlEnum_defaultEncoding_type _zz_decode_to_execute_SHIFT_CTRL_1;
  wire       `AluBitwiseCtrlEnum_defaultEncoding_type decode_ALU_BITWISE_CTRL;
  wire       `AluBitwiseCtrlEnum_defaultEncoding_type _zz_decode_ALU_BITWISE_CTRL;
  wire       `AluBitwiseCtrlEnum_defaultEncoding_type _zz_decode_to_execute_ALU_BITWISE_CTRL;
  wire       `AluBitwiseCtrlEnum_defaultEncoding_type _zz_decode_to_execute_ALU_BITWISE_CTRL_1;
  wire                decode_SRC_LESS_UNSIGNED;
  wire       `EnvCtrlEnum_defaultEncoding_type _zz_memory_to_writeBack_ENV_CTRL;
  wire       `EnvCtrlEnum_defaultEncoding_type _zz_memory_to_writeBack_ENV_CTRL_1;
  wire       `EnvCtrlEnum_defaultEncoding_type _zz_execute_to_memory_ENV_CTRL;
  wire       `EnvCtrlEnum_defaultEncoding_type _zz_execute_to_memory_ENV_CTRL_1;
  wire       `EnvCtrlEnum_defaultEncoding_type decode_ENV_CTRL;
  wire       `EnvCtrlEnum_defaultEncoding_type _zz_decode_ENV_CTRL;
  wire       `EnvCtrlEnum_defaultEncoding_type _zz_decode_to_execute_ENV_CTRL;
  wire       `EnvCtrlEnum_defaultEncoding_type _zz_decode_to_execute_ENV_CTRL_1;
  wire                decode_IS_CSR;
  wire                decode_MEMORY_STORE;
  wire                execute_BYPASSABLE_MEMORY_STAGE;
  wire                decode_BYPASSABLE_MEMORY_STAGE;
  wire                decode_BYPASSABLE_EXECUTE_STAGE;
  wire       `AluCtrlEnum_defaultEncoding_type decode_ALU_CTRL;
  wire       `AluCtrlEnum_defaultEncoding_type _zz_decode_ALU_CTRL;
  wire       `AluCtrlEnum_defaultEncoding_type _zz_decode_to_execute_ALU_CTRL;
  wire       `AluCtrlEnum_defaultEncoding_type _zz_decode_to_execute_ALU_CTRL_1;
  wire                decode_MEMORY_ENABLE;
  wire                decode_CSR_READ_OPCODE;
  wire                decode_CSR_WRITE_OPCODE;
  wire       [31:0]   writeBack_FORMAL_PC_NEXT;
  wire       [31:0]   memory_FORMAL_PC_NEXT;
  wire       [31:0]   execute_FORMAL_PC_NEXT;
  wire       [31:0]   decode_FORMAL_PC_NEXT;
  wire       [31:0]   memory_PC;
  wire                execute_DO_EBREAK;
  wire                decode_IS_EBREAK;
  wire       [31:0]   memory_BRANCH_CALC;
  wire                memory_BRANCH_DO;
  wire                execute_IS_RVC;
  wire       [31:0]   execute_PC;
  wire       [31:0]   execute_RS1;
  wire                execute_BRANCH_COND_RESULT;
  wire                execute_PREDICTION_HAD_BRANCHED2;
  wire       `BranchCtrlEnum_defaultEncoding_type execute_BRANCH_CTRL;
  wire       `BranchCtrlEnum_defaultEncoding_type _zz_execute_BRANCH_CTRL;
  wire                decode_RS2_USE;
  wire                decode_RS1_USE;
  wire                execute_REGFILE_WRITE_VALID;
  wire                execute_BYPASSABLE_EXECUTE_STAGE;
  wire       [31:0]   _zz_decode_RS2;
  wire                memory_REGFILE_WRITE_VALID;
  wire       [31:0]   memory_INSTRUCTION;
  wire                memory_BYPASSABLE_MEMORY_STAGE;
  wire                writeBack_REGFILE_WRITE_VALID;
  reg        [31:0]   decode_RS2;
  reg        [31:0]   decode_RS1;
  wire       `ShiftCtrlEnum_defaultEncoding_type execute_SHIFT_CTRL;
  wire       `ShiftCtrlEnum_defaultEncoding_type _zz_execute_SHIFT_CTRL;
  wire                execute_SRC_LESS_UNSIGNED;
  wire                execute_SRC2_FORCE_ZERO;
  wire                execute_SRC_USE_SUB_LESS;
  wire       [31:0]   _zz_decode_SRC2;
  wire       [31:0]   _zz_decode_SRC2_1;
  wire       `Src2CtrlEnum_defaultEncoding_type decode_SRC2_CTRL;
  wire       `Src2CtrlEnum_defaultEncoding_type _zz_decode_SRC2_CTRL;
  wire       [31:0]   _zz_decode_SRC1;
  wire       `Src1CtrlEnum_defaultEncoding_type decode_SRC1_CTRL;
  wire       `Src1CtrlEnum_defaultEncoding_type _zz_decode_SRC1_CTRL;
  wire                decode_SRC_USE_SUB_LESS;
  wire                decode_SRC_ADD_ZERO;
  wire       [31:0]   execute_SRC_ADD_SUB;
  wire                execute_SRC_LESS;
  wire       `AluCtrlEnum_defaultEncoding_type execute_ALU_CTRL;
  wire       `AluCtrlEnum_defaultEncoding_type _zz_execute_ALU_CTRL;
  wire       [31:0]   execute_SRC2;
  wire       `AluBitwiseCtrlEnum_defaultEncoding_type execute_ALU_BITWISE_CTRL;
  wire       `AluBitwiseCtrlEnum_defaultEncoding_type _zz_execute_ALU_BITWISE_CTRL;
  wire       [31:0]   _zz_lastStageRegFileWrite_payload_address;
  wire                _zz_lastStageRegFileWrite_valid;
  reg                 _zz_VexRiscv_1;
  wire       [31:0]   decode_INSTRUCTION_ANTICIPATED;
  reg                 decode_REGFILE_WRITE_VALID;
  wire       `BranchCtrlEnum_defaultEncoding_type _zz_decode_BRANCH_CTRL;
  wire       `ShiftCtrlEnum_defaultEncoding_type _zz_decode_SHIFT_CTRL_1;
  wire       `AluBitwiseCtrlEnum_defaultEncoding_type _zz_decode_ALU_BITWISE_CTRL_1;
  wire       `EnvCtrlEnum_defaultEncoding_type _zz_decode_ENV_CTRL_1;
  wire       `Src2CtrlEnum_defaultEncoding_type _zz_decode_SRC2_CTRL_1;
  wire       `AluCtrlEnum_defaultEncoding_type _zz_decode_ALU_CTRL_1;
  wire       `Src1CtrlEnum_defaultEncoding_type _zz_decode_SRC1_CTRL_1;
  reg        [31:0]   _zz_decode_RS2_1;
  wire       [31:0]   execute_SRC1;
  wire                execute_CSR_READ_OPCODE;
  wire                execute_CSR_WRITE_OPCODE;
  wire                execute_IS_CSR;
  wire       `EnvCtrlEnum_defaultEncoding_type memory_ENV_CTRL;
  wire       `EnvCtrlEnum_defaultEncoding_type _zz_memory_ENV_CTRL;
  wire       `EnvCtrlEnum_defaultEncoding_type execute_ENV_CTRL;
  wire       `EnvCtrlEnum_defaultEncoding_type _zz_execute_ENV_CTRL;
  wire       `EnvCtrlEnum_defaultEncoding_type writeBack_ENV_CTRL;
  wire       `EnvCtrlEnum_defaultEncoding_type _zz_writeBack_ENV_CTRL;
  wire                writeBack_MEMORY_STORE;
  reg        [31:0]   _zz_decode_RS2_2;
  wire                writeBack_MEMORY_ENABLE;
  wire       [1:0]    writeBack_MEMORY_ADDRESS_LOW;
  wire       [31:0]   writeBack_MEMORY_READ_DATA;
  wire                memory_ALIGNEMENT_FAULT;
  wire       [31:0]   memory_REGFILE_WRITE_DATA;
  wire                memory_MEMORY_STORE;
  wire                memory_MEMORY_ENABLE;
  wire       [31:0]   execute_SRC_ADD;
  wire       [31:0]   execute_RS2;
  wire       [31:0]   execute_INSTRUCTION;
  wire                execute_MEMORY_STORE;
  wire                execute_MEMORY_ENABLE;
  wire                execute_ALIGNEMENT_FAULT;
  wire       `BranchCtrlEnum_defaultEncoding_type decode_BRANCH_CTRL;
  wire       `BranchCtrlEnum_defaultEncoding_type _zz_decode_BRANCH_CTRL_1;
  reg        [31:0]   _zz_memory_to_writeBack_FORMAL_PC_NEXT;
  reg        [31:0]   _zz_decode_to_execute_FORMAL_PC_NEXT;
  wire       [31:0]   decode_PC;
  wire       [31:0]   decode_INSTRUCTION;
  wire                decode_IS_RVC;
  wire       [31:0]   writeBack_PC;
  wire       [31:0]   writeBack_INSTRUCTION;
  reg                 decode_arbitration_haltItself;
  reg                 decode_arbitration_haltByOther;
  reg                 decode_arbitration_removeIt;
  wire                decode_arbitration_flushIt;
  reg                 decode_arbitration_flushNext;
  reg                 decode_arbitration_isValid;
  wire                decode_arbitration_isStuck;
  wire                decode_arbitration_isStuckByOthers;
  wire                decode_arbitration_isFlushed;
  wire                decode_arbitration_isMoving;
  wire                decode_arbitration_isFiring;
  reg                 execute_arbitration_haltItself;
  reg                 execute_arbitration_haltByOther;
  reg                 execute_arbitration_removeIt;
  reg                 execute_arbitration_flushIt;
  reg                 execute_arbitration_flushNext;
  reg                 execute_arbitration_isValid;
  wire                execute_arbitration_isStuck;
  wire                execute_arbitration_isStuckByOthers;
  wire                execute_arbitration_isFlushed;
  wire                execute_arbitration_isMoving;
  wire                execute_arbitration_isFiring;
  reg                 memory_arbitration_haltItself;
  wire                memory_arbitration_haltByOther;
  reg                 memory_arbitration_removeIt;
  wire                memory_arbitration_flushIt;
  reg                 memory_arbitration_flushNext;
  reg                 memory_arbitration_isValid;
  wire                memory_arbitration_isStuck;
  wire                memory_arbitration_isStuckByOthers;
  wire                memory_arbitration_isFlushed;
  wire                memory_arbitration_isMoving;
  wire                memory_arbitration_isFiring;
  wire                writeBack_arbitration_haltItself;
  wire                writeBack_arbitration_haltByOther;
  reg                 writeBack_arbitration_removeIt;
  wire                writeBack_arbitration_flushIt;
  reg                 writeBack_arbitration_flushNext;
  reg                 writeBack_arbitration_isValid;
  wire                writeBack_arbitration_isStuck;
  wire                writeBack_arbitration_isStuckByOthers;
  wire                writeBack_arbitration_isFlushed;
  wire                writeBack_arbitration_isMoving;
  wire                writeBack_arbitration_isFiring;
  wire       [31:0]   lastStageInstruction /* verilator public */ ;
  wire       [31:0]   lastStagePc /* verilator public */ ;
  wire                lastStageIsValid /* verilator public */ ;
  wire                lastStageIsFiring /* verilator public */ ;
  reg                 IBusSimplePlugin_fetcherHalt;
  reg                 IBusSimplePlugin_incomingInstruction;
  wire                IBusSimplePlugin_predictionJumpInterface_valid;
  (* keep , syn_keep *) wire       [31:0]   IBusSimplePlugin_predictionJumpInterface_payload /* synthesis syn_keep = 1 */ ;
  wire                IBusSimplePlugin_decodePrediction_cmd_hadBranch;
  wire                IBusSimplePlugin_decodePrediction_rsp_wasWrong;
  wire                IBusSimplePlugin_pcValids_0;
  wire                IBusSimplePlugin_pcValids_1;
  wire                IBusSimplePlugin_pcValids_2;
  wire                IBusSimplePlugin_pcValids_3;
  reg                 DBusSimplePlugin_memoryExceptionPort_valid;
  reg        [3:0]    DBusSimplePlugin_memoryExceptionPort_payload_code;
  wire       [31:0]   DBusSimplePlugin_memoryExceptionPort_payload_badAddr;
  wire       [31:0]   CsrPlugin_csrMapping_readDataSignal;
  wire       [31:0]   CsrPlugin_csrMapping_readDataInit;
  wire       [31:0]   CsrPlugin_csrMapping_writeDataSignal;
  wire                CsrPlugin_csrMapping_allowCsrSignal;
  wire                CsrPlugin_csrMapping_hazardFree;
  wire                CsrPlugin_inWfi /* verilator public */ ;
  reg                 CsrPlugin_thirdPartyWake;
  reg                 CsrPlugin_jumpInterface_valid;
  reg        [31:0]   CsrPlugin_jumpInterface_payload;
  wire                CsrPlugin_exceptionPendings_0;
  wire                CsrPlugin_exceptionPendings_1;
  wire                CsrPlugin_exceptionPendings_2;
  wire                CsrPlugin_exceptionPendings_3;
  wire                contextSwitching;
  reg        [1:0]    CsrPlugin_privilege;
  reg                 CsrPlugin_forceMachineWire;
  reg                 CsrPlugin_selfException_valid;
  reg        [3:0]    CsrPlugin_selfException_payload_code;
  wire       [31:0]   CsrPlugin_selfException_payload_badAddr;
  reg                 CsrPlugin_allowInterrupts;
  reg                 CsrPlugin_allowException;
  reg                 CsrPlugin_allowEbreakException;
  wire                BranchPlugin_jumpInterface_valid;
  wire       [31:0]   BranchPlugin_jumpInterface_payload;
  reg                 IBusSimplePlugin_injectionPort_valid;
  reg                 IBusSimplePlugin_injectionPort_ready;
  wire       [31:0]   IBusSimplePlugin_injectionPort_payload;
  wire                IBusSimplePlugin_externalFlush;
  wire                IBusSimplePlugin_jump_pcLoad_valid;
  wire       [31:0]   IBusSimplePlugin_jump_pcLoad_payload;
  wire       [2:0]    _zz_IBusSimplePlugin_jump_pcLoad_payload;
  wire       [2:0]    _zz_IBusSimplePlugin_jump_pcLoad_payload_1;
  wire                _zz_IBusSimplePlugin_jump_pcLoad_payload_2;
  wire                _zz_IBusSimplePlugin_jump_pcLoad_payload_3;
  wire                IBusSimplePlugin_fetchPc_output_valid;
  wire                IBusSimplePlugin_fetchPc_output_ready;
  wire       [31:0]   IBusSimplePlugin_fetchPc_output_payload;
  reg        [31:0]   IBusSimplePlugin_fetchPc_pcReg /* verilator public */ ;
  reg                 IBusSimplePlugin_fetchPc_correction;
  reg                 IBusSimplePlugin_fetchPc_correctionReg;
  wire                when_Fetcher_l127;
  wire                IBusSimplePlugin_fetchPc_corrected;
  reg                 IBusSimplePlugin_fetchPc_pcRegPropagate;
  reg                 IBusSimplePlugin_fetchPc_booted;
  reg                 IBusSimplePlugin_fetchPc_inc;
  wire                when_Fetcher_l131;
  wire                when_Fetcher_l131_1;
  wire                when_Fetcher_l131_2;
  reg        [31:0]   IBusSimplePlugin_fetchPc_pc;
  reg                 IBusSimplePlugin_fetchPc_flushed;
  wire                when_Fetcher_l158;
  reg                 IBusSimplePlugin_decodePc_flushed;
  reg        [31:0]   IBusSimplePlugin_decodePc_pcReg /* verilator public */ ;
  wire       [31:0]   IBusSimplePlugin_decodePc_pcPlus;
  reg                 IBusSimplePlugin_decodePc_injectedDecode;
  wire                when_Fetcher_l180;
  wire                when_Fetcher_l192;
  wire                IBusSimplePlugin_iBusRsp_redoFetch;
  wire                IBusSimplePlugin_iBusRsp_stages_0_input_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_0_input_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_0_input_payload;
  wire                IBusSimplePlugin_iBusRsp_stages_0_output_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_0_output_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_0_output_payload;
  reg                 IBusSimplePlugin_iBusRsp_stages_0_halt;
  wire                IBusSimplePlugin_iBusRsp_stages_1_input_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_1_input_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_1_input_payload;
  wire                IBusSimplePlugin_iBusRsp_stages_1_output_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_1_output_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_1_output_payload;
  wire                IBusSimplePlugin_iBusRsp_stages_1_halt;
  wire                _zz_IBusSimplePlugin_iBusRsp_stages_0_input_ready;
  wire                _zz_IBusSimplePlugin_iBusRsp_stages_1_input_ready;
  wire                IBusSimplePlugin_iBusRsp_flush;
  wire                _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready;
  wire                _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready_1;
  reg                 _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready_2;
  reg                 IBusSimplePlugin_iBusRsp_readyForError;
  wire                IBusSimplePlugin_iBusRsp_output_valid;
  wire                IBusSimplePlugin_iBusRsp_output_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_output_payload_pc;
  wire                IBusSimplePlugin_iBusRsp_output_payload_rsp_error;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_output_payload_rsp_inst;
  wire                IBusSimplePlugin_iBusRsp_output_payload_isRvc;
  wire                IBusSimplePlugin_decompressor_input_valid;
  wire                IBusSimplePlugin_decompressor_input_ready;
  wire       [31:0]   IBusSimplePlugin_decompressor_input_payload_pc;
  wire                IBusSimplePlugin_decompressor_input_payload_rsp_error;
  wire       [31:0]   IBusSimplePlugin_decompressor_input_payload_rsp_inst;
  wire                IBusSimplePlugin_decompressor_input_payload_isRvc;
  wire                IBusSimplePlugin_decompressor_output_valid;
  wire                IBusSimplePlugin_decompressor_output_ready;
  wire       [31:0]   IBusSimplePlugin_decompressor_output_payload_pc;
  wire                IBusSimplePlugin_decompressor_output_payload_rsp_error;
  wire       [31:0]   IBusSimplePlugin_decompressor_output_payload_rsp_inst;
  wire                IBusSimplePlugin_decompressor_output_payload_isRvc;
  wire                IBusSimplePlugin_decompressor_flushNext;
  wire                IBusSimplePlugin_decompressor_consumeCurrent;
  reg                 IBusSimplePlugin_decompressor_bufferValid;
  reg        [15:0]   IBusSimplePlugin_decompressor_bufferData;
  wire                IBusSimplePlugin_decompressor_isInputLowRvc;
  wire                IBusSimplePlugin_decompressor_isInputHighRvc;
  reg                 IBusSimplePlugin_decompressor_throw2BytesReg;
  wire                IBusSimplePlugin_decompressor_throw2Bytes;
  wire                IBusSimplePlugin_decompressor_unaligned;
  reg                 IBusSimplePlugin_decompressor_bufferValidLatch;
  reg                 IBusSimplePlugin_decompressor_throw2BytesLatch;
  wire                IBusSimplePlugin_decompressor_bufferValidPatched;
  wire                IBusSimplePlugin_decompressor_throw2BytesPatched;
  wire       [31:0]   IBusSimplePlugin_decompressor_raw;
  wire                IBusSimplePlugin_decompressor_isRvc;
  wire       [15:0]   _zz_IBusSimplePlugin_decompressor_decompressed;
  reg        [31:0]   IBusSimplePlugin_decompressor_decompressed;
  wire       [4:0]    _zz_IBusSimplePlugin_decompressor_decompressed_1;
  wire       [4:0]    _zz_IBusSimplePlugin_decompressor_decompressed_2;
  wire       [11:0]   _zz_IBusSimplePlugin_decompressor_decompressed_3;
  wire                _zz_IBusSimplePlugin_decompressor_decompressed_4;
  reg        [11:0]   _zz_IBusSimplePlugin_decompressor_decompressed_5;
  wire                _zz_IBusSimplePlugin_decompressor_decompressed_6;
  reg        [9:0]    _zz_IBusSimplePlugin_decompressor_decompressed_7;
  wire       [20:0]   _zz_IBusSimplePlugin_decompressor_decompressed_8;
  wire                _zz_IBusSimplePlugin_decompressor_decompressed_9;
  reg        [14:0]   _zz_IBusSimplePlugin_decompressor_decompressed_10;
  wire                _zz_IBusSimplePlugin_decompressor_decompressed_11;
  reg        [2:0]    _zz_IBusSimplePlugin_decompressor_decompressed_12;
  wire                _zz_IBusSimplePlugin_decompressor_decompressed_13;
  reg        [9:0]    _zz_IBusSimplePlugin_decompressor_decompressed_14;
  wire       [20:0]   _zz_IBusSimplePlugin_decompressor_decompressed_15;
  wire                _zz_IBusSimplePlugin_decompressor_decompressed_16;
  reg        [4:0]    _zz_IBusSimplePlugin_decompressor_decompressed_17;
  wire       [12:0]   _zz_IBusSimplePlugin_decompressor_decompressed_18;
  wire       [4:0]    _zz_IBusSimplePlugin_decompressor_decompressed_19;
  wire       [4:0]    _zz_IBusSimplePlugin_decompressor_decompressed_20;
  wire       [4:0]    _zz_IBusSimplePlugin_decompressor_decompressed_21;
  wire       [4:0]    switch_Misc_l44;
  wire                _zz_IBusSimplePlugin_decompressor_decompressed_22;
  wire       [1:0]    switch_Misc_l199;
  wire       [1:0]    switch_Misc_l199_1;
  reg        [2:0]    _zz_IBusSimplePlugin_decompressor_decompressed_23;
  reg        [2:0]    _zz_IBusSimplePlugin_decompressor_decompressed_24;
  wire                _zz_IBusSimplePlugin_decompressor_decompressed_25;
  reg        [6:0]    _zz_IBusSimplePlugin_decompressor_decompressed_26;
  wire                when_Fetcher_l279;
  wire                IBusSimplePlugin_decompressor_bufferFill;
  wire                when_Fetcher_l283;
  wire                when_Fetcher_l286;
  wire                when_Fetcher_l291;
  wire                IBusSimplePlugin_injector_decodeInput_valid;
  wire                IBusSimplePlugin_injector_decodeInput_ready;
  wire       [31:0]   IBusSimplePlugin_injector_decodeInput_payload_pc;
  wire                IBusSimplePlugin_injector_decodeInput_payload_rsp_error;
  wire       [31:0]   IBusSimplePlugin_injector_decodeInput_payload_rsp_inst;
  wire                IBusSimplePlugin_injector_decodeInput_payload_isRvc;
  reg                 _zz_IBusSimplePlugin_injector_decodeInput_valid;
  reg        [31:0]   _zz_IBusSimplePlugin_injector_decodeInput_payload_pc;
  reg                 _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_error;
  reg        [31:0]   _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_inst;
  reg                 _zz_IBusSimplePlugin_injector_decodeInput_payload_isRvc;
  reg                 IBusSimplePlugin_injector_nextPcCalc_valids_0;
  wire                when_Fetcher_l329;
  reg                 IBusSimplePlugin_injector_nextPcCalc_valids_1;
  wire                when_Fetcher_l329_1;
  reg                 IBusSimplePlugin_injector_nextPcCalc_valids_2;
  wire                when_Fetcher_l329_2;
  reg                 IBusSimplePlugin_injector_nextPcCalc_valids_3;
  wire                when_Fetcher_l329_3;
  reg        [31:0]   IBusSimplePlugin_injector_formal_rawInDecode;
  wire                _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch;
  reg        [18:0]   _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch_1;
  wire                _zz_IBusSimplePlugin_predictionJumpInterface_payload;
  reg        [10:0]   _zz_IBusSimplePlugin_predictionJumpInterface_payload_1;
  wire                _zz_IBusSimplePlugin_predictionJumpInterface_payload_2;
  reg        [18:0]   _zz_IBusSimplePlugin_predictionJumpInterface_payload_3;
  wire                IBusSimplePlugin_cmd_valid;
  wire                IBusSimplePlugin_cmd_ready;
  wire       [31:0]   IBusSimplePlugin_cmd_payload_pc;
  wire                IBusSimplePlugin_pending_inc;
  wire                IBusSimplePlugin_pending_dec;
  reg        [2:0]    IBusSimplePlugin_pending_value;
  wire       [2:0]    IBusSimplePlugin_pending_next;
  wire                IBusSimplePlugin_cmdFork_canEmit;
  wire                when_IBusSimplePlugin_l304;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_output_valid;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_output_ready;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_output_payload_error;
  wire       [31:0]   IBusSimplePlugin_rspJoin_rspBuffer_output_payload_inst;
  reg        [2:0]    IBusSimplePlugin_rspJoin_rspBuffer_discardCounter;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_flush;
  wire       [31:0]   IBusSimplePlugin_rspJoin_fetchRsp_pc;
  reg                 IBusSimplePlugin_rspJoin_fetchRsp_rsp_error;
  wire       [31:0]   IBusSimplePlugin_rspJoin_fetchRsp_rsp_inst;
  wire                IBusSimplePlugin_rspJoin_fetchRsp_isRvc;
  wire                when_IBusSimplePlugin_l375;
  wire                IBusSimplePlugin_rspJoin_join_valid;
  wire                IBusSimplePlugin_rspJoin_join_ready;
  wire       [31:0]   IBusSimplePlugin_rspJoin_join_payload_pc;
  wire                IBusSimplePlugin_rspJoin_join_payload_rsp_error;
  wire       [31:0]   IBusSimplePlugin_rspJoin_join_payload_rsp_inst;
  wire                IBusSimplePlugin_rspJoin_join_payload_isRvc;
  wire                IBusSimplePlugin_rspJoin_exceptionDetected;
  wire                _zz_IBusSimplePlugin_iBusRsp_output_valid;
  wire                _zz_dBus_cmd_valid;
  reg                 execute_DBusSimplePlugin_skipCmd;
  reg        [31:0]   _zz_dBus_cmd_payload_data;
  wire                when_DBusSimplePlugin_l426;
  reg        [3:0]    _zz_execute_DBusSimplePlugin_formalMask;
  wire       [3:0]    execute_DBusSimplePlugin_formalMask;
  wire                when_DBusSimplePlugin_l479;
  wire                when_DBusSimplePlugin_l512;
  reg        [31:0]   writeBack_DBusSimplePlugin_rspShifted;
  wire       [1:0]    switch_Misc_l199_2;
  wire                _zz_writeBack_DBusSimplePlugin_rspFormated;
  reg        [31:0]   _zz_writeBack_DBusSimplePlugin_rspFormated_1;
  wire                _zz_writeBack_DBusSimplePlugin_rspFormated_2;
  reg        [31:0]   _zz_writeBack_DBusSimplePlugin_rspFormated_3;
  reg        [31:0]   writeBack_DBusSimplePlugin_rspFormated;
  wire                when_DBusSimplePlugin_l558;
  wire       [1:0]    CsrPlugin_misa_base;
  wire       [25:0]   CsrPlugin_misa_extensions;
  wire       [1:0]    CsrPlugin_mtvec_mode;
  wire       [29:0]   CsrPlugin_mtvec_base;
  reg        [31:0]   CsrPlugin_mepc;
  reg                 CsrPlugin_mstatus_MIE;
  reg                 CsrPlugin_mstatus_MPIE;
  reg        [1:0]    CsrPlugin_mstatus_MPP;
  reg                 CsrPlugin_mip_MEIP;
  reg                 CsrPlugin_mip_MTIP;
  reg                 CsrPlugin_mip_MSIP;
  reg                 CsrPlugin_mie_MEIE;
  reg                 CsrPlugin_mie_MTIE;
  reg                 CsrPlugin_mie_MSIE;
  reg                 CsrPlugin_mcause_interrupt;
  reg        [3:0]    CsrPlugin_mcause_exceptionCode;
  reg        [31:0]   CsrPlugin_mtval;
  reg        [63:0]   CsrPlugin_mcycle = 64'b0000000000000000000000000000000000000000000000000000000000000000;
  reg        [63:0]   CsrPlugin_minstret = 64'b0000000000000000000000000000000000000000000000000000000000000000;
  wire                _zz_when_CsrPlugin_l952;
  wire                _zz_when_CsrPlugin_l952_1;
  wire                _zz_when_CsrPlugin_l952_2;
  wire                CsrPlugin_exceptionPortCtrl_exceptionValids_decode;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack;
  wire                CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
  reg        [3:0]    CsrPlugin_exceptionPortCtrl_exceptionContext_code;
  reg        [31:0]   CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
  wire       [1:0]    CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped;
  wire       [1:0]    CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege;
  wire                when_CsrPlugin_l909;
  wire                when_CsrPlugin_l909_1;
  wire                when_CsrPlugin_l909_2;
  wire                when_CsrPlugin_l922;
  reg                 CsrPlugin_interrupt_valid;
  reg        [3:0]    CsrPlugin_interrupt_code /* verilator public */ ;
  reg        [1:0]    CsrPlugin_interrupt_targetPrivilege;
  wire                when_CsrPlugin_l946;
  wire                when_CsrPlugin_l952;
  wire                when_CsrPlugin_l952_1;
  wire                when_CsrPlugin_l952_2;
  wire                CsrPlugin_exception;
  wire                CsrPlugin_lastStageWasWfi;
  reg                 CsrPlugin_pipelineLiberator_pcValids_0;
  reg                 CsrPlugin_pipelineLiberator_pcValids_1;
  reg                 CsrPlugin_pipelineLiberator_pcValids_2;
  wire                CsrPlugin_pipelineLiberator_active;
  wire                when_CsrPlugin_l980;
  wire                when_CsrPlugin_l980_1;
  wire                when_CsrPlugin_l980_2;
  wire                when_CsrPlugin_l985;
  reg                 CsrPlugin_pipelineLiberator_done;
  wire                when_CsrPlugin_l991;
  wire                CsrPlugin_interruptJump /* verilator public */ ;
  reg                 CsrPlugin_hadException /* verilator public */ ;
  reg        [1:0]    CsrPlugin_targetPrivilege;
  reg        [3:0]    CsrPlugin_trapCause;
  reg        [1:0]    CsrPlugin_xtvec_mode;
  reg        [29:0]   CsrPlugin_xtvec_base;
  wire                when_CsrPlugin_l1019;
  wire                when_CsrPlugin_l1064;
  wire       [1:0]    switch_CsrPlugin_l1068;
  reg                 execute_CsrPlugin_wfiWake;
  wire                when_CsrPlugin_l1116;
  wire                execute_CsrPlugin_blockedBySideEffects;
  reg                 execute_CsrPlugin_illegalAccess;
  reg                 execute_CsrPlugin_illegalInstruction;
  wire                when_CsrPlugin_l1129;
  wire                when_CsrPlugin_l1136;
  wire                when_CsrPlugin_l1137;
  wire                when_CsrPlugin_l1154;
  reg                 execute_CsrPlugin_writeInstruction;
  reg                 execute_CsrPlugin_readInstruction;
  wire                execute_CsrPlugin_writeEnable;
  wire                execute_CsrPlugin_readEnable;
  wire       [31:0]   execute_CsrPlugin_readToWriteData;
  wire                switch_Misc_l199_3;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_writeDataSignal;
  wire                when_CsrPlugin_l1176;
  wire                when_CsrPlugin_l1180;
  wire       [11:0]   execute_CsrPlugin_csrAddress;
  wire       [26:0]   _zz_decode_SHIFT_CTRL_2;
  wire                _zz_decode_SHIFT_CTRL_3;
  wire                _zz_decode_SHIFT_CTRL_4;
  wire                _zz_decode_SHIFT_CTRL_5;
  wire                _zz_decode_SHIFT_CTRL_6;
  wire                _zz_decode_SHIFT_CTRL_7;
  wire       `Src1CtrlEnum_defaultEncoding_type _zz_decode_SRC1_CTRL_2;
  wire       `AluCtrlEnum_defaultEncoding_type _zz_decode_ALU_CTRL_2;
  wire       `Src2CtrlEnum_defaultEncoding_type _zz_decode_SRC2_CTRL_2;
  wire       `EnvCtrlEnum_defaultEncoding_type _zz_decode_ENV_CTRL_2;
  wire       `AluBitwiseCtrlEnum_defaultEncoding_type _zz_decode_ALU_BITWISE_CTRL_2;
  wire       `ShiftCtrlEnum_defaultEncoding_type _zz_decode_SHIFT_CTRL_8;
  wire       `BranchCtrlEnum_defaultEncoding_type _zz_decode_BRANCH_CTRL_2;
  wire                when_RegFilePlugin_l63;
  wire       [4:0]    decode_RegFilePlugin_regFileReadAddress1;
  wire       [4:0]    decode_RegFilePlugin_regFileReadAddress2;
  wire       [31:0]   decode_RegFilePlugin_rs1Data;
  wire       [31:0]   decode_RegFilePlugin_rs2Data;
  reg                 lastStageRegFileWrite_valid /* verilator public */ ;
  reg        [4:0]    lastStageRegFileWrite_payload_address /* verilator public */ ;
  reg        [31:0]   lastStageRegFileWrite_payload_data /* verilator public */ ;
  reg                 _zz_VexRiscv_2;
  reg        [31:0]   execute_IntAluPlugin_bitwise;
  reg        [31:0]   _zz_execute_REGFILE_WRITE_DATA;
  reg        [31:0]   _zz_decode_SRC1_1;
  wire                _zz_decode_SRC2_2;
  reg        [19:0]   _zz_decode_SRC2_3;
  wire                _zz_decode_SRC2_4;
  reg        [19:0]   _zz_decode_SRC2_5;
  reg        [31:0]   _zz_decode_SRC2_6;
  reg        [31:0]   execute_SrcPlugin_addSub;
  wire                execute_SrcPlugin_less;
  reg                 execute_LightShifterPlugin_isActive;
  wire                execute_LightShifterPlugin_isShift;
  reg        [4:0]    execute_LightShifterPlugin_amplitudeReg;
  wire       [4:0]    execute_LightShifterPlugin_amplitude;
  wire       [31:0]   execute_LightShifterPlugin_shiftInput;
  wire                execute_LightShifterPlugin_done;
  wire                when_ShiftPlugins_l169;
  reg        [31:0]   _zz_decode_RS2_3;
  wire                when_ShiftPlugins_l175;
  wire                when_ShiftPlugins_l184;
  reg                 HazardSimplePlugin_src0Hazard;
  reg                 HazardSimplePlugin_src1Hazard;
  wire                HazardSimplePlugin_writeBackWrites_valid;
  wire       [4:0]    HazardSimplePlugin_writeBackWrites_payload_address;
  wire       [31:0]   HazardSimplePlugin_writeBackWrites_payload_data;
  reg                 HazardSimplePlugin_writeBackBuffer_valid;
  reg        [4:0]    HazardSimplePlugin_writeBackBuffer_payload_address;
  reg        [31:0]   HazardSimplePlugin_writeBackBuffer_payload_data;
  wire                HazardSimplePlugin_addr0Match;
  wire                HazardSimplePlugin_addr1Match;
  wire                when_HazardSimplePlugin_l47;
  wire                when_HazardSimplePlugin_l48;
  wire                when_HazardSimplePlugin_l51;
  wire                when_HazardSimplePlugin_l45;
  wire                when_HazardSimplePlugin_l57;
  wire                when_HazardSimplePlugin_l58;
  wire                when_HazardSimplePlugin_l48_1;
  wire                when_HazardSimplePlugin_l51_1;
  wire                when_HazardSimplePlugin_l45_1;
  wire                when_HazardSimplePlugin_l57_1;
  wire                when_HazardSimplePlugin_l58_1;
  wire                when_HazardSimplePlugin_l48_2;
  wire                when_HazardSimplePlugin_l51_2;
  wire                when_HazardSimplePlugin_l45_2;
  wire                when_HazardSimplePlugin_l57_2;
  wire                when_HazardSimplePlugin_l58_2;
  wire                when_HazardSimplePlugin_l105;
  wire                when_HazardSimplePlugin_l108;
  wire                when_HazardSimplePlugin_l113;
  wire                execute_BranchPlugin_eq;
  wire       [2:0]    switch_Misc_l199_4;
  reg                 _zz_execute_BRANCH_COND_RESULT;
  reg                 _zz_execute_BRANCH_COND_RESULT_1;
  wire                execute_BranchPlugin_missAlignedTarget;
  reg        [31:0]   execute_BranchPlugin_branch_src1;
  reg        [31:0]   execute_BranchPlugin_branch_src2;
  wire                _zz_execute_BranchPlugin_branch_src2;
  reg        [19:0]   _zz_execute_BranchPlugin_branch_src2_1;
  wire                _zz_execute_BranchPlugin_branch_src2_2;
  reg        [10:0]   _zz_execute_BranchPlugin_branch_src2_3;
  wire                _zz_execute_BranchPlugin_branch_src2_4;
  reg        [18:0]   _zz_execute_BranchPlugin_branch_src2_5;
  wire       [31:0]   execute_BranchPlugin_branchAdder;
  reg                 DebugPlugin_firstCycle;
  reg                 DebugPlugin_secondCycle;
  reg                 DebugPlugin_resetIt;
  reg                 DebugPlugin_haltIt;
  reg                 DebugPlugin_stepIt;
  reg                 DebugPlugin_isPipBusy;
  reg                 DebugPlugin_godmode;
  wire                when_DebugPlugin_l225;
  reg                 DebugPlugin_haltedByBreak;
  reg                 DebugPlugin_debugUsed /* verilator public */ ;
  reg                 DebugPlugin_disableEbreak;
  wire                DebugPlugin_allowEBreak;
  reg        [31:0]   DebugPlugin_busReadDataReg;
  reg                 _zz_when_DebugPlugin_l244;
  wire                when_DebugPlugin_l244;
  wire       [5:0]    switch_DebugPlugin_l256;
  wire                when_DebugPlugin_l260;
  wire                when_DebugPlugin_l260_1;
  wire                when_DebugPlugin_l261;
  wire                when_DebugPlugin_l261_1;
  wire                when_DebugPlugin_l262;
  wire                when_DebugPlugin_l263;
  wire                when_DebugPlugin_l264;
  wire                when_DebugPlugin_l264_1;
  wire                when_DebugPlugin_l284;
  wire                when_DebugPlugin_l287;
  wire                when_DebugPlugin_l300;
  reg                 _zz_VexRiscv_3;
  reg                 DebugPlugin_resetIt_regNext;
  wire                when_DebugPlugin_l316;
  wire                when_Pipeline_l124;
  reg        [31:0]   decode_to_execute_PC;
  wire                when_Pipeline_l124_1;
  reg        [31:0]   execute_to_memory_PC;
  wire                when_Pipeline_l124_2;
  reg        [31:0]   memory_to_writeBack_PC;
  wire                when_Pipeline_l124_3;
  reg        [31:0]   decode_to_execute_INSTRUCTION;
  wire                when_Pipeline_l124_4;
  reg        [31:0]   execute_to_memory_INSTRUCTION;
  wire                when_Pipeline_l124_5;
  reg        [31:0]   memory_to_writeBack_INSTRUCTION;
  wire                when_Pipeline_l124_6;
  reg                 decode_to_execute_IS_RVC;
  wire                when_Pipeline_l124_7;
  reg        [31:0]   decode_to_execute_FORMAL_PC_NEXT;
  wire                when_Pipeline_l124_8;
  reg        [31:0]   execute_to_memory_FORMAL_PC_NEXT;
  wire                when_Pipeline_l124_9;
  reg        [31:0]   memory_to_writeBack_FORMAL_PC_NEXT;
  wire                when_Pipeline_l124_10;
  reg                 decode_to_execute_CSR_WRITE_OPCODE;
  wire                when_Pipeline_l124_11;
  reg                 decode_to_execute_CSR_READ_OPCODE;
  wire                when_Pipeline_l124_12;
  reg                 decode_to_execute_SRC_USE_SUB_LESS;
  wire                when_Pipeline_l124_13;
  reg                 decode_to_execute_MEMORY_ENABLE;
  wire                when_Pipeline_l124_14;
  reg                 execute_to_memory_MEMORY_ENABLE;
  wire                when_Pipeline_l124_15;
  reg                 memory_to_writeBack_MEMORY_ENABLE;
  wire                when_Pipeline_l124_16;
  reg        `AluCtrlEnum_defaultEncoding_type decode_to_execute_ALU_CTRL;
  wire                when_Pipeline_l124_17;
  reg                 decode_to_execute_REGFILE_WRITE_VALID;
  wire                when_Pipeline_l124_18;
  reg                 execute_to_memory_REGFILE_WRITE_VALID;
  wire                when_Pipeline_l124_19;
  reg                 memory_to_writeBack_REGFILE_WRITE_VALID;
  wire                when_Pipeline_l124_20;
  reg                 decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  wire                when_Pipeline_l124_21;
  reg                 decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  wire                when_Pipeline_l124_22;
  reg                 execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  wire                when_Pipeline_l124_23;
  reg                 decode_to_execute_MEMORY_STORE;
  wire                when_Pipeline_l124_24;
  reg                 execute_to_memory_MEMORY_STORE;
  wire                when_Pipeline_l124_25;
  reg                 memory_to_writeBack_MEMORY_STORE;
  wire                when_Pipeline_l124_26;
  reg                 decode_to_execute_IS_CSR;
  wire                when_Pipeline_l124_27;
  reg        `EnvCtrlEnum_defaultEncoding_type decode_to_execute_ENV_CTRL;
  wire                when_Pipeline_l124_28;
  reg        `EnvCtrlEnum_defaultEncoding_type execute_to_memory_ENV_CTRL;
  wire                when_Pipeline_l124_29;
  reg        `EnvCtrlEnum_defaultEncoding_type memory_to_writeBack_ENV_CTRL;
  wire                when_Pipeline_l124_30;
  reg                 decode_to_execute_SRC_LESS_UNSIGNED;
  wire                when_Pipeline_l124_31;
  reg        `AluBitwiseCtrlEnum_defaultEncoding_type decode_to_execute_ALU_BITWISE_CTRL;
  wire                when_Pipeline_l124_32;
  reg        `ShiftCtrlEnum_defaultEncoding_type decode_to_execute_SHIFT_CTRL;
  wire                when_Pipeline_l124_33;
  reg        `BranchCtrlEnum_defaultEncoding_type decode_to_execute_BRANCH_CTRL;
  wire                when_Pipeline_l124_34;
  reg        [31:0]   decode_to_execute_RS1;
  wire                when_Pipeline_l124_35;
  reg        [31:0]   decode_to_execute_RS2;
  wire                when_Pipeline_l124_36;
  reg                 decode_to_execute_SRC2_FORCE_ZERO;
  wire                when_Pipeline_l124_37;
  reg        [31:0]   decode_to_execute_SRC1;
  wire                when_Pipeline_l124_38;
  reg        [31:0]   decode_to_execute_SRC2;
  wire                when_Pipeline_l124_39;
  reg                 decode_to_execute_PREDICTION_HAD_BRANCHED2;
  wire                when_Pipeline_l124_40;
  reg                 decode_to_execute_DO_EBREAK;
  wire                when_Pipeline_l124_41;
  reg                 execute_to_memory_ALIGNEMENT_FAULT;
  wire                when_Pipeline_l124_42;
  reg        [1:0]    execute_to_memory_MEMORY_ADDRESS_LOW;
  wire                when_Pipeline_l124_43;
  reg        [1:0]    memory_to_writeBack_MEMORY_ADDRESS_LOW;
  wire                when_Pipeline_l124_44;
  reg        [31:0]   execute_to_memory_REGFILE_WRITE_DATA;
  wire                when_Pipeline_l124_45;
  reg        [31:0]   memory_to_writeBack_REGFILE_WRITE_DATA;
  wire                when_Pipeline_l124_46;
  reg                 execute_to_memory_BRANCH_DO;
  wire                when_Pipeline_l124_47;
  reg        [31:0]   execute_to_memory_BRANCH_CALC;
  wire                when_Pipeline_l124_48;
  reg        [31:0]   memory_to_writeBack_MEMORY_READ_DATA;
  wire                when_Pipeline_l151;
  wire                when_Pipeline_l154;
  wire                when_Pipeline_l151_1;
  wire                when_Pipeline_l154_1;
  wire                when_Pipeline_l151_2;
  wire                when_Pipeline_l154_2;
  reg        [2:0]    switch_Fetcher_l362;
  wire                when_Fetcher_l360;
  wire                when_Fetcher_l378;
  wire                when_Fetcher_l398;
  wire                when_CsrPlugin_l1264;
  reg                 execute_CsrPlugin_csr_768;
  wire                when_CsrPlugin_l1264_1;
  reg                 execute_CsrPlugin_csr_836;
  wire                when_CsrPlugin_l1264_2;
  reg                 execute_CsrPlugin_csr_772;
  wire                when_CsrPlugin_l1264_3;
  reg                 execute_CsrPlugin_csr_833;
  wire                when_CsrPlugin_l1264_4;
  reg                 execute_CsrPlugin_csr_834;
  wire                when_CsrPlugin_l1264_5;
  reg                 execute_CsrPlugin_csr_835;
  wire                when_CsrPlugin_l1264_6;
  reg                 execute_CsrPlugin_csr_3072;
  wire                when_CsrPlugin_l1264_7;
  reg                 execute_CsrPlugin_csr_3200;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_1;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_2;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_3;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_4;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_5;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_6;
  reg        [31:0]   _zz_CsrPlugin_csrMapping_readDataInit_7;
  wire                when_CsrPlugin_l1297;
  wire                when_CsrPlugin_l1302;
  `ifndef SYNTHESIS
  reg [31:0] _zz_decode_to_execute_BRANCH_CTRL_string;
  reg [31:0] _zz_decode_to_execute_BRANCH_CTRL_1_string;
  reg [55:0] decode_SHIFT_CTRL_string;
  reg [55:0] _zz_decode_SHIFT_CTRL_string;
  reg [55:0] _zz_decode_to_execute_SHIFT_CTRL_string;
  reg [55:0] _zz_decode_to_execute_SHIFT_CTRL_1_string;
  reg [23:0] decode_ALU_BITWISE_CTRL_string;
  reg [23:0] _zz_decode_ALU_BITWISE_CTRL_string;
  reg [23:0] _zz_decode_to_execute_ALU_BITWISE_CTRL_string;
  reg [23:0] _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string;
  reg [47:0] _zz_memory_to_writeBack_ENV_CTRL_string;
  reg [47:0] _zz_memory_to_writeBack_ENV_CTRL_1_string;
  reg [47:0] _zz_execute_to_memory_ENV_CTRL_string;
  reg [47:0] _zz_execute_to_memory_ENV_CTRL_1_string;
  reg [47:0] decode_ENV_CTRL_string;
  reg [47:0] _zz_decode_ENV_CTRL_string;
  reg [47:0] _zz_decode_to_execute_ENV_CTRL_string;
  reg [47:0] _zz_decode_to_execute_ENV_CTRL_1_string;
  reg [63:0] decode_ALU_CTRL_string;
  reg [63:0] _zz_decode_ALU_CTRL_string;
  reg [63:0] _zz_decode_to_execute_ALU_CTRL_string;
  reg [63:0] _zz_decode_to_execute_ALU_CTRL_1_string;
  reg [31:0] execute_BRANCH_CTRL_string;
  reg [31:0] _zz_execute_BRANCH_CTRL_string;
  reg [55:0] execute_SHIFT_CTRL_string;
  reg [55:0] _zz_execute_SHIFT_CTRL_string;
  reg [23:0] decode_SRC2_CTRL_string;
  reg [23:0] _zz_decode_SRC2_CTRL_string;
  reg [95:0] decode_SRC1_CTRL_string;
  reg [95:0] _zz_decode_SRC1_CTRL_string;
  reg [63:0] execute_ALU_CTRL_string;
  reg [63:0] _zz_execute_ALU_CTRL_string;
  reg [23:0] execute_ALU_BITWISE_CTRL_string;
  reg [23:0] _zz_execute_ALU_BITWISE_CTRL_string;
  reg [31:0] _zz_decode_BRANCH_CTRL_string;
  reg [55:0] _zz_decode_SHIFT_CTRL_1_string;
  reg [23:0] _zz_decode_ALU_BITWISE_CTRL_1_string;
  reg [47:0] _zz_decode_ENV_CTRL_1_string;
  reg [23:0] _zz_decode_SRC2_CTRL_1_string;
  reg [63:0] _zz_decode_ALU_CTRL_1_string;
  reg [95:0] _zz_decode_SRC1_CTRL_1_string;
  reg [47:0] memory_ENV_CTRL_string;
  reg [47:0] _zz_memory_ENV_CTRL_string;
  reg [47:0] execute_ENV_CTRL_string;
  reg [47:0] _zz_execute_ENV_CTRL_string;
  reg [47:0] writeBack_ENV_CTRL_string;
  reg [47:0] _zz_writeBack_ENV_CTRL_string;
  reg [31:0] decode_BRANCH_CTRL_string;
  reg [31:0] _zz_decode_BRANCH_CTRL_1_string;
  reg [95:0] _zz_decode_SRC1_CTRL_2_string;
  reg [63:0] _zz_decode_ALU_CTRL_2_string;
  reg [23:0] _zz_decode_SRC2_CTRL_2_string;
  reg [47:0] _zz_decode_ENV_CTRL_2_string;
  reg [23:0] _zz_decode_ALU_BITWISE_CTRL_2_string;
  reg [55:0] _zz_decode_SHIFT_CTRL_8_string;
  reg [31:0] _zz_decode_BRANCH_CTRL_2_string;
  reg [63:0] decode_to_execute_ALU_CTRL_string;
  reg [47:0] decode_to_execute_ENV_CTRL_string;
  reg [47:0] execute_to_memory_ENV_CTRL_string;
  reg [47:0] memory_to_writeBack_ENV_CTRL_string;
  reg [23:0] decode_to_execute_ALU_BITWISE_CTRL_string;
  reg [55:0] decode_to_execute_SHIFT_CTRL_string;
  reg [31:0] decode_to_execute_BRANCH_CTRL_string;
  `endif

  reg [31:0] RegFilePlugin_regFile [0:31] /* verilator public */ ;

  assign _zz_VexRiscv_decode_FORMAL_PC_NEXT_1 = (decode_IS_RVC ? 3'b010 : 3'b100);
  assign _zz_VexRiscv_decode_FORMAL_PC_NEXT = {29'd0, _zz_VexRiscv_decode_FORMAL_PC_NEXT_1};
  assign _zz_VexRiscv__zz_IBusSimplePlugin_jump_pcLoad_payload_1 = (_zz_IBusSimplePlugin_jump_pcLoad_payload - 3'b001);
  assign _zz_VexRiscv_IBusSimplePlugin_fetchPc_pc_1 = {IBusSimplePlugin_fetchPc_inc,2'b00};
  assign _zz_VexRiscv_IBusSimplePlugin_fetchPc_pc = {29'd0, _zz_VexRiscv_IBusSimplePlugin_fetchPc_pc_1};
  assign _zz_VexRiscv_IBusSimplePlugin_decodePc_pcPlus_1 = (decode_IS_RVC ? 3'b010 : 3'b100);
  assign _zz_VexRiscv_IBusSimplePlugin_decodePc_pcPlus = {29'd0, _zz_VexRiscv_IBusSimplePlugin_decodePc_pcPlus_1};
  assign _zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed = {{_zz_IBusSimplePlugin_decompressor_decompressed_10,_zz_IBusSimplePlugin_decompressor_decompressed[6 : 2]},12'h0};
  assign _zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed_7 = {{{4'b0000,_zz_IBusSimplePlugin_decompressor_decompressed[8 : 7]},_zz_IBusSimplePlugin_decompressor_decompressed[12 : 9]},2'b00};
  assign _zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed_8 = {{{4'b0000,_zz_IBusSimplePlugin_decompressor_decompressed[8 : 7]},_zz_IBusSimplePlugin_decompressor_decompressed[12 : 9]},2'b00};
  assign _zz_VexRiscv__zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz_VexRiscv_IBusSimplePlugin_decodePrediction_cmd_hadBranch = {{_zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch_1,{{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0};
  assign _zz_VexRiscv__zz_IBusSimplePlugin_predictionJumpInterface_payload = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[19 : 12]},decode_INSTRUCTION[20]},decode_INSTRUCTION[30 : 21]};
  assign _zz_VexRiscv__zz_IBusSimplePlugin_predictionJumpInterface_payload_2 = {{{decode_INSTRUCTION[31],decode_INSTRUCTION[7]},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]};
  assign _zz_VexRiscv_IBusSimplePlugin_pending_next = (IBusSimplePlugin_pending_value + _zz_VexRiscv_IBusSimplePlugin_pending_next_1);
  assign _zz_VexRiscv_IBusSimplePlugin_pending_next_2 = IBusSimplePlugin_pending_inc;
  assign _zz_VexRiscv_IBusSimplePlugin_pending_next_1 = {2'd0, _zz_VexRiscv_IBusSimplePlugin_pending_next_2};
  assign _zz_VexRiscv_IBusSimplePlugin_pending_next_4 = IBusSimplePlugin_pending_dec;
  assign _zz_VexRiscv_IBusSimplePlugin_pending_next_3 = {2'd0, _zz_VexRiscv_IBusSimplePlugin_pending_next_4};
  assign _zz_VexRiscv_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_1 = (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid && (IBusSimplePlugin_rspJoin_rspBuffer_discardCounter != 3'b000));
  assign _zz_VexRiscv_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter = {2'd0, _zz_VexRiscv_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_1};
  assign _zz_VexRiscv_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_3 = IBusSimplePlugin_pending_dec;
  assign _zz_VexRiscv_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_2 = {2'd0, _zz_VexRiscv_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_3};
  assign _zz_VexRiscv_DBusSimplePlugin_memoryExceptionPort_payload_code = (memory_MEMORY_STORE ? 3'b110 : 3'b100);
  assign _zz_VexRiscv__zz_execute_REGFILE_WRITE_DATA = execute_SRC_LESS;
  assign _zz_VexRiscv__zz_decode_SRC1_1 = (decode_IS_RVC ? 3'b010 : 3'b100);
  assign _zz_VexRiscv__zz_decode_SRC1_1_1 = decode_INSTRUCTION[19 : 15];
  assign _zz_VexRiscv__zz_decode_SRC2_4 = {decode_INSTRUCTION[31 : 25],decode_INSTRUCTION[11 : 7]};
  assign _zz_VexRiscv_execute_SrcPlugin_addSub = ($signed(_zz_VexRiscv_execute_SrcPlugin_addSub_1) + $signed(_zz_VexRiscv_execute_SrcPlugin_addSub_4));
  assign _zz_VexRiscv_execute_SrcPlugin_addSub_1 = ($signed(_zz_VexRiscv_execute_SrcPlugin_addSub_2) + $signed(_zz_VexRiscv_execute_SrcPlugin_addSub_3));
  assign _zz_VexRiscv_execute_SrcPlugin_addSub_2 = execute_SRC1;
  assign _zz_VexRiscv_execute_SrcPlugin_addSub_3 = (execute_SRC_USE_SUB_LESS ? (~ execute_SRC2) : execute_SRC2);
  assign _zz_VexRiscv_execute_SrcPlugin_addSub_4 = (execute_SRC_USE_SUB_LESS ? _zz_VexRiscv_execute_SrcPlugin_addSub_5 : _zz_VexRiscv_execute_SrcPlugin_addSub_6);
  assign _zz_VexRiscv_execute_SrcPlugin_addSub_5 = 32'h00000001;
  assign _zz_VexRiscv_execute_SrcPlugin_addSub_6 = 32'h0;
  assign _zz_VexRiscv__zz_decode_RS2_3 = (_zz_VexRiscv__zz_decode_RS2_3_1 >>> 1);
  assign _zz_VexRiscv__zz_decode_RS2_3_1 = {((execute_SHIFT_CTRL == `ShiftCtrlEnum_defaultEncoding_SRA) && execute_LightShifterPlugin_shiftInput[31]),execute_LightShifterPlugin_shiftInput};
  assign _zz_VexRiscv__zz_execute_BranchPlugin_branch_src2_2 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]};
  assign _zz_VexRiscv__zz_execute_BranchPlugin_branch_src2_4 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz_VexRiscv_execute_BranchPlugin_branch_src2_3 = (execute_IS_RVC ? 3'b010 : 3'b100);
  assign _zz_VexRiscv_decode_RegFilePlugin_rs1Data = 1'b1;
  assign _zz_VexRiscv_decode_RegFilePlugin_rs2Data = 1'b1;
  assign _zz_VexRiscv_IBusSimplePlugin_jump_pcLoad_payload_1 = {_zz_IBusSimplePlugin_jump_pcLoad_payload_3,_zz_IBusSimplePlugin_jump_pcLoad_payload_2};
  assign _zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed_1 = (_zz_IBusSimplePlugin_decompressor_decompressed[11 : 10] == 2'b01);
  assign _zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed_2 = ((_zz_IBusSimplePlugin_decompressor_decompressed[11 : 10] == 2'b11) && (_zz_IBusSimplePlugin_decompressor_decompressed[6 : 5] == 2'b00));
  assign _zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed_3 = 7'h0;
  assign _zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed_4 = _zz_IBusSimplePlugin_decompressor_decompressed[6 : 2];
  assign _zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed_5 = _zz_IBusSimplePlugin_decompressor_decompressed[12];
  assign _zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed_6 = _zz_IBusSimplePlugin_decompressor_decompressed[11 : 7];
  assign _zz_VexRiscv_IBusSimplePlugin_predictionJumpInterface_payload = decode_INSTRUCTION[31];
  assign _zz_VexRiscv_IBusSimplePlugin_predictionJumpInterface_payload_1 = decode_INSTRUCTION[19 : 12];
  assign _zz_VexRiscv_IBusSimplePlugin_predictionJumpInterface_payload_2 = decode_INSTRUCTION[20];
  assign _zz_VexRiscv_IBusSimplePlugin_predictionJumpInterface_payload_3 = decode_INSTRUCTION[31];
  assign _zz_VexRiscv_IBusSimplePlugin_predictionJumpInterface_payload_4 = decode_INSTRUCTION[7];
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2 = (decode_INSTRUCTION & 32'h0000001c);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_1 = 32'h00000004;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_2 = (decode_INSTRUCTION & 32'h00000058);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_3 = 32'h00000040;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_4 = ((decode_INSTRUCTION & 32'h00007054) == 32'h00005010);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_5 = {(_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_6 == _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_7),(_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_8 == _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_9)};
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_10 = 2'b00;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_11 = ({_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_12,_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_13} != 2'b00);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_14 = (_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_15 != 1'b0);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_16 = {(_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_17 != _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_19),{_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_20,{_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_23,_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_24}}};
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_6 = (decode_INSTRUCTION & 32'h40003054);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_7 = 32'h40001010;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_8 = (decode_INSTRUCTION & 32'h00007054);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_9 = 32'h00001010;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_12 = ((decode_INSTRUCTION & 32'h00000064) == 32'h00000024);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_13 = ((decode_INSTRUCTION & 32'h00003054) == 32'h00001010);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_15 = ((decode_INSTRUCTION & 32'h00001000) == 32'h00001000);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_17 = ((decode_INSTRUCTION & _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_18) == 32'h00002000);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_19 = 1'b0;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_20 = ({_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_21,_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_22} != 2'b00);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_23 = (_zz_decode_SHIFT_CTRL_7 != 1'b0);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_24 = {(_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_25 != _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_26),{_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_27,{_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_29,_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_32}}};
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_18 = 32'h00003000;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_21 = ((decode_INSTRUCTION & 32'h00002010) == 32'h00002000);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_22 = ((decode_INSTRUCTION & 32'h00005000) == 32'h00001000);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_25 = _zz_decode_SHIFT_CTRL_7;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_26 = 1'b0;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_27 = (((decode_INSTRUCTION & _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_28) == 32'h00000050) != 1'b0);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_29 = ({_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_30,_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_31} != 2'b00);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_32 = {({_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_33,_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_35} != 2'b00),{(_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_37 != _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_42),{_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_43,{_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_46,_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_48}}}};
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_28 = 32'h00103050;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_30 = ((decode_INSTRUCTION & 32'h00001050) == 32'h00001050);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_31 = ((decode_INSTRUCTION & 32'h00002050) == 32'h00002050);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_33 = ((decode_INSTRUCTION & _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_34) == 32'h00000020);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_35 = ((decode_INSTRUCTION & _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_36) == 32'h00000020);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_37 = {(_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_38 == _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_39),(_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_40 == _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_41)};
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_42 = 2'b00;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_43 = ((_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_44 == _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_45) != 1'b0);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_46 = (_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_47 != 1'b0);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_48 = {(_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_49 != _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_50),{_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_51,{_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_64,_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_67}}};
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_34 = 32'h00000034;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_36 = 32'h00000064;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_38 = (decode_INSTRUCTION & 32'h00000040);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_39 = 32'h00000040;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_40 = (decode_INSTRUCTION & 32'h00000038);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_41 = 32'h0;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_44 = (decode_INSTRUCTION & 32'h00000020);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_45 = 32'h00000020;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_47 = ((decode_INSTRUCTION & 32'h00000010) == 32'h00000010);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_49 = _zz_decode_SHIFT_CTRL_5;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_50 = 1'b0;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_51 = ({_zz_decode_SHIFT_CTRL_6,{_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_52,{_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_54,_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_57}}} != 6'h0);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_64 = ({_zz_decode_SHIFT_CTRL_4,_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_65} != 2'b00);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_67 = {({_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_68,_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_69} != 2'b00),{(_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_72 != _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_77),{_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_78,{_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_81,_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_92}}}};
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_52 = ((decode_INSTRUCTION & _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_53) == 32'h00001010);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_54 = (_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_55 == _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_56);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_57 = {_zz_decode_SHIFT_CTRL_5,{_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_58,_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_61}};
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_65 = ((decode_INSTRUCTION & _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_66) == 32'h00000020);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_68 = _zz_decode_SHIFT_CTRL_4;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_69 = (_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_70 == _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_71);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_72 = {_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_73,_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_75};
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_77 = 2'b00;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_78 = (_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_79 != 1'b0);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_81 = (_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_82 != _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_91);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_92 = {_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_93,{_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_95,_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_102}};
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_53 = 32'h00001010;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_55 = (decode_INSTRUCTION & 32'h00002010);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_56 = 32'h00002010;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_58 = (_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_59 == _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_60);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_61 = (_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_62 == _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_63);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_66 = 32'h00000070;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_70 = (decode_INSTRUCTION & 32'h00000020);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_71 = 32'h0;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_73 = ((decode_INSTRUCTION & _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_74) == 32'h00006010);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_75 = ((decode_INSTRUCTION & _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_76) == 32'h00004010);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_79 = ((decode_INSTRUCTION & _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_80) == 32'h00002010);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_82 = {_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_83,{_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_84,_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_86}};
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_91 = 4'b0000;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_93 = (_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_94 != 1'b0);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_95 = (_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_96 != _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_101);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_102 = {_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_103,_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_105};
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_59 = (decode_INSTRUCTION & 32'h0000000c);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_60 = 32'h00000004;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_62 = (decode_INSTRUCTION & 32'h00000028);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_63 = 32'h0;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_74 = 32'h00006014;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_76 = 32'h00005014;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_80 = 32'h00006014;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_83 = ((decode_INSTRUCTION & 32'h00000044) == 32'h0);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_84 = ((decode_INSTRUCTION & _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_85) == 32'h0);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_86 = {(_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_87 == _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_88),(_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_89 == _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_90)};
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_94 = ((decode_INSTRUCTION & 32'h00000058) == 32'h0);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_96 = {(_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_97 == _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_98),{_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_99,_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_100}};
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_101 = 3'b000;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_103 = ({_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_104,_zz_decode_SHIFT_CTRL_3} != 2'b00);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_105 = ({_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_106,_zz_decode_SHIFT_CTRL_3} != 2'b00);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_85 = 32'h00000018;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_87 = (decode_INSTRUCTION & 32'h00006004);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_88 = 32'h00002000;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_89 = (decode_INSTRUCTION & 32'h00005004);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_90 = 32'h00001000;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_97 = (decode_INSTRUCTION & 32'h00000044);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_98 = 32'h00000040;
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_99 = ((decode_INSTRUCTION & 32'h00002014) == 32'h00002010);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_100 = ((decode_INSTRUCTION & 32'h40004034) == 32'h40000030);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_104 = ((decode_INSTRUCTION & 32'h00000014) == 32'h00000004);
  assign _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_106 = ((decode_INSTRUCTION & 32'h00000044) == 32'h00000004);
  assign _zz_VexRiscv_execute_BranchPlugin_branch_src2 = execute_INSTRUCTION[31];
  assign _zz_VexRiscv_execute_BranchPlugin_branch_src2_1 = execute_INSTRUCTION[31];
  assign _zz_VexRiscv_execute_BranchPlugin_branch_src2_2 = execute_INSTRUCTION[7];
  always @(posedge clk) begin
    if(_zz_VexRiscv_decode_RegFilePlugin_rs1Data) begin
      _zz_VexRiscv_RegFilePlugin_regFile_port0 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress1];
    end
  end

  always @(posedge clk) begin
    if(_zz_VexRiscv_decode_RegFilePlugin_rs2Data) begin
      _zz_VexRiscv_RegFilePlugin_regFile_port1 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress2];
    end
  end

  always @(posedge clk) begin
    if(_zz_VexRiscv_1) begin
      RegFilePlugin_regFile[lastStageRegFileWrite_payload_address] <= lastStageRegFileWrite_payload_data;
    end
  end

  StreamFifoLowLatency IBusSimplePlugin_rspJoin_rspBuffer_c (
    .io_push_valid            (iBus_rsp_valid                                             ), //i
    .io_push_ready            (IBusSimplePlugin_rspJoin_rspBuffer_c_io_push_ready         ), //o
    .io_push_payload_error    (iBus_rsp_payload_error                                     ), //i
    .io_push_payload_inst     (iBus_rsp_payload_inst                                      ), //i
    .io_pop_valid             (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid          ), //o
    .io_pop_ready             (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_ready          ), //i
    .io_pop_payload_error     (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_error  ), //o
    .io_pop_payload_inst      (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_inst   ), //o
    .io_flush                 (1'b0                                                       ), //i
    .io_occupancy             (IBusSimplePlugin_rspJoin_rspBuffer_c_io_occupancy          ), //o
    .clk                      (clk                                                        ), //i
    .reset                    (reset                                                      )  //i
  );
  always @(*) begin
    case(_zz_VexRiscv_IBusSimplePlugin_jump_pcLoad_payload_1)
      2'b00 : begin
        _zz_VexRiscv_IBusSimplePlugin_jump_pcLoad_payload = CsrPlugin_jumpInterface_payload;
      end
      2'b01 : begin
        _zz_VexRiscv_IBusSimplePlugin_jump_pcLoad_payload = BranchPlugin_jumpInterface_payload;
      end
      default : begin
        _zz_VexRiscv_IBusSimplePlugin_jump_pcLoad_payload = IBusSimplePlugin_predictionJumpInterface_payload;
      end
    endcase
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(_zz_decode_to_execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_decode_to_execute_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_decode_to_execute_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_decode_to_execute_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_decode_to_execute_BRANCH_CTRL_string = "JALR";
      default : _zz_decode_to_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_BRANCH_CTRL_1)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_decode_to_execute_BRANCH_CTRL_1_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_decode_to_execute_BRANCH_CTRL_1_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_decode_to_execute_BRANCH_CTRL_1_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_decode_to_execute_BRANCH_CTRL_1_string = "JALR";
      default : _zz_decode_to_execute_BRANCH_CTRL_1_string = "????";
    endcase
  end
  always @(*) begin
    case(decode_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_DISABLE : decode_SHIFT_CTRL_string = "DISABLE";
      `ShiftCtrlEnum_defaultEncoding_SLL : decode_SHIFT_CTRL_string = "SLL    ";
      `ShiftCtrlEnum_defaultEncoding_SRL : decode_SHIFT_CTRL_string = "SRL    ";
      `ShiftCtrlEnum_defaultEncoding_SRA : decode_SHIFT_CTRL_string = "SRA    ";
      default : decode_SHIFT_CTRL_string = "???????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_DISABLE : _zz_decode_SHIFT_CTRL_string = "DISABLE";
      `ShiftCtrlEnum_defaultEncoding_SLL : _zz_decode_SHIFT_CTRL_string = "SLL    ";
      `ShiftCtrlEnum_defaultEncoding_SRL : _zz_decode_SHIFT_CTRL_string = "SRL    ";
      `ShiftCtrlEnum_defaultEncoding_SRA : _zz_decode_SHIFT_CTRL_string = "SRA    ";
      default : _zz_decode_SHIFT_CTRL_string = "???????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_DISABLE : _zz_decode_to_execute_SHIFT_CTRL_string = "DISABLE";
      `ShiftCtrlEnum_defaultEncoding_SLL : _zz_decode_to_execute_SHIFT_CTRL_string = "SLL    ";
      `ShiftCtrlEnum_defaultEncoding_SRL : _zz_decode_to_execute_SHIFT_CTRL_string = "SRL    ";
      `ShiftCtrlEnum_defaultEncoding_SRA : _zz_decode_to_execute_SHIFT_CTRL_string = "SRA    ";
      default : _zz_decode_to_execute_SHIFT_CTRL_string = "???????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_SHIFT_CTRL_1)
      `ShiftCtrlEnum_defaultEncoding_DISABLE : _zz_decode_to_execute_SHIFT_CTRL_1_string = "DISABLE";
      `ShiftCtrlEnum_defaultEncoding_SLL : _zz_decode_to_execute_SHIFT_CTRL_1_string = "SLL    ";
      `ShiftCtrlEnum_defaultEncoding_SRL : _zz_decode_to_execute_SHIFT_CTRL_1_string = "SRL    ";
      `ShiftCtrlEnum_defaultEncoding_SRA : _zz_decode_to_execute_SHIFT_CTRL_1_string = "SRA    ";
      default : _zz_decode_to_execute_SHIFT_CTRL_1_string = "???????";
    endcase
  end
  always @(*) begin
    case(decode_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR : decode_ALU_BITWISE_CTRL_string = "XOR";
      `AluBitwiseCtrlEnum_defaultEncoding_OR : decode_ALU_BITWISE_CTRL_string = "OR ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND : decode_ALU_BITWISE_CTRL_string = "AND";
      default : decode_ALU_BITWISE_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR : _zz_decode_ALU_BITWISE_CTRL_string = "XOR";
      `AluBitwiseCtrlEnum_defaultEncoding_OR : _zz_decode_ALU_BITWISE_CTRL_string = "OR ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND : _zz_decode_ALU_BITWISE_CTRL_string = "AND";
      default : _zz_decode_ALU_BITWISE_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "XOR";
      `AluBitwiseCtrlEnum_defaultEncoding_OR : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "OR ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "AND";
      default : _zz_decode_to_execute_ALU_BITWISE_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_BITWISE_CTRL_1)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "XOR";
      `AluBitwiseCtrlEnum_defaultEncoding_OR : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "OR ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "AND";
      default : _zz_decode_to_execute_ALU_BITWISE_CTRL_1_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_memory_to_writeBack_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_memory_to_writeBack_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_memory_to_writeBack_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_memory_to_writeBack_ENV_CTRL_string = "EBREAK";
      default : _zz_memory_to_writeBack_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_to_writeBack_ENV_CTRL_1)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_memory_to_writeBack_ENV_CTRL_1_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_memory_to_writeBack_ENV_CTRL_1_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_memory_to_writeBack_ENV_CTRL_1_string = "EBREAK";
      default : _zz_memory_to_writeBack_ENV_CTRL_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_execute_to_memory_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_execute_to_memory_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_execute_to_memory_ENV_CTRL_string = "EBREAK";
      default : _zz_execute_to_memory_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_to_memory_ENV_CTRL_1)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_execute_to_memory_ENV_CTRL_1_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_execute_to_memory_ENV_CTRL_1_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_execute_to_memory_ENV_CTRL_1_string = "EBREAK";
      default : _zz_execute_to_memory_ENV_CTRL_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(decode_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : decode_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : decode_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : decode_ENV_CTRL_string = "EBREAK";
      default : decode_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_decode_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_decode_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_decode_ENV_CTRL_string = "EBREAK";
      default : _zz_decode_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_decode_to_execute_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_decode_to_execute_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_decode_to_execute_ENV_CTRL_string = "EBREAK";
      default : _zz_decode_to_execute_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ENV_CTRL_1)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_decode_to_execute_ENV_CTRL_1_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_decode_to_execute_ENV_CTRL_1_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_decode_to_execute_ENV_CTRL_1_string = "EBREAK";
      default : _zz_decode_to_execute_ENV_CTRL_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(decode_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : decode_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : decode_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : decode_ALU_CTRL_string = "BITWISE ";
      default : decode_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_decode_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_decode_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_decode_ALU_CTRL_string = "BITWISE ";
      default : _zz_decode_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_decode_to_execute_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_decode_to_execute_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_decode_to_execute_ALU_CTRL_string = "BITWISE ";
      default : _zz_decode_to_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_to_execute_ALU_CTRL_1)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_decode_to_execute_ALU_CTRL_1_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_decode_to_execute_ALU_CTRL_1_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_decode_to_execute_ALU_CTRL_1_string = "BITWISE ";
      default : _zz_decode_to_execute_ALU_CTRL_1_string = "????????";
    endcase
  end
  always @(*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : execute_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : execute_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : execute_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : execute_BRANCH_CTRL_string = "JALR";
      default : execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_execute_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_execute_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_execute_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_execute_BRANCH_CTRL_string = "JALR";
      default : _zz_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(execute_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_DISABLE : execute_SHIFT_CTRL_string = "DISABLE";
      `ShiftCtrlEnum_defaultEncoding_SLL : execute_SHIFT_CTRL_string = "SLL    ";
      `ShiftCtrlEnum_defaultEncoding_SRL : execute_SHIFT_CTRL_string = "SRL    ";
      `ShiftCtrlEnum_defaultEncoding_SRA : execute_SHIFT_CTRL_string = "SRA    ";
      default : execute_SHIFT_CTRL_string = "???????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_DISABLE : _zz_execute_SHIFT_CTRL_string = "DISABLE";
      `ShiftCtrlEnum_defaultEncoding_SLL : _zz_execute_SHIFT_CTRL_string = "SLL    ";
      `ShiftCtrlEnum_defaultEncoding_SRL : _zz_execute_SHIFT_CTRL_string = "SRL    ";
      `ShiftCtrlEnum_defaultEncoding_SRA : _zz_execute_SHIFT_CTRL_string = "SRA    ";
      default : _zz_execute_SHIFT_CTRL_string = "???????";
    endcase
  end
  always @(*) begin
    case(decode_SRC2_CTRL)
      `Src2CtrlEnum_defaultEncoding_RS : decode_SRC2_CTRL_string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : decode_SRC2_CTRL_string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : decode_SRC2_CTRL_string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : decode_SRC2_CTRL_string = "PC ";
      default : decode_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC2_CTRL)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_decode_SRC2_CTRL_string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_decode_SRC2_CTRL_string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_decode_SRC2_CTRL_string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_decode_SRC2_CTRL_string = "PC ";
      default : _zz_decode_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_SRC1_CTRL)
      `Src1CtrlEnum_defaultEncoding_RS : decode_SRC1_CTRL_string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : decode_SRC1_CTRL_string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : decode_SRC1_CTRL_string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : decode_SRC1_CTRL_string = "URS1        ";
      default : decode_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC1_CTRL)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_decode_SRC1_CTRL_string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_decode_SRC1_CTRL_string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_decode_SRC1_CTRL_string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_decode_SRC1_CTRL_string = "URS1        ";
      default : _zz_decode_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(execute_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : execute_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : execute_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : execute_ALU_CTRL_string = "BITWISE ";
      default : execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_execute_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_execute_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_execute_ALU_CTRL_string = "BITWISE ";
      default : _zz_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR : execute_ALU_BITWISE_CTRL_string = "XOR";
      `AluBitwiseCtrlEnum_defaultEncoding_OR : execute_ALU_BITWISE_CTRL_string = "OR ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND : execute_ALU_BITWISE_CTRL_string = "AND";
      default : execute_ALU_BITWISE_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR : _zz_execute_ALU_BITWISE_CTRL_string = "XOR";
      `AluBitwiseCtrlEnum_defaultEncoding_OR : _zz_execute_ALU_BITWISE_CTRL_string = "OR ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND : _zz_execute_ALU_BITWISE_CTRL_string = "AND";
      default : _zz_execute_ALU_BITWISE_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_decode_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_decode_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_decode_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_decode_BRANCH_CTRL_string = "JALR";
      default : _zz_decode_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SHIFT_CTRL_1)
      `ShiftCtrlEnum_defaultEncoding_DISABLE : _zz_decode_SHIFT_CTRL_1_string = "DISABLE";
      `ShiftCtrlEnum_defaultEncoding_SLL : _zz_decode_SHIFT_CTRL_1_string = "SLL    ";
      `ShiftCtrlEnum_defaultEncoding_SRL : _zz_decode_SHIFT_CTRL_1_string = "SRL    ";
      `ShiftCtrlEnum_defaultEncoding_SRA : _zz_decode_SHIFT_CTRL_1_string = "SRA    ";
      default : _zz_decode_SHIFT_CTRL_1_string = "???????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_BITWISE_CTRL_1)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR : _zz_decode_ALU_BITWISE_CTRL_1_string = "XOR";
      `AluBitwiseCtrlEnum_defaultEncoding_OR : _zz_decode_ALU_BITWISE_CTRL_1_string = "OR ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND : _zz_decode_ALU_BITWISE_CTRL_1_string = "AND";
      default : _zz_decode_ALU_BITWISE_CTRL_1_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ENV_CTRL_1)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_decode_ENV_CTRL_1_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_decode_ENV_CTRL_1_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_decode_ENV_CTRL_1_string = "EBREAK";
      default : _zz_decode_ENV_CTRL_1_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC2_CTRL_1)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_decode_SRC2_CTRL_1_string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_decode_SRC2_CTRL_1_string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_decode_SRC2_CTRL_1_string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_decode_SRC2_CTRL_1_string = "PC ";
      default : _zz_decode_SRC2_CTRL_1_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_CTRL_1)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_decode_ALU_CTRL_1_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_decode_ALU_CTRL_1_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_decode_ALU_CTRL_1_string = "BITWISE ";
      default : _zz_decode_ALU_CTRL_1_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC1_CTRL_1)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_decode_SRC1_CTRL_1_string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_decode_SRC1_CTRL_1_string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_decode_SRC1_CTRL_1_string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_decode_SRC1_CTRL_1_string = "URS1        ";
      default : _zz_decode_SRC1_CTRL_1_string = "????????????";
    endcase
  end
  always @(*) begin
    case(memory_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : memory_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : memory_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : memory_ENV_CTRL_string = "EBREAK";
      default : memory_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_memory_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_memory_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_memory_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_memory_ENV_CTRL_string = "EBREAK";
      default : _zz_memory_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(execute_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : execute_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : execute_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : execute_ENV_CTRL_string = "EBREAK";
      default : execute_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_execute_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_execute_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_execute_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_execute_ENV_CTRL_string = "EBREAK";
      default : _zz_execute_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(writeBack_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : writeBack_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : writeBack_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : writeBack_ENV_CTRL_string = "EBREAK";
      default : writeBack_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_writeBack_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_writeBack_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_writeBack_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_writeBack_ENV_CTRL_string = "EBREAK";
      default : _zz_writeBack_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(decode_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : decode_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : decode_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : decode_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : decode_BRANCH_CTRL_string = "JALR";
      default : decode_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_BRANCH_CTRL_1)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_decode_BRANCH_CTRL_1_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_decode_BRANCH_CTRL_1_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_decode_BRANCH_CTRL_1_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_decode_BRANCH_CTRL_1_string = "JALR";
      default : _zz_decode_BRANCH_CTRL_1_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC1_CTRL_2)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_decode_SRC1_CTRL_2_string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_decode_SRC1_CTRL_2_string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_decode_SRC1_CTRL_2_string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_decode_SRC1_CTRL_2_string = "URS1        ";
      default : _zz_decode_SRC1_CTRL_2_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_CTRL_2)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_decode_ALU_CTRL_2_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_decode_ALU_CTRL_2_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_decode_ALU_CTRL_2_string = "BITWISE ";
      default : _zz_decode_ALU_CTRL_2_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SRC2_CTRL_2)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_decode_SRC2_CTRL_2_string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_decode_SRC2_CTRL_2_string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_decode_SRC2_CTRL_2_string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_decode_SRC2_CTRL_2_string = "PC ";
      default : _zz_decode_SRC2_CTRL_2_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ENV_CTRL_2)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_decode_ENV_CTRL_2_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_decode_ENV_CTRL_2_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : _zz_decode_ENV_CTRL_2_string = "EBREAK";
      default : _zz_decode_ENV_CTRL_2_string = "??????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_ALU_BITWISE_CTRL_2)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR : _zz_decode_ALU_BITWISE_CTRL_2_string = "XOR";
      `AluBitwiseCtrlEnum_defaultEncoding_OR : _zz_decode_ALU_BITWISE_CTRL_2_string = "OR ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND : _zz_decode_ALU_BITWISE_CTRL_2_string = "AND";
      default : _zz_decode_ALU_BITWISE_CTRL_2_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_decode_SHIFT_CTRL_8)
      `ShiftCtrlEnum_defaultEncoding_DISABLE : _zz_decode_SHIFT_CTRL_8_string = "DISABLE";
      `ShiftCtrlEnum_defaultEncoding_SLL : _zz_decode_SHIFT_CTRL_8_string = "SLL    ";
      `ShiftCtrlEnum_defaultEncoding_SRL : _zz_decode_SHIFT_CTRL_8_string = "SRL    ";
      `ShiftCtrlEnum_defaultEncoding_SRA : _zz_decode_SHIFT_CTRL_8_string = "SRA    ";
      default : _zz_decode_SHIFT_CTRL_8_string = "???????";
    endcase
  end
  always @(*) begin
    case(_zz_decode_BRANCH_CTRL_2)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_decode_BRANCH_CTRL_2_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_decode_BRANCH_CTRL_2_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_decode_BRANCH_CTRL_2_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_decode_BRANCH_CTRL_2_string = "JALR";
      default : _zz_decode_BRANCH_CTRL_2_string = "????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : decode_to_execute_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : decode_to_execute_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : decode_to_execute_ALU_CTRL_string = "BITWISE ";
      default : decode_to_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : decode_to_execute_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : decode_to_execute_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : decode_to_execute_ENV_CTRL_string = "EBREAK";
      default : decode_to_execute_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(execute_to_memory_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : execute_to_memory_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : execute_to_memory_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : execute_to_memory_ENV_CTRL_string = "EBREAK";
      default : execute_to_memory_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(memory_to_writeBack_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : memory_to_writeBack_ENV_CTRL_string = "NONE  ";
      `EnvCtrlEnum_defaultEncoding_XRET : memory_to_writeBack_ENV_CTRL_string = "XRET  ";
      `EnvCtrlEnum_defaultEncoding_EBREAK : memory_to_writeBack_ENV_CTRL_string = "EBREAK";
      default : memory_to_writeBack_ENV_CTRL_string = "??????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR : decode_to_execute_ALU_BITWISE_CTRL_string = "XOR";
      `AluBitwiseCtrlEnum_defaultEncoding_OR : decode_to_execute_ALU_BITWISE_CTRL_string = "OR ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND : decode_to_execute_ALU_BITWISE_CTRL_string = "AND";
      default : decode_to_execute_ALU_BITWISE_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_DISABLE : decode_to_execute_SHIFT_CTRL_string = "DISABLE";
      `ShiftCtrlEnum_defaultEncoding_SLL : decode_to_execute_SHIFT_CTRL_string = "SLL    ";
      `ShiftCtrlEnum_defaultEncoding_SRL : decode_to_execute_SHIFT_CTRL_string = "SRL    ";
      `ShiftCtrlEnum_defaultEncoding_SRA : decode_to_execute_SHIFT_CTRL_string = "SRA    ";
      default : decode_to_execute_SHIFT_CTRL_string = "???????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : decode_to_execute_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : decode_to_execute_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : decode_to_execute_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : decode_to_execute_BRANCH_CTRL_string = "JALR";
      default : decode_to_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  `endif

  assign memory_MEMORY_READ_DATA = dBus_rsp_data;
  assign execute_BRANCH_CALC = {execute_BranchPlugin_branchAdder[31 : 1],1'b0};
  assign execute_BRANCH_DO = ((execute_PREDICTION_HAD_BRANCHED2 != execute_BRANCH_COND_RESULT) || execute_BranchPlugin_missAlignedTarget);
  assign writeBack_REGFILE_WRITE_DATA = memory_to_writeBack_REGFILE_WRITE_DATA;
  assign execute_REGFILE_WRITE_DATA = _zz_execute_REGFILE_WRITE_DATA;
  assign memory_MEMORY_ADDRESS_LOW = execute_to_memory_MEMORY_ADDRESS_LOW;
  assign execute_MEMORY_ADDRESS_LOW = dBus_cmd_payload_address[1 : 0];
  assign decode_DO_EBREAK = (((! DebugPlugin_haltIt) && (decode_IS_EBREAK || 1'b0)) && DebugPlugin_allowEBreak);
  assign decode_PREDICTION_HAD_BRANCHED2 = IBusSimplePlugin_decodePrediction_cmd_hadBranch;
  assign decode_SRC2 = _zz_decode_SRC2_6;
  assign decode_SRC1 = _zz_decode_SRC1_1;
  assign decode_SRC2_FORCE_ZERO = (decode_SRC_ADD_ZERO && (! decode_SRC_USE_SUB_LESS));
  assign _zz_decode_to_execute_BRANCH_CTRL = _zz_decode_to_execute_BRANCH_CTRL_1;
  assign decode_SHIFT_CTRL = _zz_decode_SHIFT_CTRL;
  assign _zz_decode_to_execute_SHIFT_CTRL = _zz_decode_to_execute_SHIFT_CTRL_1;
  assign decode_ALU_BITWISE_CTRL = _zz_decode_ALU_BITWISE_CTRL;
  assign _zz_decode_to_execute_ALU_BITWISE_CTRL = _zz_decode_to_execute_ALU_BITWISE_CTRL_1;
  assign decode_SRC_LESS_UNSIGNED = _zz_decode_SHIFT_CTRL_2[19];
  assign _zz_memory_to_writeBack_ENV_CTRL = _zz_memory_to_writeBack_ENV_CTRL_1;
  assign _zz_execute_to_memory_ENV_CTRL = _zz_execute_to_memory_ENV_CTRL_1;
  assign decode_ENV_CTRL = _zz_decode_ENV_CTRL;
  assign _zz_decode_to_execute_ENV_CTRL = _zz_decode_to_execute_ENV_CTRL_1;
  assign decode_IS_CSR = _zz_decode_SHIFT_CTRL_2[15];
  assign decode_MEMORY_STORE = _zz_decode_SHIFT_CTRL_2[12];
  assign execute_BYPASSABLE_MEMORY_STAGE = decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  assign decode_BYPASSABLE_MEMORY_STAGE = _zz_decode_SHIFT_CTRL_2[11];
  assign decode_BYPASSABLE_EXECUTE_STAGE = _zz_decode_SHIFT_CTRL_2[10];
  assign decode_ALU_CTRL = _zz_decode_ALU_CTRL;
  assign _zz_decode_to_execute_ALU_CTRL = _zz_decode_to_execute_ALU_CTRL_1;
  assign decode_MEMORY_ENABLE = _zz_decode_SHIFT_CTRL_2[3];
  assign decode_CSR_READ_OPCODE = (decode_INSTRUCTION[13 : 7] != 7'h20);
  assign decode_CSR_WRITE_OPCODE = (! (((decode_INSTRUCTION[14 : 13] == 2'b01) && (decode_INSTRUCTION[19 : 15] == 5'h0)) || ((decode_INSTRUCTION[14 : 13] == 2'b11) && (decode_INSTRUCTION[19 : 15] == 5'h0))));
  assign writeBack_FORMAL_PC_NEXT = memory_to_writeBack_FORMAL_PC_NEXT;
  assign memory_FORMAL_PC_NEXT = execute_to_memory_FORMAL_PC_NEXT;
  assign execute_FORMAL_PC_NEXT = decode_to_execute_FORMAL_PC_NEXT;
  assign decode_FORMAL_PC_NEXT = (decode_PC + _zz_VexRiscv_decode_FORMAL_PC_NEXT);
  assign memory_PC = execute_to_memory_PC;
  assign execute_DO_EBREAK = decode_to_execute_DO_EBREAK;
  assign decode_IS_EBREAK = _zz_decode_SHIFT_CTRL_2[18];
  assign memory_BRANCH_CALC = execute_to_memory_BRANCH_CALC;
  assign memory_BRANCH_DO = execute_to_memory_BRANCH_DO;
  assign execute_IS_RVC = decode_to_execute_IS_RVC;
  assign execute_PC = decode_to_execute_PC;
  assign execute_RS1 = decode_to_execute_RS1;
  assign execute_BRANCH_COND_RESULT = _zz_execute_BRANCH_COND_RESULT_1;
  assign execute_PREDICTION_HAD_BRANCHED2 = decode_to_execute_PREDICTION_HAD_BRANCHED2;
  assign execute_BRANCH_CTRL = _zz_execute_BRANCH_CTRL;
  assign decode_RS2_USE = _zz_decode_SHIFT_CTRL_2[14];
  assign decode_RS1_USE = _zz_decode_SHIFT_CTRL_2[4];
  assign execute_REGFILE_WRITE_VALID = decode_to_execute_REGFILE_WRITE_VALID;
  assign execute_BYPASSABLE_EXECUTE_STAGE = decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  assign _zz_decode_RS2 = memory_REGFILE_WRITE_DATA;
  assign memory_REGFILE_WRITE_VALID = execute_to_memory_REGFILE_WRITE_VALID;
  assign memory_INSTRUCTION = execute_to_memory_INSTRUCTION;
  assign memory_BYPASSABLE_MEMORY_STAGE = execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  assign writeBack_REGFILE_WRITE_VALID = memory_to_writeBack_REGFILE_WRITE_VALID;
  always @(*) begin
    decode_RS2 = decode_RegFilePlugin_rs2Data;
    if(HazardSimplePlugin_writeBackBuffer_valid) begin
      if(HazardSimplePlugin_addr1Match) begin
        decode_RS2 = HazardSimplePlugin_writeBackBuffer_payload_data;
      end
    end
    if(when_HazardSimplePlugin_l45) begin
      if(when_HazardSimplePlugin_l47) begin
        if(when_HazardSimplePlugin_l51) begin
          decode_RS2 = _zz_decode_RS2_2;
        end
      end
    end
    if(when_HazardSimplePlugin_l45_1) begin
      if(memory_BYPASSABLE_MEMORY_STAGE) begin
        if(when_HazardSimplePlugin_l51_1) begin
          decode_RS2 = _zz_decode_RS2;
        end
      end
    end
    if(when_HazardSimplePlugin_l45_2) begin
      if(execute_BYPASSABLE_EXECUTE_STAGE) begin
        if(when_HazardSimplePlugin_l51_2) begin
          decode_RS2 = _zz_decode_RS2_1;
        end
      end
    end
  end

  always @(*) begin
    decode_RS1 = decode_RegFilePlugin_rs1Data;
    if(HazardSimplePlugin_writeBackBuffer_valid) begin
      if(HazardSimplePlugin_addr0Match) begin
        decode_RS1 = HazardSimplePlugin_writeBackBuffer_payload_data;
      end
    end
    if(when_HazardSimplePlugin_l45) begin
      if(when_HazardSimplePlugin_l47) begin
        if(when_HazardSimplePlugin_l48) begin
          decode_RS1 = _zz_decode_RS2_2;
        end
      end
    end
    if(when_HazardSimplePlugin_l45_1) begin
      if(memory_BYPASSABLE_MEMORY_STAGE) begin
        if(when_HazardSimplePlugin_l48_1) begin
          decode_RS1 = _zz_decode_RS2;
        end
      end
    end
    if(when_HazardSimplePlugin_l45_2) begin
      if(execute_BYPASSABLE_EXECUTE_STAGE) begin
        if(when_HazardSimplePlugin_l48_2) begin
          decode_RS1 = _zz_decode_RS2_1;
        end
      end
    end
  end

  assign execute_SHIFT_CTRL = _zz_execute_SHIFT_CTRL;
  assign execute_SRC_LESS_UNSIGNED = decode_to_execute_SRC_LESS_UNSIGNED;
  assign execute_SRC2_FORCE_ZERO = decode_to_execute_SRC2_FORCE_ZERO;
  assign execute_SRC_USE_SUB_LESS = decode_to_execute_SRC_USE_SUB_LESS;
  assign _zz_decode_SRC2 = decode_PC;
  assign _zz_decode_SRC2_1 = decode_RS2;
  assign decode_SRC2_CTRL = _zz_decode_SRC2_CTRL;
  assign _zz_decode_SRC1 = decode_RS1;
  assign decode_SRC1_CTRL = _zz_decode_SRC1_CTRL;
  assign decode_SRC_USE_SUB_LESS = _zz_decode_SHIFT_CTRL_2[2];
  assign decode_SRC_ADD_ZERO = _zz_decode_SHIFT_CTRL_2[22];
  assign execute_SRC_ADD_SUB = execute_SrcPlugin_addSub;
  assign execute_SRC_LESS = execute_SrcPlugin_less;
  assign execute_ALU_CTRL = _zz_execute_ALU_CTRL;
  assign execute_SRC2 = decode_to_execute_SRC2;
  assign execute_ALU_BITWISE_CTRL = _zz_execute_ALU_BITWISE_CTRL;
  assign _zz_lastStageRegFileWrite_payload_address = writeBack_INSTRUCTION;
  assign _zz_lastStageRegFileWrite_valid = writeBack_REGFILE_WRITE_VALID;
  always @(*) begin
    _zz_VexRiscv_1 = 1'b0;
    if(lastStageRegFileWrite_valid) begin
      _zz_VexRiscv_1 = 1'b1;
    end
  end

  assign decode_INSTRUCTION_ANTICIPATED = (decode_arbitration_isStuck ? decode_INSTRUCTION : IBusSimplePlugin_decompressor_output_payload_rsp_inst);
  always @(*) begin
    decode_REGFILE_WRITE_VALID = _zz_decode_SHIFT_CTRL_2[9];
    if(when_RegFilePlugin_l63) begin
      decode_REGFILE_WRITE_VALID = 1'b0;
    end
  end

  always @(*) begin
    _zz_decode_RS2_1 = execute_REGFILE_WRITE_DATA;
    if(when_CsrPlugin_l1176) begin
      _zz_decode_RS2_1 = CsrPlugin_csrMapping_readDataSignal;
    end
    if(when_ShiftPlugins_l169) begin
      _zz_decode_RS2_1 = _zz_decode_RS2_3;
    end
  end

  assign execute_SRC1 = decode_to_execute_SRC1;
  assign execute_CSR_READ_OPCODE = decode_to_execute_CSR_READ_OPCODE;
  assign execute_CSR_WRITE_OPCODE = decode_to_execute_CSR_WRITE_OPCODE;
  assign execute_IS_CSR = decode_to_execute_IS_CSR;
  assign memory_ENV_CTRL = _zz_memory_ENV_CTRL;
  assign execute_ENV_CTRL = _zz_execute_ENV_CTRL;
  assign writeBack_ENV_CTRL = _zz_writeBack_ENV_CTRL;
  assign writeBack_MEMORY_STORE = memory_to_writeBack_MEMORY_STORE;
  always @(*) begin
    _zz_decode_RS2_2 = writeBack_REGFILE_WRITE_DATA;
    if(when_DBusSimplePlugin_l558) begin
      _zz_decode_RS2_2 = writeBack_DBusSimplePlugin_rspFormated;
    end
  end

  assign writeBack_MEMORY_ENABLE = memory_to_writeBack_MEMORY_ENABLE;
  assign writeBack_MEMORY_ADDRESS_LOW = memory_to_writeBack_MEMORY_ADDRESS_LOW;
  assign writeBack_MEMORY_READ_DATA = memory_to_writeBack_MEMORY_READ_DATA;
  assign memory_ALIGNEMENT_FAULT = execute_to_memory_ALIGNEMENT_FAULT;
  assign memory_REGFILE_WRITE_DATA = execute_to_memory_REGFILE_WRITE_DATA;
  assign memory_MEMORY_STORE = execute_to_memory_MEMORY_STORE;
  assign memory_MEMORY_ENABLE = execute_to_memory_MEMORY_ENABLE;
  assign execute_SRC_ADD = execute_SrcPlugin_addSub;
  assign execute_RS2 = decode_to_execute_RS2;
  assign execute_INSTRUCTION = decode_to_execute_INSTRUCTION;
  assign execute_MEMORY_STORE = decode_to_execute_MEMORY_STORE;
  assign execute_MEMORY_ENABLE = decode_to_execute_MEMORY_ENABLE;
  assign execute_ALIGNEMENT_FAULT = (((dBus_cmd_payload_size == 2'b10) && (dBus_cmd_payload_address[1 : 0] != 2'b00)) || ((dBus_cmd_payload_size == 2'b01) && (dBus_cmd_payload_address[0 : 0] != 1'b0)));
  assign decode_BRANCH_CTRL = _zz_decode_BRANCH_CTRL_1;
  always @(*) begin
    _zz_memory_to_writeBack_FORMAL_PC_NEXT = memory_FORMAL_PC_NEXT;
    if(BranchPlugin_jumpInterface_valid) begin
      _zz_memory_to_writeBack_FORMAL_PC_NEXT = BranchPlugin_jumpInterface_payload;
    end
  end

  always @(*) begin
    _zz_decode_to_execute_FORMAL_PC_NEXT = decode_FORMAL_PC_NEXT;
    if(IBusSimplePlugin_predictionJumpInterface_valid) begin
      _zz_decode_to_execute_FORMAL_PC_NEXT = IBusSimplePlugin_predictionJumpInterface_payload;
    end
  end

  assign decode_PC = IBusSimplePlugin_decodePc_pcReg;
  assign decode_INSTRUCTION = IBusSimplePlugin_injector_decodeInput_payload_rsp_inst;
  assign decode_IS_RVC = IBusSimplePlugin_injector_decodeInput_payload_isRvc;
  assign writeBack_PC = memory_to_writeBack_PC;
  assign writeBack_INSTRUCTION = memory_to_writeBack_INSTRUCTION;
  always @(*) begin
    decode_arbitration_haltItself = 1'b0;
    case(switch_Fetcher_l362)
      3'b010 : begin
        decode_arbitration_haltItself = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    decode_arbitration_haltByOther = 1'b0;
    if(CsrPlugin_pipelineLiberator_active) begin
      decode_arbitration_haltByOther = 1'b1;
    end
    if(when_CsrPlugin_l1116) begin
      decode_arbitration_haltByOther = 1'b1;
    end
    if(when_HazardSimplePlugin_l113) begin
      decode_arbitration_haltByOther = 1'b1;
    end
  end

  always @(*) begin
    decode_arbitration_removeIt = 1'b0;
    if(decode_arbitration_isFlushed) begin
      decode_arbitration_removeIt = 1'b1;
    end
  end

  assign decode_arbitration_flushIt = 1'b0;
  always @(*) begin
    decode_arbitration_flushNext = 1'b0;
    if(IBusSimplePlugin_predictionJumpInterface_valid) begin
      decode_arbitration_flushNext = 1'b1;
    end
  end

  always @(*) begin
    execute_arbitration_haltItself = 1'b0;
    if(when_DBusSimplePlugin_l426) begin
      execute_arbitration_haltItself = 1'b1;
    end
    if(when_CsrPlugin_l1180) begin
      if(execute_CsrPlugin_blockedBySideEffects) begin
        execute_arbitration_haltItself = 1'b1;
      end
    end
    if(when_ShiftPlugins_l169) begin
      if(when_ShiftPlugins_l184) begin
        execute_arbitration_haltItself = 1'b1;
      end
    end
  end

  always @(*) begin
    execute_arbitration_haltByOther = 1'b0;
    if(when_DebugPlugin_l284) begin
      execute_arbitration_haltByOther = 1'b1;
    end
  end

  always @(*) begin
    execute_arbitration_removeIt = 1'b0;
    if(CsrPlugin_selfException_valid) begin
      execute_arbitration_removeIt = 1'b1;
    end
    if(execute_arbitration_isFlushed) begin
      execute_arbitration_removeIt = 1'b1;
    end
  end

  always @(*) begin
    execute_arbitration_flushIt = 1'b0;
    if(when_DebugPlugin_l284) begin
      if(when_DebugPlugin_l287) begin
        execute_arbitration_flushIt = 1'b1;
      end
    end
  end

  always @(*) begin
    execute_arbitration_flushNext = 1'b0;
    if(CsrPlugin_selfException_valid) begin
      execute_arbitration_flushNext = 1'b1;
    end
    if(when_DebugPlugin_l284) begin
      if(when_DebugPlugin_l287) begin
        execute_arbitration_flushNext = 1'b1;
      end
    end
    if(_zz_VexRiscv_3) begin
      execute_arbitration_flushNext = 1'b1;
    end
  end

  always @(*) begin
    memory_arbitration_haltItself = 1'b0;
    if(when_DBusSimplePlugin_l479) begin
      memory_arbitration_haltItself = 1'b1;
    end
  end

  assign memory_arbitration_haltByOther = 1'b0;
  always @(*) begin
    memory_arbitration_removeIt = 1'b0;
    if(DBusSimplePlugin_memoryExceptionPort_valid) begin
      memory_arbitration_removeIt = 1'b1;
    end
    if(memory_arbitration_isFlushed) begin
      memory_arbitration_removeIt = 1'b1;
    end
  end

  assign memory_arbitration_flushIt = 1'b0;
  always @(*) begin
    memory_arbitration_flushNext = 1'b0;
    if(DBusSimplePlugin_memoryExceptionPort_valid) begin
      memory_arbitration_flushNext = 1'b1;
    end
    if(BranchPlugin_jumpInterface_valid) begin
      memory_arbitration_flushNext = 1'b1;
    end
  end

  assign writeBack_arbitration_haltItself = 1'b0;
  assign writeBack_arbitration_haltByOther = 1'b0;
  always @(*) begin
    writeBack_arbitration_removeIt = 1'b0;
    if(writeBack_arbitration_isFlushed) begin
      writeBack_arbitration_removeIt = 1'b1;
    end
  end

  assign writeBack_arbitration_flushIt = 1'b0;
  always @(*) begin
    writeBack_arbitration_flushNext = 1'b0;
    if(when_CsrPlugin_l1019) begin
      writeBack_arbitration_flushNext = 1'b1;
    end
    if(when_CsrPlugin_l1064) begin
      writeBack_arbitration_flushNext = 1'b1;
    end
  end

  assign lastStageInstruction = writeBack_INSTRUCTION;
  assign lastStagePc = writeBack_PC;
  assign lastStageIsValid = writeBack_arbitration_isValid;
  assign lastStageIsFiring = writeBack_arbitration_isFiring;
  always @(*) begin
    IBusSimplePlugin_fetcherHalt = 1'b0;
    if(when_CsrPlugin_l922) begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
    if(when_CsrPlugin_l1019) begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
    if(when_CsrPlugin_l1064) begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
    if(when_DebugPlugin_l284) begin
      if(when_DebugPlugin_l287) begin
        IBusSimplePlugin_fetcherHalt = 1'b1;
      end
    end
    if(DebugPlugin_haltIt) begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
    if(when_DebugPlugin_l300) begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
  end

  always @(*) begin
    IBusSimplePlugin_incomingInstruction = 1'b0;
    if(IBusSimplePlugin_iBusRsp_stages_1_input_valid) begin
      IBusSimplePlugin_incomingInstruction = 1'b1;
    end
    if(IBusSimplePlugin_injector_decodeInput_valid) begin
      IBusSimplePlugin_incomingInstruction = 1'b1;
    end
  end

  assign CsrPlugin_csrMapping_allowCsrSignal = 1'b0;
  assign CsrPlugin_csrMapping_readDataSignal = CsrPlugin_csrMapping_readDataInit;
  assign CsrPlugin_inWfi = 1'b0;
  always @(*) begin
    CsrPlugin_thirdPartyWake = 1'b0;
    if(DebugPlugin_haltIt) begin
      CsrPlugin_thirdPartyWake = 1'b1;
    end
  end

  always @(*) begin
    CsrPlugin_jumpInterface_valid = 1'b0;
    if(when_CsrPlugin_l1019) begin
      CsrPlugin_jumpInterface_valid = 1'b1;
    end
    if(when_CsrPlugin_l1064) begin
      CsrPlugin_jumpInterface_valid = 1'b1;
    end
  end

  always @(*) begin
    CsrPlugin_jumpInterface_payload = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    if(when_CsrPlugin_l1019) begin
      CsrPlugin_jumpInterface_payload = {CsrPlugin_xtvec_base,2'b00};
    end
    if(when_CsrPlugin_l1064) begin
      case(switch_CsrPlugin_l1068)
        2'b11 : begin
          CsrPlugin_jumpInterface_payload = CsrPlugin_mepc;
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    CsrPlugin_forceMachineWire = 1'b0;
    if(DebugPlugin_godmode) begin
      CsrPlugin_forceMachineWire = 1'b1;
    end
  end

  always @(*) begin
    CsrPlugin_allowInterrupts = 1'b1;
    if(when_DebugPlugin_l316) begin
      CsrPlugin_allowInterrupts = 1'b0;
    end
  end

  always @(*) begin
    CsrPlugin_allowException = 1'b1;
    if(DebugPlugin_godmode) begin
      CsrPlugin_allowException = 1'b0;
    end
  end

  always @(*) begin
    CsrPlugin_allowEbreakException = 1'b1;
    if(DebugPlugin_allowEBreak) begin
      CsrPlugin_allowEbreakException = 1'b0;
    end
  end

  assign IBusSimplePlugin_externalFlush = ({writeBack_arbitration_flushNext,{memory_arbitration_flushNext,{execute_arbitration_flushNext,decode_arbitration_flushNext}}} != 4'b0000);
  assign IBusSimplePlugin_jump_pcLoad_valid = ({BranchPlugin_jumpInterface_valid,{CsrPlugin_jumpInterface_valid,IBusSimplePlugin_predictionJumpInterface_valid}} != 3'b000);
  assign _zz_IBusSimplePlugin_jump_pcLoad_payload = {IBusSimplePlugin_predictionJumpInterface_valid,{BranchPlugin_jumpInterface_valid,CsrPlugin_jumpInterface_valid}};
  assign _zz_IBusSimplePlugin_jump_pcLoad_payload_1 = (_zz_IBusSimplePlugin_jump_pcLoad_payload & (~ _zz_VexRiscv__zz_IBusSimplePlugin_jump_pcLoad_payload_1));
  assign _zz_IBusSimplePlugin_jump_pcLoad_payload_2 = _zz_IBusSimplePlugin_jump_pcLoad_payload_1[1];
  assign _zz_IBusSimplePlugin_jump_pcLoad_payload_3 = _zz_IBusSimplePlugin_jump_pcLoad_payload_1[2];
  assign IBusSimplePlugin_jump_pcLoad_payload = _zz_VexRiscv_IBusSimplePlugin_jump_pcLoad_payload;
  always @(*) begin
    IBusSimplePlugin_fetchPc_correction = 1'b0;
    if(IBusSimplePlugin_jump_pcLoad_valid) begin
      IBusSimplePlugin_fetchPc_correction = 1'b1;
    end
  end

  assign when_Fetcher_l127 = (IBusSimplePlugin_fetchPc_output_valid && IBusSimplePlugin_fetchPc_output_ready);
  assign IBusSimplePlugin_fetchPc_corrected = (IBusSimplePlugin_fetchPc_correction || IBusSimplePlugin_fetchPc_correctionReg);
  always @(*) begin
    IBusSimplePlugin_fetchPc_pcRegPropagate = 1'b0;
    if(IBusSimplePlugin_iBusRsp_stages_1_input_ready) begin
      IBusSimplePlugin_fetchPc_pcRegPropagate = 1'b1;
    end
  end

  assign when_Fetcher_l131 = (IBusSimplePlugin_fetchPc_correction || IBusSimplePlugin_fetchPc_pcRegPropagate);
  assign when_Fetcher_l131_1 = (IBusSimplePlugin_fetchPc_output_valid && IBusSimplePlugin_fetchPc_output_ready);
  assign when_Fetcher_l131_2 = ((! IBusSimplePlugin_fetchPc_output_valid) && IBusSimplePlugin_fetchPc_output_ready);
  always @(*) begin
    IBusSimplePlugin_fetchPc_pc = (IBusSimplePlugin_fetchPc_pcReg + _zz_VexRiscv_IBusSimplePlugin_fetchPc_pc);
    if(IBusSimplePlugin_fetchPc_inc) begin
      IBusSimplePlugin_fetchPc_pc[1] = 1'b0;
    end
    if(IBusSimplePlugin_jump_pcLoad_valid) begin
      IBusSimplePlugin_fetchPc_pc = IBusSimplePlugin_jump_pcLoad_payload;
    end
    IBusSimplePlugin_fetchPc_pc[0] = 1'b0;
  end

  always @(*) begin
    IBusSimplePlugin_fetchPc_flushed = 1'b0;
    if(IBusSimplePlugin_jump_pcLoad_valid) begin
      IBusSimplePlugin_fetchPc_flushed = 1'b1;
    end
  end

  assign when_Fetcher_l158 = (IBusSimplePlugin_fetchPc_booted && ((IBusSimplePlugin_fetchPc_output_ready || IBusSimplePlugin_fetchPc_correction) || IBusSimplePlugin_fetchPc_pcRegPropagate));
  assign IBusSimplePlugin_fetchPc_output_valid = ((! IBusSimplePlugin_fetcherHalt) && IBusSimplePlugin_fetchPc_booted);
  assign IBusSimplePlugin_fetchPc_output_payload = IBusSimplePlugin_fetchPc_pc;
  always @(*) begin
    IBusSimplePlugin_decodePc_flushed = 1'b0;
    if(when_Fetcher_l192) begin
      IBusSimplePlugin_decodePc_flushed = 1'b1;
    end
  end

  assign IBusSimplePlugin_decodePc_pcPlus = (IBusSimplePlugin_decodePc_pcReg + _zz_VexRiscv_IBusSimplePlugin_decodePc_pcPlus);
  always @(*) begin
    IBusSimplePlugin_decodePc_injectedDecode = 1'b0;
    if(when_Fetcher_l360) begin
      IBusSimplePlugin_decodePc_injectedDecode = 1'b1;
    end
  end

  assign when_Fetcher_l180 = (decode_arbitration_isFiring && (! IBusSimplePlugin_decodePc_injectedDecode));
  assign when_Fetcher_l192 = (IBusSimplePlugin_jump_pcLoad_valid && ((! decode_arbitration_isStuck) || decode_arbitration_removeIt));
  assign IBusSimplePlugin_iBusRsp_redoFetch = 1'b0;
  assign IBusSimplePlugin_iBusRsp_stages_0_input_valid = IBusSimplePlugin_fetchPc_output_valid;
  assign IBusSimplePlugin_fetchPc_output_ready = IBusSimplePlugin_iBusRsp_stages_0_input_ready;
  assign IBusSimplePlugin_iBusRsp_stages_0_input_payload = IBusSimplePlugin_fetchPc_output_payload;
  always @(*) begin
    IBusSimplePlugin_iBusRsp_stages_0_halt = 1'b0;
    if(when_IBusSimplePlugin_l304) begin
      IBusSimplePlugin_iBusRsp_stages_0_halt = 1'b1;
    end
  end

  assign _zz_IBusSimplePlugin_iBusRsp_stages_0_input_ready = (! IBusSimplePlugin_iBusRsp_stages_0_halt);
  assign IBusSimplePlugin_iBusRsp_stages_0_input_ready = (IBusSimplePlugin_iBusRsp_stages_0_output_ready && _zz_IBusSimplePlugin_iBusRsp_stages_0_input_ready);
  assign IBusSimplePlugin_iBusRsp_stages_0_output_valid = (IBusSimplePlugin_iBusRsp_stages_0_input_valid && _zz_IBusSimplePlugin_iBusRsp_stages_0_input_ready);
  assign IBusSimplePlugin_iBusRsp_stages_0_output_payload = IBusSimplePlugin_iBusRsp_stages_0_input_payload;
  assign IBusSimplePlugin_iBusRsp_stages_1_halt = 1'b0;
  assign _zz_IBusSimplePlugin_iBusRsp_stages_1_input_ready = (! IBusSimplePlugin_iBusRsp_stages_1_halt);
  assign IBusSimplePlugin_iBusRsp_stages_1_input_ready = (IBusSimplePlugin_iBusRsp_stages_1_output_ready && _zz_IBusSimplePlugin_iBusRsp_stages_1_input_ready);
  assign IBusSimplePlugin_iBusRsp_stages_1_output_valid = (IBusSimplePlugin_iBusRsp_stages_1_input_valid && _zz_IBusSimplePlugin_iBusRsp_stages_1_input_ready);
  assign IBusSimplePlugin_iBusRsp_stages_1_output_payload = IBusSimplePlugin_iBusRsp_stages_1_input_payload;
  assign IBusSimplePlugin_iBusRsp_flush = (IBusSimplePlugin_externalFlush || IBusSimplePlugin_iBusRsp_redoFetch);
  assign IBusSimplePlugin_iBusRsp_stages_0_output_ready = _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready;
  assign _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready = ((1'b0 && (! _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready_1)) || IBusSimplePlugin_iBusRsp_stages_1_input_ready);
  assign _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready_1 = _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready_2;
  assign IBusSimplePlugin_iBusRsp_stages_1_input_valid = _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready_1;
  assign IBusSimplePlugin_iBusRsp_stages_1_input_payload = IBusSimplePlugin_fetchPc_pcReg;
  always @(*) begin
    IBusSimplePlugin_iBusRsp_readyForError = 1'b1;
    if(IBusSimplePlugin_injector_decodeInput_valid) begin
      IBusSimplePlugin_iBusRsp_readyForError = 1'b0;
    end
  end

  assign IBusSimplePlugin_decompressor_input_valid = (IBusSimplePlugin_iBusRsp_output_valid && (! IBusSimplePlugin_iBusRsp_redoFetch));
  assign IBusSimplePlugin_decompressor_input_payload_pc = IBusSimplePlugin_iBusRsp_output_payload_pc;
  assign IBusSimplePlugin_decompressor_input_payload_rsp_error = IBusSimplePlugin_iBusRsp_output_payload_rsp_error;
  assign IBusSimplePlugin_decompressor_input_payload_rsp_inst = IBusSimplePlugin_iBusRsp_output_payload_rsp_inst;
  assign IBusSimplePlugin_decompressor_input_payload_isRvc = IBusSimplePlugin_iBusRsp_output_payload_isRvc;
  assign IBusSimplePlugin_iBusRsp_output_ready = IBusSimplePlugin_decompressor_input_ready;
  assign IBusSimplePlugin_decompressor_flushNext = 1'b0;
  assign IBusSimplePlugin_decompressor_consumeCurrent = 1'b0;
  assign IBusSimplePlugin_decompressor_isInputLowRvc = (IBusSimplePlugin_decompressor_input_payload_rsp_inst[1 : 0] != 2'b11);
  assign IBusSimplePlugin_decompressor_isInputHighRvc = (IBusSimplePlugin_decompressor_input_payload_rsp_inst[17 : 16] != 2'b11);
  assign IBusSimplePlugin_decompressor_throw2Bytes = (IBusSimplePlugin_decompressor_throw2BytesReg || IBusSimplePlugin_decompressor_input_payload_pc[1]);
  assign IBusSimplePlugin_decompressor_unaligned = (IBusSimplePlugin_decompressor_throw2Bytes || IBusSimplePlugin_decompressor_bufferValid);
  assign IBusSimplePlugin_decompressor_bufferValidPatched = (IBusSimplePlugin_decompressor_input_valid ? IBusSimplePlugin_decompressor_bufferValid : IBusSimplePlugin_decompressor_bufferValidLatch);
  assign IBusSimplePlugin_decompressor_throw2BytesPatched = (IBusSimplePlugin_decompressor_input_valid ? IBusSimplePlugin_decompressor_throw2Bytes : IBusSimplePlugin_decompressor_throw2BytesLatch);
  assign IBusSimplePlugin_decompressor_raw = (IBusSimplePlugin_decompressor_bufferValidPatched ? {IBusSimplePlugin_decompressor_input_payload_rsp_inst[15 : 0],IBusSimplePlugin_decompressor_bufferData} : {IBusSimplePlugin_decompressor_input_payload_rsp_inst[31 : 16],(IBusSimplePlugin_decompressor_throw2BytesPatched ? IBusSimplePlugin_decompressor_input_payload_rsp_inst[31 : 16] : IBusSimplePlugin_decompressor_input_payload_rsp_inst[15 : 0])});
  assign IBusSimplePlugin_decompressor_isRvc = (IBusSimplePlugin_decompressor_raw[1 : 0] != 2'b11);
  assign _zz_IBusSimplePlugin_decompressor_decompressed = IBusSimplePlugin_decompressor_raw[15 : 0];
  always @(*) begin
    IBusSimplePlugin_decompressor_decompressed = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(switch_Misc_l44)
      5'h0 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{{{{{2'b00,_zz_IBusSimplePlugin_decompressor_decompressed[10 : 7]},_zz_IBusSimplePlugin_decompressor_decompressed[12 : 11]},_zz_IBusSimplePlugin_decompressor_decompressed[5]},_zz_IBusSimplePlugin_decompressor_decompressed[6]},2'b00},5'h02},3'b000},_zz_IBusSimplePlugin_decompressor_decompressed_2},7'h13};
      end
      5'h02 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{_zz_IBusSimplePlugin_decompressor_decompressed_3,_zz_IBusSimplePlugin_decompressor_decompressed_1},3'b010},_zz_IBusSimplePlugin_decompressor_decompressed_2},7'h03};
      end
      5'h06 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{_zz_IBusSimplePlugin_decompressor_decompressed_3[11 : 5],_zz_IBusSimplePlugin_decompressor_decompressed_2},_zz_IBusSimplePlugin_decompressor_decompressed_1},3'b010},_zz_IBusSimplePlugin_decompressor_decompressed_3[4 : 0]},7'h23};
      end
      5'h08 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{_zz_IBusSimplePlugin_decompressor_decompressed_5,_zz_IBusSimplePlugin_decompressor_decompressed[11 : 7]},3'b000},_zz_IBusSimplePlugin_decompressor_decompressed[11 : 7]},7'h13};
      end
      5'h09 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{_zz_IBusSimplePlugin_decompressor_decompressed_8[20],_zz_IBusSimplePlugin_decompressor_decompressed_8[10 : 1]},_zz_IBusSimplePlugin_decompressor_decompressed_8[11]},_zz_IBusSimplePlugin_decompressor_decompressed_8[19 : 12]},_zz_IBusSimplePlugin_decompressor_decompressed_20},7'h6f};
      end
      5'h0a : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{_zz_IBusSimplePlugin_decompressor_decompressed_5,5'h0},3'b000},_zz_IBusSimplePlugin_decompressor_decompressed[11 : 7]},7'h13};
      end
      5'h0b : begin
        IBusSimplePlugin_decompressor_decompressed = ((_zz_IBusSimplePlugin_decompressor_decompressed[11 : 7] == 5'h02) ? {{{{{{{{{_zz_IBusSimplePlugin_decompressor_decompressed_12,_zz_IBusSimplePlugin_decompressor_decompressed[4 : 3]},_zz_IBusSimplePlugin_decompressor_decompressed[5]},_zz_IBusSimplePlugin_decompressor_decompressed[2]},_zz_IBusSimplePlugin_decompressor_decompressed[6]},4'b0000},_zz_IBusSimplePlugin_decompressor_decompressed[11 : 7]},3'b000},_zz_IBusSimplePlugin_decompressor_decompressed[11 : 7]},7'h13} : {{_zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed[31 : 12],_zz_IBusSimplePlugin_decompressor_decompressed[11 : 7]},7'h37});
      end
      5'h0c : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{((_zz_IBusSimplePlugin_decompressor_decompressed[11 : 10] == 2'b10) ? _zz_IBusSimplePlugin_decompressor_decompressed_26 : {{1'b0,(_zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed_1 || _zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed_2)},5'h0}),(((! _zz_IBusSimplePlugin_decompressor_decompressed[11]) || _zz_IBusSimplePlugin_decompressor_decompressed_22) ? _zz_IBusSimplePlugin_decompressor_decompressed[6 : 2] : _zz_IBusSimplePlugin_decompressor_decompressed_2)},_zz_IBusSimplePlugin_decompressor_decompressed_1},_zz_IBusSimplePlugin_decompressor_decompressed_24},_zz_IBusSimplePlugin_decompressor_decompressed_1},(_zz_IBusSimplePlugin_decompressor_decompressed_22 ? 7'h13 : 7'h33)};
      end
      5'h0d : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{_zz_IBusSimplePlugin_decompressor_decompressed_15[20],_zz_IBusSimplePlugin_decompressor_decompressed_15[10 : 1]},_zz_IBusSimplePlugin_decompressor_decompressed_15[11]},_zz_IBusSimplePlugin_decompressor_decompressed_15[19 : 12]},_zz_IBusSimplePlugin_decompressor_decompressed_19},7'h6f};
      end
      5'h0e : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{{{_zz_IBusSimplePlugin_decompressor_decompressed_18[12],_zz_IBusSimplePlugin_decompressor_decompressed_18[10 : 5]},_zz_IBusSimplePlugin_decompressor_decompressed_19},_zz_IBusSimplePlugin_decompressor_decompressed_1},3'b000},_zz_IBusSimplePlugin_decompressor_decompressed_18[4 : 1]},_zz_IBusSimplePlugin_decompressor_decompressed_18[11]},7'h63};
      end
      5'h0f : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{{{_zz_IBusSimplePlugin_decompressor_decompressed_18[12],_zz_IBusSimplePlugin_decompressor_decompressed_18[10 : 5]},_zz_IBusSimplePlugin_decompressor_decompressed_19},_zz_IBusSimplePlugin_decompressor_decompressed_1},3'b001},_zz_IBusSimplePlugin_decompressor_decompressed_18[4 : 1]},_zz_IBusSimplePlugin_decompressor_decompressed_18[11]},7'h63};
      end
      5'h10 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{7'h0,_zz_IBusSimplePlugin_decompressor_decompressed[6 : 2]},_zz_IBusSimplePlugin_decompressor_decompressed[11 : 7]},3'b001},_zz_IBusSimplePlugin_decompressor_decompressed[11 : 7]},7'h13};
      end
      5'h12 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{{{{4'b0000,_zz_IBusSimplePlugin_decompressor_decompressed[3 : 2]},_zz_IBusSimplePlugin_decompressor_decompressed[12]},_zz_IBusSimplePlugin_decompressor_decompressed[6 : 4]},2'b00},_zz_IBusSimplePlugin_decompressor_decompressed_21},3'b010},_zz_IBusSimplePlugin_decompressor_decompressed[11 : 7]},7'h03};
      end
      5'h14 : begin
        IBusSimplePlugin_decompressor_decompressed = ((_zz_IBusSimplePlugin_decompressor_decompressed[12 : 2] == 11'h400) ? 32'h00100073 : ((_zz_IBusSimplePlugin_decompressor_decompressed[6 : 2] == 5'h0) ? {{{{12'h0,_zz_IBusSimplePlugin_decompressor_decompressed[11 : 7]},3'b000},(_zz_IBusSimplePlugin_decompressor_decompressed[12] ? _zz_IBusSimplePlugin_decompressor_decompressed_20 : _zz_IBusSimplePlugin_decompressor_decompressed_19)},7'h67} : {{{{{_zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed_3,_zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed_4},(_zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed_5 ? _zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed_6 : _zz_IBusSimplePlugin_decompressor_decompressed_19)},3'b000},_zz_IBusSimplePlugin_decompressor_decompressed[11 : 7]},7'h33}));
      end
      5'h16 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{_zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed_7[11 : 5],_zz_IBusSimplePlugin_decompressor_decompressed[6 : 2]},_zz_IBusSimplePlugin_decompressor_decompressed_21},3'b010},_zz_VexRiscv_IBusSimplePlugin_decompressor_decompressed_8[4 : 0]},7'h23};
      end
      default : begin
      end
    endcase
  end

  assign _zz_IBusSimplePlugin_decompressor_decompressed_1 = {2'b01,_zz_IBusSimplePlugin_decompressor_decompressed[9 : 7]};
  assign _zz_IBusSimplePlugin_decompressor_decompressed_2 = {2'b01,_zz_IBusSimplePlugin_decompressor_decompressed[4 : 2]};
  assign _zz_IBusSimplePlugin_decompressor_decompressed_3 = {{{{5'h0,_zz_IBusSimplePlugin_decompressor_decompressed[5]},_zz_IBusSimplePlugin_decompressor_decompressed[12 : 10]},_zz_IBusSimplePlugin_decompressor_decompressed[6]},2'b00};
  assign _zz_IBusSimplePlugin_decompressor_decompressed_4 = _zz_IBusSimplePlugin_decompressor_decompressed[12];
  always @(*) begin
    _zz_IBusSimplePlugin_decompressor_decompressed_5[11] = _zz_IBusSimplePlugin_decompressor_decompressed_4;
    _zz_IBusSimplePlugin_decompressor_decompressed_5[10] = _zz_IBusSimplePlugin_decompressor_decompressed_4;
    _zz_IBusSimplePlugin_decompressor_decompressed_5[9] = _zz_IBusSimplePlugin_decompressor_decompressed_4;
    _zz_IBusSimplePlugin_decompressor_decompressed_5[8] = _zz_IBusSimplePlugin_decompressor_decompressed_4;
    _zz_IBusSimplePlugin_decompressor_decompressed_5[7] = _zz_IBusSimplePlugin_decompressor_decompressed_4;
    _zz_IBusSimplePlugin_decompressor_decompressed_5[6] = _zz_IBusSimplePlugin_decompressor_decompressed_4;
    _zz_IBusSimplePlugin_decompressor_decompressed_5[5] = _zz_IBusSimplePlugin_decompressor_decompressed_4;
    _zz_IBusSimplePlugin_decompressor_decompressed_5[4 : 0] = _zz_IBusSimplePlugin_decompressor_decompressed[6 : 2];
  end

  assign _zz_IBusSimplePlugin_decompressor_decompressed_6 = _zz_IBusSimplePlugin_decompressor_decompressed[12];
  always @(*) begin
    _zz_IBusSimplePlugin_decompressor_decompressed_7[9] = _zz_IBusSimplePlugin_decompressor_decompressed_6;
    _zz_IBusSimplePlugin_decompressor_decompressed_7[8] = _zz_IBusSimplePlugin_decompressor_decompressed_6;
    _zz_IBusSimplePlugin_decompressor_decompressed_7[7] = _zz_IBusSimplePlugin_decompressor_decompressed_6;
    _zz_IBusSimplePlugin_decompressor_decompressed_7[6] = _zz_IBusSimplePlugin_decompressor_decompressed_6;
    _zz_IBusSimplePlugin_decompressor_decompressed_7[5] = _zz_IBusSimplePlugin_decompressor_decompressed_6;
    _zz_IBusSimplePlugin_decompressor_decompressed_7[4] = _zz_IBusSimplePlugin_decompressor_decompressed_6;
    _zz_IBusSimplePlugin_decompressor_decompressed_7[3] = _zz_IBusSimplePlugin_decompressor_decompressed_6;
    _zz_IBusSimplePlugin_decompressor_decompressed_7[2] = _zz_IBusSimplePlugin_decompressor_decompressed_6;
    _zz_IBusSimplePlugin_decompressor_decompressed_7[1] = _zz_IBusSimplePlugin_decompressor_decompressed_6;
    _zz_IBusSimplePlugin_decompressor_decompressed_7[0] = _zz_IBusSimplePlugin_decompressor_decompressed_6;
  end

  assign _zz_IBusSimplePlugin_decompressor_decompressed_8 = {{{{{{{{_zz_IBusSimplePlugin_decompressor_decompressed_7,_zz_IBusSimplePlugin_decompressor_decompressed[8]},_zz_IBusSimplePlugin_decompressor_decompressed[10 : 9]},_zz_IBusSimplePlugin_decompressor_decompressed[6]},_zz_IBusSimplePlugin_decompressor_decompressed[7]},_zz_IBusSimplePlugin_decompressor_decompressed[2]},_zz_IBusSimplePlugin_decompressor_decompressed[11]},_zz_IBusSimplePlugin_decompressor_decompressed[5 : 3]},1'b0};
  assign _zz_IBusSimplePlugin_decompressor_decompressed_9 = _zz_IBusSimplePlugin_decompressor_decompressed[12];
  always @(*) begin
    _zz_IBusSimplePlugin_decompressor_decompressed_10[14] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[13] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[12] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[11] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[10] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[9] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[8] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[7] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[6] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[5] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[4] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[3] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[2] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[1] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
    _zz_IBusSimplePlugin_decompressor_decompressed_10[0] = _zz_IBusSimplePlugin_decompressor_decompressed_9;
  end

  assign _zz_IBusSimplePlugin_decompressor_decompressed_11 = _zz_IBusSimplePlugin_decompressor_decompressed[12];
  always @(*) begin
    _zz_IBusSimplePlugin_decompressor_decompressed_12[2] = _zz_IBusSimplePlugin_decompressor_decompressed_11;
    _zz_IBusSimplePlugin_decompressor_decompressed_12[1] = _zz_IBusSimplePlugin_decompressor_decompressed_11;
    _zz_IBusSimplePlugin_decompressor_decompressed_12[0] = _zz_IBusSimplePlugin_decompressor_decompressed_11;
  end

  assign _zz_IBusSimplePlugin_decompressor_decompressed_13 = _zz_IBusSimplePlugin_decompressor_decompressed[12];
  always @(*) begin
    _zz_IBusSimplePlugin_decompressor_decompressed_14[9] = _zz_IBusSimplePlugin_decompressor_decompressed_13;
    _zz_IBusSimplePlugin_decompressor_decompressed_14[8] = _zz_IBusSimplePlugin_decompressor_decompressed_13;
    _zz_IBusSimplePlugin_decompressor_decompressed_14[7] = _zz_IBusSimplePlugin_decompressor_decompressed_13;
    _zz_IBusSimplePlugin_decompressor_decompressed_14[6] = _zz_IBusSimplePlugin_decompressor_decompressed_13;
    _zz_IBusSimplePlugin_decompressor_decompressed_14[5] = _zz_IBusSimplePlugin_decompressor_decompressed_13;
    _zz_IBusSimplePlugin_decompressor_decompressed_14[4] = _zz_IBusSimplePlugin_decompressor_decompressed_13;
    _zz_IBusSimplePlugin_decompressor_decompressed_14[3] = _zz_IBusSimplePlugin_decompressor_decompressed_13;
    _zz_IBusSimplePlugin_decompressor_decompressed_14[2] = _zz_IBusSimplePlugin_decompressor_decompressed_13;
    _zz_IBusSimplePlugin_decompressor_decompressed_14[1] = _zz_IBusSimplePlugin_decompressor_decompressed_13;
    _zz_IBusSimplePlugin_decompressor_decompressed_14[0] = _zz_IBusSimplePlugin_decompressor_decompressed_13;
  end

  assign _zz_IBusSimplePlugin_decompressor_decompressed_15 = {{{{{{{{_zz_IBusSimplePlugin_decompressor_decompressed_14,_zz_IBusSimplePlugin_decompressor_decompressed[8]},_zz_IBusSimplePlugin_decompressor_decompressed[10 : 9]},_zz_IBusSimplePlugin_decompressor_decompressed[6]},_zz_IBusSimplePlugin_decompressor_decompressed[7]},_zz_IBusSimplePlugin_decompressor_decompressed[2]},_zz_IBusSimplePlugin_decompressor_decompressed[11]},_zz_IBusSimplePlugin_decompressor_decompressed[5 : 3]},1'b0};
  assign _zz_IBusSimplePlugin_decompressor_decompressed_16 = _zz_IBusSimplePlugin_decompressor_decompressed[12];
  always @(*) begin
    _zz_IBusSimplePlugin_decompressor_decompressed_17[4] = _zz_IBusSimplePlugin_decompressor_decompressed_16;
    _zz_IBusSimplePlugin_decompressor_decompressed_17[3] = _zz_IBusSimplePlugin_decompressor_decompressed_16;
    _zz_IBusSimplePlugin_decompressor_decompressed_17[2] = _zz_IBusSimplePlugin_decompressor_decompressed_16;
    _zz_IBusSimplePlugin_decompressor_decompressed_17[1] = _zz_IBusSimplePlugin_decompressor_decompressed_16;
    _zz_IBusSimplePlugin_decompressor_decompressed_17[0] = _zz_IBusSimplePlugin_decompressor_decompressed_16;
  end

  assign _zz_IBusSimplePlugin_decompressor_decompressed_18 = {{{{{_zz_IBusSimplePlugin_decompressor_decompressed_17,_zz_IBusSimplePlugin_decompressor_decompressed[6 : 5]},_zz_IBusSimplePlugin_decompressor_decompressed[2]},_zz_IBusSimplePlugin_decompressor_decompressed[11 : 10]},_zz_IBusSimplePlugin_decompressor_decompressed[4 : 3]},1'b0};
  assign _zz_IBusSimplePlugin_decompressor_decompressed_19 = 5'h0;
  assign _zz_IBusSimplePlugin_decompressor_decompressed_20 = 5'h01;
  assign _zz_IBusSimplePlugin_decompressor_decompressed_21 = 5'h02;
  assign switch_Misc_l44 = {_zz_IBusSimplePlugin_decompressor_decompressed[1 : 0],_zz_IBusSimplePlugin_decompressor_decompressed[15 : 13]};
  assign _zz_IBusSimplePlugin_decompressor_decompressed_22 = (_zz_IBusSimplePlugin_decompressor_decompressed[11 : 10] != 2'b11);
  assign switch_Misc_l199 = _zz_IBusSimplePlugin_decompressor_decompressed[11 : 10];
  assign switch_Misc_l199_1 = _zz_IBusSimplePlugin_decompressor_decompressed[6 : 5];
  always @(*) begin
    case(switch_Misc_l199_1)
      2'b00 : begin
        _zz_IBusSimplePlugin_decompressor_decompressed_23 = 3'b000;
      end
      2'b01 : begin
        _zz_IBusSimplePlugin_decompressor_decompressed_23 = 3'b100;
      end
      2'b10 : begin
        _zz_IBusSimplePlugin_decompressor_decompressed_23 = 3'b110;
      end
      default : begin
        _zz_IBusSimplePlugin_decompressor_decompressed_23 = 3'b111;
      end
    endcase
  end

  always @(*) begin
    case(switch_Misc_l199)
      2'b00 : begin
        _zz_IBusSimplePlugin_decompressor_decompressed_24 = 3'b101;
      end
      2'b01 : begin
        _zz_IBusSimplePlugin_decompressor_decompressed_24 = 3'b101;
      end
      2'b10 : begin
        _zz_IBusSimplePlugin_decompressor_decompressed_24 = 3'b111;
      end
      default : begin
        _zz_IBusSimplePlugin_decompressor_decompressed_24 = _zz_IBusSimplePlugin_decompressor_decompressed_23;
      end
    endcase
  end

  assign _zz_IBusSimplePlugin_decompressor_decompressed_25 = _zz_IBusSimplePlugin_decompressor_decompressed[12];
  always @(*) begin
    _zz_IBusSimplePlugin_decompressor_decompressed_26[6] = _zz_IBusSimplePlugin_decompressor_decompressed_25;
    _zz_IBusSimplePlugin_decompressor_decompressed_26[5] = _zz_IBusSimplePlugin_decompressor_decompressed_25;
    _zz_IBusSimplePlugin_decompressor_decompressed_26[4] = _zz_IBusSimplePlugin_decompressor_decompressed_25;
    _zz_IBusSimplePlugin_decompressor_decompressed_26[3] = _zz_IBusSimplePlugin_decompressor_decompressed_25;
    _zz_IBusSimplePlugin_decompressor_decompressed_26[2] = _zz_IBusSimplePlugin_decompressor_decompressed_25;
    _zz_IBusSimplePlugin_decompressor_decompressed_26[1] = _zz_IBusSimplePlugin_decompressor_decompressed_25;
    _zz_IBusSimplePlugin_decompressor_decompressed_26[0] = _zz_IBusSimplePlugin_decompressor_decompressed_25;
  end

  assign IBusSimplePlugin_decompressor_output_valid = (IBusSimplePlugin_decompressor_input_valid && (! ((IBusSimplePlugin_decompressor_throw2Bytes && (! IBusSimplePlugin_decompressor_bufferValid)) && (! IBusSimplePlugin_decompressor_isInputHighRvc))));
  assign IBusSimplePlugin_decompressor_output_payload_pc = IBusSimplePlugin_decompressor_input_payload_pc;
  assign IBusSimplePlugin_decompressor_output_payload_isRvc = IBusSimplePlugin_decompressor_isRvc;
  assign IBusSimplePlugin_decompressor_output_payload_rsp_inst = (IBusSimplePlugin_decompressor_isRvc ? IBusSimplePlugin_decompressor_decompressed : IBusSimplePlugin_decompressor_raw);
  assign IBusSimplePlugin_decompressor_input_ready = (IBusSimplePlugin_decompressor_output_ready && (((! IBusSimplePlugin_iBusRsp_stages_1_input_valid) || IBusSimplePlugin_decompressor_flushNext) || ((! (IBusSimplePlugin_decompressor_bufferValid && IBusSimplePlugin_decompressor_isInputHighRvc)) && (! (((! IBusSimplePlugin_decompressor_unaligned) && IBusSimplePlugin_decompressor_isInputLowRvc) && IBusSimplePlugin_decompressor_isInputHighRvc)))));
  assign when_Fetcher_l279 = (IBusSimplePlugin_decompressor_output_valid && IBusSimplePlugin_decompressor_output_ready);
  assign IBusSimplePlugin_decompressor_bufferFill = (((((! IBusSimplePlugin_decompressor_unaligned) && IBusSimplePlugin_decompressor_isInputLowRvc) && (! IBusSimplePlugin_decompressor_isInputHighRvc)) || (IBusSimplePlugin_decompressor_bufferValid && (! IBusSimplePlugin_decompressor_isInputHighRvc))) || ((IBusSimplePlugin_decompressor_throw2Bytes && (! IBusSimplePlugin_decompressor_isRvc)) && (! IBusSimplePlugin_decompressor_isInputHighRvc)));
  assign when_Fetcher_l283 = (IBusSimplePlugin_decompressor_output_ready && IBusSimplePlugin_decompressor_input_valid);
  assign when_Fetcher_l286 = (IBusSimplePlugin_decompressor_output_ready && IBusSimplePlugin_decompressor_input_valid);
  assign when_Fetcher_l291 = (IBusSimplePlugin_externalFlush || IBusSimplePlugin_decompressor_consumeCurrent);
  assign IBusSimplePlugin_decompressor_output_ready = ((1'b0 && (! IBusSimplePlugin_injector_decodeInput_valid)) || IBusSimplePlugin_injector_decodeInput_ready);
  assign IBusSimplePlugin_injector_decodeInput_valid = _zz_IBusSimplePlugin_injector_decodeInput_valid;
  assign IBusSimplePlugin_injector_decodeInput_payload_pc = _zz_IBusSimplePlugin_injector_decodeInput_payload_pc;
  assign IBusSimplePlugin_injector_decodeInput_payload_rsp_error = _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_error;
  assign IBusSimplePlugin_injector_decodeInput_payload_rsp_inst = _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_inst;
  assign IBusSimplePlugin_injector_decodeInput_payload_isRvc = _zz_IBusSimplePlugin_injector_decodeInput_payload_isRvc;
  assign when_Fetcher_l329 = (! 1'b0);
  assign when_Fetcher_l329_1 = (! execute_arbitration_isStuck);
  assign when_Fetcher_l329_2 = (! memory_arbitration_isStuck);
  assign when_Fetcher_l329_3 = (! writeBack_arbitration_isStuck);
  assign IBusSimplePlugin_pcValids_0 = IBusSimplePlugin_injector_nextPcCalc_valids_0;
  assign IBusSimplePlugin_pcValids_1 = IBusSimplePlugin_injector_nextPcCalc_valids_1;
  assign IBusSimplePlugin_pcValids_2 = IBusSimplePlugin_injector_nextPcCalc_valids_2;
  assign IBusSimplePlugin_pcValids_3 = IBusSimplePlugin_injector_nextPcCalc_valids_3;
  assign IBusSimplePlugin_injector_decodeInput_ready = (! decode_arbitration_isStuck);
  always @(*) begin
    decode_arbitration_isValid = IBusSimplePlugin_injector_decodeInput_valid;
    case(switch_Fetcher_l362)
      3'b010 : begin
        decode_arbitration_isValid = 1'b1;
      end
      3'b011 : begin
        decode_arbitration_isValid = 1'b1;
      end
      default : begin
      end
    endcase
  end

  assign _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch = _zz_VexRiscv__zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch[11];
  always @(*) begin
    _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch_1[18] = _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch_1[17] = _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch_1[16] = _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch_1[15] = _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch_1[14] = _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch_1[13] = _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch_1[12] = _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch_1[11] = _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch_1[10] = _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch_1[9] = _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch_1[8] = _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch_1[7] = _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch_1[6] = _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch_1[5] = _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch_1[4] = _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch_1[3] = _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch_1[2] = _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch_1[1] = _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch;
    _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch_1[0] = _zz_IBusSimplePlugin_decodePrediction_cmd_hadBranch;
  end

  assign IBusSimplePlugin_decodePrediction_cmd_hadBranch = ((decode_BRANCH_CTRL == `BranchCtrlEnum_defaultEncoding_JAL) || ((decode_BRANCH_CTRL == `BranchCtrlEnum_defaultEncoding_B) && _zz_VexRiscv_IBusSimplePlugin_decodePrediction_cmd_hadBranch[31]));
  assign IBusSimplePlugin_predictionJumpInterface_valid = (decode_arbitration_isValid && IBusSimplePlugin_decodePrediction_cmd_hadBranch);
  assign _zz_IBusSimplePlugin_predictionJumpInterface_payload = _zz_VexRiscv__zz_IBusSimplePlugin_predictionJumpInterface_payload[19];
  always @(*) begin
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_1[10] = _zz_IBusSimplePlugin_predictionJumpInterface_payload;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_1[9] = _zz_IBusSimplePlugin_predictionJumpInterface_payload;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_1[8] = _zz_IBusSimplePlugin_predictionJumpInterface_payload;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_1[7] = _zz_IBusSimplePlugin_predictionJumpInterface_payload;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_1[6] = _zz_IBusSimplePlugin_predictionJumpInterface_payload;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_1[5] = _zz_IBusSimplePlugin_predictionJumpInterface_payload;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_1[4] = _zz_IBusSimplePlugin_predictionJumpInterface_payload;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_1[3] = _zz_IBusSimplePlugin_predictionJumpInterface_payload;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_1[2] = _zz_IBusSimplePlugin_predictionJumpInterface_payload;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_1[1] = _zz_IBusSimplePlugin_predictionJumpInterface_payload;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_1[0] = _zz_IBusSimplePlugin_predictionJumpInterface_payload;
  end

  assign _zz_IBusSimplePlugin_predictionJumpInterface_payload_2 = _zz_VexRiscv__zz_IBusSimplePlugin_predictionJumpInterface_payload_2[11];
  always @(*) begin
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_3[18] = _zz_IBusSimplePlugin_predictionJumpInterface_payload_2;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_3[17] = _zz_IBusSimplePlugin_predictionJumpInterface_payload_2;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_3[16] = _zz_IBusSimplePlugin_predictionJumpInterface_payload_2;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_3[15] = _zz_IBusSimplePlugin_predictionJumpInterface_payload_2;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_3[14] = _zz_IBusSimplePlugin_predictionJumpInterface_payload_2;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_3[13] = _zz_IBusSimplePlugin_predictionJumpInterface_payload_2;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_3[12] = _zz_IBusSimplePlugin_predictionJumpInterface_payload_2;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_3[11] = _zz_IBusSimplePlugin_predictionJumpInterface_payload_2;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_3[10] = _zz_IBusSimplePlugin_predictionJumpInterface_payload_2;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_3[9] = _zz_IBusSimplePlugin_predictionJumpInterface_payload_2;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_3[8] = _zz_IBusSimplePlugin_predictionJumpInterface_payload_2;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_3[7] = _zz_IBusSimplePlugin_predictionJumpInterface_payload_2;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_3[6] = _zz_IBusSimplePlugin_predictionJumpInterface_payload_2;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_3[5] = _zz_IBusSimplePlugin_predictionJumpInterface_payload_2;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_3[4] = _zz_IBusSimplePlugin_predictionJumpInterface_payload_2;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_3[3] = _zz_IBusSimplePlugin_predictionJumpInterface_payload_2;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_3[2] = _zz_IBusSimplePlugin_predictionJumpInterface_payload_2;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_3[1] = _zz_IBusSimplePlugin_predictionJumpInterface_payload_2;
    _zz_IBusSimplePlugin_predictionJumpInterface_payload_3[0] = _zz_IBusSimplePlugin_predictionJumpInterface_payload_2;
  end

  assign IBusSimplePlugin_predictionJumpInterface_payload = (decode_PC + ((decode_BRANCH_CTRL == `BranchCtrlEnum_defaultEncoding_JAL) ? {{_zz_IBusSimplePlugin_predictionJumpInterface_payload_1,{{{_zz_VexRiscv_IBusSimplePlugin_predictionJumpInterface_payload,_zz_VexRiscv_IBusSimplePlugin_predictionJumpInterface_payload_1},_zz_VexRiscv_IBusSimplePlugin_predictionJumpInterface_payload_2},decode_INSTRUCTION[30 : 21]}},1'b0} : {{_zz_IBusSimplePlugin_predictionJumpInterface_payload_3,{{{_zz_VexRiscv_IBusSimplePlugin_predictionJumpInterface_payload_3,_zz_VexRiscv_IBusSimplePlugin_predictionJumpInterface_payload_4},decode_INSTRUCTION[30 : 25]},decode_INSTRUCTION[11 : 8]}},1'b0}));
  assign iBus_cmd_valid = IBusSimplePlugin_cmd_valid;
  assign IBusSimplePlugin_cmd_ready = iBus_cmd_ready;
  assign iBus_cmd_payload_pc = IBusSimplePlugin_cmd_payload_pc;
  assign IBusSimplePlugin_pending_next = (_zz_VexRiscv_IBusSimplePlugin_pending_next - _zz_VexRiscv_IBusSimplePlugin_pending_next_3);
  assign IBusSimplePlugin_cmdFork_canEmit = (IBusSimplePlugin_iBusRsp_stages_0_output_ready && (IBusSimplePlugin_pending_value != 3'b111));
  assign when_IBusSimplePlugin_l304 = (IBusSimplePlugin_iBusRsp_stages_0_input_valid && ((! IBusSimplePlugin_cmdFork_canEmit) || (! IBusSimplePlugin_cmd_ready)));
  assign IBusSimplePlugin_cmd_valid = (IBusSimplePlugin_iBusRsp_stages_0_input_valid && IBusSimplePlugin_cmdFork_canEmit);
  assign IBusSimplePlugin_pending_inc = (IBusSimplePlugin_cmd_valid && IBusSimplePlugin_cmd_ready);
  assign IBusSimplePlugin_cmd_payload_pc = {IBusSimplePlugin_iBusRsp_stages_0_input_payload[31 : 2],2'b00};
  assign IBusSimplePlugin_rspJoin_rspBuffer_flush = ((IBusSimplePlugin_rspJoin_rspBuffer_discardCounter != 3'b000) || IBusSimplePlugin_iBusRsp_flush);
  assign IBusSimplePlugin_rspJoin_rspBuffer_output_valid = (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid && (IBusSimplePlugin_rspJoin_rspBuffer_discardCounter == 3'b000));
  assign IBusSimplePlugin_rspJoin_rspBuffer_output_payload_error = IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_error;
  assign IBusSimplePlugin_rspJoin_rspBuffer_output_payload_inst = IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_inst;
  assign IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_ready = (IBusSimplePlugin_rspJoin_rspBuffer_output_ready || IBusSimplePlugin_rspJoin_rspBuffer_flush);
  assign IBusSimplePlugin_pending_dec = (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid && IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_ready);
  assign IBusSimplePlugin_rspJoin_fetchRsp_pc = IBusSimplePlugin_iBusRsp_stages_1_output_payload;
  always @(*) begin
    IBusSimplePlugin_rspJoin_fetchRsp_rsp_error = IBusSimplePlugin_rspJoin_rspBuffer_output_payload_error;
    if(when_IBusSimplePlugin_l375) begin
      IBusSimplePlugin_rspJoin_fetchRsp_rsp_error = 1'b0;
    end
  end

  assign IBusSimplePlugin_rspJoin_fetchRsp_rsp_inst = IBusSimplePlugin_rspJoin_rspBuffer_output_payload_inst;
  assign when_IBusSimplePlugin_l375 = (! IBusSimplePlugin_rspJoin_rspBuffer_output_valid);
  assign IBusSimplePlugin_rspJoin_exceptionDetected = 1'b0;
  assign IBusSimplePlugin_rspJoin_join_valid = (IBusSimplePlugin_iBusRsp_stages_1_output_valid && IBusSimplePlugin_rspJoin_rspBuffer_output_valid);
  assign IBusSimplePlugin_rspJoin_join_payload_pc = IBusSimplePlugin_rspJoin_fetchRsp_pc;
  assign IBusSimplePlugin_rspJoin_join_payload_rsp_error = IBusSimplePlugin_rspJoin_fetchRsp_rsp_error;
  assign IBusSimplePlugin_rspJoin_join_payload_rsp_inst = IBusSimplePlugin_rspJoin_fetchRsp_rsp_inst;
  assign IBusSimplePlugin_rspJoin_join_payload_isRvc = IBusSimplePlugin_rspJoin_fetchRsp_isRvc;
  assign IBusSimplePlugin_iBusRsp_stages_1_output_ready = (IBusSimplePlugin_iBusRsp_stages_1_output_valid ? (IBusSimplePlugin_rspJoin_join_valid && IBusSimplePlugin_rspJoin_join_ready) : IBusSimplePlugin_rspJoin_join_ready);
  assign IBusSimplePlugin_rspJoin_rspBuffer_output_ready = (IBusSimplePlugin_rspJoin_join_valid && IBusSimplePlugin_rspJoin_join_ready);
  assign _zz_IBusSimplePlugin_iBusRsp_output_valid = (! IBusSimplePlugin_rspJoin_exceptionDetected);
  assign IBusSimplePlugin_rspJoin_join_ready = (IBusSimplePlugin_iBusRsp_output_ready && _zz_IBusSimplePlugin_iBusRsp_output_valid);
  assign IBusSimplePlugin_iBusRsp_output_valid = (IBusSimplePlugin_rspJoin_join_valid && _zz_IBusSimplePlugin_iBusRsp_output_valid);
  assign IBusSimplePlugin_iBusRsp_output_payload_pc = IBusSimplePlugin_rspJoin_join_payload_pc;
  assign IBusSimplePlugin_iBusRsp_output_payload_rsp_error = IBusSimplePlugin_rspJoin_join_payload_rsp_error;
  assign IBusSimplePlugin_iBusRsp_output_payload_rsp_inst = IBusSimplePlugin_rspJoin_join_payload_rsp_inst;
  assign IBusSimplePlugin_iBusRsp_output_payload_isRvc = IBusSimplePlugin_rspJoin_join_payload_isRvc;
  assign _zz_dBus_cmd_valid = 1'b0;
  always @(*) begin
    execute_DBusSimplePlugin_skipCmd = 1'b0;
    if(execute_ALIGNEMENT_FAULT) begin
      execute_DBusSimplePlugin_skipCmd = 1'b1;
    end
  end

  assign dBus_cmd_valid = (((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! execute_arbitration_isStuckByOthers)) && (! execute_arbitration_isFlushed)) && (! execute_DBusSimplePlugin_skipCmd)) && (! _zz_dBus_cmd_valid));
  assign dBus_cmd_payload_wr = execute_MEMORY_STORE;
  assign dBus_cmd_payload_size = execute_INSTRUCTION[13 : 12];
  always @(*) begin
    case(dBus_cmd_payload_size)
      2'b00 : begin
        _zz_dBus_cmd_payload_data = {{{execute_RS2[7 : 0],execute_RS2[7 : 0]},execute_RS2[7 : 0]},execute_RS2[7 : 0]};
      end
      2'b01 : begin
        _zz_dBus_cmd_payload_data = {execute_RS2[15 : 0],execute_RS2[15 : 0]};
      end
      default : begin
        _zz_dBus_cmd_payload_data = execute_RS2[31 : 0];
      end
    endcase
  end

  assign dBus_cmd_payload_data = _zz_dBus_cmd_payload_data;
  assign when_DBusSimplePlugin_l426 = ((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! dBus_cmd_ready)) && (! execute_DBusSimplePlugin_skipCmd)) && (! _zz_dBus_cmd_valid));
  always @(*) begin
    case(dBus_cmd_payload_size)
      2'b00 : begin
        _zz_execute_DBusSimplePlugin_formalMask = 4'b0001;
      end
      2'b01 : begin
        _zz_execute_DBusSimplePlugin_formalMask = 4'b0011;
      end
      default : begin
        _zz_execute_DBusSimplePlugin_formalMask = 4'b1111;
      end
    endcase
  end

  assign execute_DBusSimplePlugin_formalMask = (_zz_execute_DBusSimplePlugin_formalMask <<< dBus_cmd_payload_address[1 : 0]);
  assign dBus_cmd_payload_address = execute_SRC_ADD;
  assign when_DBusSimplePlugin_l479 = (((memory_arbitration_isValid && memory_MEMORY_ENABLE) && (! memory_MEMORY_STORE)) && ((! dBus_rsp_ready) || 1'b0));
  always @(*) begin
    DBusSimplePlugin_memoryExceptionPort_valid = 1'b0;
    if(memory_ALIGNEMENT_FAULT) begin
      DBusSimplePlugin_memoryExceptionPort_valid = 1'b1;
    end
    if(when_DBusSimplePlugin_l512) begin
      DBusSimplePlugin_memoryExceptionPort_valid = 1'b0;
    end
  end

  always @(*) begin
    DBusSimplePlugin_memoryExceptionPort_payload_code = 4'bxxxx;
    if(memory_ALIGNEMENT_FAULT) begin
      DBusSimplePlugin_memoryExceptionPort_payload_code = {1'd0, _zz_VexRiscv_DBusSimplePlugin_memoryExceptionPort_payload_code};
    end
  end

  assign DBusSimplePlugin_memoryExceptionPort_payload_badAddr = memory_REGFILE_WRITE_DATA;
  assign when_DBusSimplePlugin_l512 = (! ((memory_arbitration_isValid && memory_MEMORY_ENABLE) && (1'b1 || (! memory_arbitration_isStuckByOthers))));
  always @(*) begin
    writeBack_DBusSimplePlugin_rspShifted = writeBack_MEMORY_READ_DATA;
    case(writeBack_MEMORY_ADDRESS_LOW)
      2'b01 : begin
        writeBack_DBusSimplePlugin_rspShifted[7 : 0] = writeBack_MEMORY_READ_DATA[15 : 8];
      end
      2'b10 : begin
        writeBack_DBusSimplePlugin_rspShifted[15 : 0] = writeBack_MEMORY_READ_DATA[31 : 16];
      end
      2'b11 : begin
        writeBack_DBusSimplePlugin_rspShifted[7 : 0] = writeBack_MEMORY_READ_DATA[31 : 24];
      end
      default : begin
      end
    endcase
  end

  assign switch_Misc_l199_2 = writeBack_INSTRUCTION[13 : 12];
  assign _zz_writeBack_DBusSimplePlugin_rspFormated = (writeBack_DBusSimplePlugin_rspShifted[7] && (! writeBack_INSTRUCTION[14]));
  always @(*) begin
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[31] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[30] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[29] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[28] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[27] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[26] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[25] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[24] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[23] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[22] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[21] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[20] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[19] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[18] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[17] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[16] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[15] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[14] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[13] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[12] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[11] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[10] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[9] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[8] = _zz_writeBack_DBusSimplePlugin_rspFormated;
    _zz_writeBack_DBusSimplePlugin_rspFormated_1[7 : 0] = writeBack_DBusSimplePlugin_rspShifted[7 : 0];
  end

  assign _zz_writeBack_DBusSimplePlugin_rspFormated_2 = (writeBack_DBusSimplePlugin_rspShifted[15] && (! writeBack_INSTRUCTION[14]));
  always @(*) begin
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[31] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[30] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[29] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[28] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[27] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[26] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[25] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[24] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[23] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[22] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[21] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[20] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[19] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[18] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[17] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[16] = _zz_writeBack_DBusSimplePlugin_rspFormated_2;
    _zz_writeBack_DBusSimplePlugin_rspFormated_3[15 : 0] = writeBack_DBusSimplePlugin_rspShifted[15 : 0];
  end

  always @(*) begin
    case(switch_Misc_l199_2)
      2'b00 : begin
        writeBack_DBusSimplePlugin_rspFormated = _zz_writeBack_DBusSimplePlugin_rspFormated_1;
      end
      2'b01 : begin
        writeBack_DBusSimplePlugin_rspFormated = _zz_writeBack_DBusSimplePlugin_rspFormated_3;
      end
      default : begin
        writeBack_DBusSimplePlugin_rspFormated = writeBack_DBusSimplePlugin_rspShifted;
      end
    endcase
  end

  assign when_DBusSimplePlugin_l558 = (writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE);
  always @(*) begin
    CsrPlugin_privilege = 2'b11;
    if(CsrPlugin_forceMachineWire) begin
      CsrPlugin_privilege = 2'b11;
    end
  end

  assign CsrPlugin_misa_base = 2'b01;
  assign CsrPlugin_misa_extensions = 26'h0000042;
  assign CsrPlugin_mtvec_mode = 2'b00;
  assign CsrPlugin_mtvec_base = 30'h00000008;
  assign _zz_when_CsrPlugin_l952 = (CsrPlugin_mip_MTIP && CsrPlugin_mie_MTIE);
  assign _zz_when_CsrPlugin_l952_1 = (CsrPlugin_mip_MSIP && CsrPlugin_mie_MSIE);
  assign _zz_when_CsrPlugin_l952_2 = (CsrPlugin_mip_MEIP && CsrPlugin_mie_MEIE);
  assign CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode = 1'b0;
  assign CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'b11;
  assign CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege = ((CsrPlugin_privilege < CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped) ? CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped : CsrPlugin_privilege);
  assign CsrPlugin_exceptionPortCtrl_exceptionValids_decode = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
  always @(*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_execute = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
    if(CsrPlugin_selfException_valid) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_execute = 1'b1;
    end
    if(execute_arbitration_isFlushed) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_execute = 1'b0;
    end
  end

  always @(*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_memory = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
    if(DBusSimplePlugin_memoryExceptionPort_valid) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_memory = 1'b1;
    end
    if(memory_arbitration_isFlushed) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_memory = 1'b0;
    end
  end

  always @(*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
    if(writeBack_arbitration_isFlushed) begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = 1'b0;
    end
  end

  assign when_CsrPlugin_l909 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l909_1 = (! memory_arbitration_isStuck);
  assign when_CsrPlugin_l909_2 = (! writeBack_arbitration_isStuck);
  assign when_CsrPlugin_l922 = ({CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack,{CsrPlugin_exceptionPortCtrl_exceptionValids_memory,{CsrPlugin_exceptionPortCtrl_exceptionValids_execute,CsrPlugin_exceptionPortCtrl_exceptionValids_decode}}} != 4'b0000);
  assign CsrPlugin_exceptionPendings_0 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
  assign CsrPlugin_exceptionPendings_1 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
  assign CsrPlugin_exceptionPendings_2 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
  assign CsrPlugin_exceptionPendings_3 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
  assign when_CsrPlugin_l946 = (CsrPlugin_mstatus_MIE || (CsrPlugin_privilege < 2'b11));
  assign when_CsrPlugin_l952 = ((_zz_when_CsrPlugin_l952 && 1'b1) && (! 1'b0));
  assign when_CsrPlugin_l952_1 = ((_zz_when_CsrPlugin_l952_1 && 1'b1) && (! 1'b0));
  assign when_CsrPlugin_l952_2 = ((_zz_when_CsrPlugin_l952_2 && 1'b1) && (! 1'b0));
  assign CsrPlugin_exception = (CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack && CsrPlugin_allowException);
  assign CsrPlugin_lastStageWasWfi = 1'b0;
  assign CsrPlugin_pipelineLiberator_active = ((CsrPlugin_interrupt_valid && CsrPlugin_allowInterrupts) && decode_arbitration_isValid);
  assign when_CsrPlugin_l980 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l980_1 = (! memory_arbitration_isStuck);
  assign when_CsrPlugin_l980_2 = (! writeBack_arbitration_isStuck);
  assign when_CsrPlugin_l985 = ((! CsrPlugin_pipelineLiberator_active) || decode_arbitration_removeIt);
  always @(*) begin
    CsrPlugin_pipelineLiberator_done = CsrPlugin_pipelineLiberator_pcValids_2;
    if(when_CsrPlugin_l991) begin
      CsrPlugin_pipelineLiberator_done = 1'b0;
    end
    if(CsrPlugin_hadException) begin
      CsrPlugin_pipelineLiberator_done = 1'b0;
    end
  end

  assign when_CsrPlugin_l991 = ({CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack,{CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory,CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute}} != 3'b000);
  assign CsrPlugin_interruptJump = ((CsrPlugin_interrupt_valid && CsrPlugin_pipelineLiberator_done) && CsrPlugin_allowInterrupts);
  always @(*) begin
    CsrPlugin_targetPrivilege = CsrPlugin_interrupt_targetPrivilege;
    if(CsrPlugin_hadException) begin
      CsrPlugin_targetPrivilege = CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege;
    end
  end

  always @(*) begin
    CsrPlugin_trapCause = CsrPlugin_interrupt_code;
    if(CsrPlugin_hadException) begin
      CsrPlugin_trapCause = CsrPlugin_exceptionPortCtrl_exceptionContext_code;
    end
  end

  always @(*) begin
    CsrPlugin_xtvec_mode = 2'bxx;
    case(CsrPlugin_targetPrivilege)
      2'b11 : begin
        CsrPlugin_xtvec_mode = CsrPlugin_mtvec_mode;
      end
      default : begin
      end
    endcase
  end

  always @(*) begin
    CsrPlugin_xtvec_base = 30'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
    case(CsrPlugin_targetPrivilege)
      2'b11 : begin
        CsrPlugin_xtvec_base = CsrPlugin_mtvec_base;
      end
      default : begin
      end
    endcase
  end

  assign when_CsrPlugin_l1019 = (CsrPlugin_hadException || CsrPlugin_interruptJump);
  assign when_CsrPlugin_l1064 = (writeBack_arbitration_isValid && (writeBack_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET));
  assign switch_CsrPlugin_l1068 = writeBack_INSTRUCTION[29 : 28];
  assign contextSwitching = CsrPlugin_jumpInterface_valid;
  assign when_CsrPlugin_l1116 = ({(writeBack_arbitration_isValid && (writeBack_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET)),{(memory_arbitration_isValid && (memory_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET)),(execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET))}} != 3'b000);
  assign execute_CsrPlugin_blockedBySideEffects = (({writeBack_arbitration_isValid,memory_arbitration_isValid} != 2'b00) || 1'b0);
  always @(*) begin
    execute_CsrPlugin_illegalAccess = 1'b1;
    if(execute_CsrPlugin_csr_768) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_836) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_772) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_833) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_834) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_835) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_3072) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_3200) begin
      if(execute_CSR_READ_OPCODE) begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(CsrPlugin_csrMapping_allowCsrSignal) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(when_CsrPlugin_l1297) begin
      execute_CsrPlugin_illegalAccess = 1'b1;
    end
    if(when_CsrPlugin_l1302) begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
  end

  always @(*) begin
    execute_CsrPlugin_illegalInstruction = 1'b0;
    if(when_CsrPlugin_l1136) begin
      if(when_CsrPlugin_l1137) begin
        execute_CsrPlugin_illegalInstruction = 1'b1;
      end
    end
  end

  always @(*) begin
    CsrPlugin_selfException_valid = 1'b0;
    if(when_CsrPlugin_l1129) begin
      CsrPlugin_selfException_valid = 1'b1;
    end
    if(when_CsrPlugin_l1154) begin
      CsrPlugin_selfException_valid = 1'b1;
    end
  end

  always @(*) begin
    CsrPlugin_selfException_payload_code = 4'bxxxx;
    if(when_CsrPlugin_l1129) begin
      CsrPlugin_selfException_payload_code = 4'b0010;
    end
    if(when_CsrPlugin_l1154) begin
      CsrPlugin_selfException_payload_code = 4'b0011;
    end
  end

  assign CsrPlugin_selfException_payload_badAddr = execute_INSTRUCTION;
  assign when_CsrPlugin_l1129 = (execute_CsrPlugin_illegalAccess || execute_CsrPlugin_illegalInstruction);
  assign when_CsrPlugin_l1136 = (execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET));
  assign when_CsrPlugin_l1137 = (CsrPlugin_privilege < execute_INSTRUCTION[29 : 28]);
  assign when_CsrPlugin_l1154 = ((execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_EBREAK)) && CsrPlugin_allowEbreakException);
  always @(*) begin
    execute_CsrPlugin_writeInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_WRITE_OPCODE);
    if(when_CsrPlugin_l1297) begin
      execute_CsrPlugin_writeInstruction = 1'b0;
    end
  end

  always @(*) begin
    execute_CsrPlugin_readInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_READ_OPCODE);
    if(when_CsrPlugin_l1297) begin
      execute_CsrPlugin_readInstruction = 1'b0;
    end
  end

  assign execute_CsrPlugin_writeEnable = (execute_CsrPlugin_writeInstruction && (! execute_arbitration_isStuck));
  assign execute_CsrPlugin_readEnable = (execute_CsrPlugin_readInstruction && (! execute_arbitration_isStuck));
  assign CsrPlugin_csrMapping_hazardFree = (! execute_CsrPlugin_blockedBySideEffects);
  assign execute_CsrPlugin_readToWriteData = CsrPlugin_csrMapping_readDataSignal;
  assign switch_Misc_l199_3 = execute_INSTRUCTION[13];
  always @(*) begin
    case(switch_Misc_l199_3)
      1'b0 : begin
        _zz_CsrPlugin_csrMapping_writeDataSignal = execute_SRC1;
      end
      default : begin
        _zz_CsrPlugin_csrMapping_writeDataSignal = (execute_INSTRUCTION[12] ? (execute_CsrPlugin_readToWriteData & (~ execute_SRC1)) : (execute_CsrPlugin_readToWriteData | execute_SRC1));
      end
    endcase
  end

  assign CsrPlugin_csrMapping_writeDataSignal = _zz_CsrPlugin_csrMapping_writeDataSignal;
  assign when_CsrPlugin_l1176 = (execute_arbitration_isValid && execute_IS_CSR);
  assign when_CsrPlugin_l1180 = (execute_arbitration_isValid && (execute_IS_CSR || 1'b0));
  assign execute_CsrPlugin_csrAddress = execute_INSTRUCTION[31 : 20];
  assign _zz_decode_SHIFT_CTRL_3 = ((decode_INSTRUCTION & 32'h00004050) == 32'h00004050);
  assign _zz_decode_SHIFT_CTRL_4 = ((decode_INSTRUCTION & 32'h00000004) == 32'h00000004);
  assign _zz_decode_SHIFT_CTRL_5 = ((decode_INSTRUCTION & 32'h00000050) == 32'h00000010);
  assign _zz_decode_SHIFT_CTRL_6 = ((decode_INSTRUCTION & 32'h00000048) == 32'h00000048);
  assign _zz_decode_SHIFT_CTRL_7 = ((decode_INSTRUCTION & 32'h10003050) == 32'h00000050);
  assign _zz_decode_SHIFT_CTRL_2 = {({_zz_decode_SHIFT_CTRL_6,(_zz_VexRiscv__zz_decode_SHIFT_CTRL_2 == _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_1)} != 2'b00),{((_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_2 == _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_3) != 1'b0),{(_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_4 != 1'b0),{(_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_5 != _zz_VexRiscv__zz_decode_SHIFT_CTRL_2_10),{_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_11,{_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_14,_zz_VexRiscv__zz_decode_SHIFT_CTRL_2_16}}}}}};
  assign _zz_decode_SRC1_CTRL_2 = _zz_decode_SHIFT_CTRL_2[1 : 0];
  assign _zz_decode_SRC1_CTRL_1 = _zz_decode_SRC1_CTRL_2;
  assign _zz_decode_ALU_CTRL_2 = _zz_decode_SHIFT_CTRL_2[6 : 5];
  assign _zz_decode_ALU_CTRL_1 = _zz_decode_ALU_CTRL_2;
  assign _zz_decode_SRC2_CTRL_2 = _zz_decode_SHIFT_CTRL_2[8 : 7];
  assign _zz_decode_SRC2_CTRL_1 = _zz_decode_SRC2_CTRL_2;
  assign _zz_decode_ENV_CTRL_2 = _zz_decode_SHIFT_CTRL_2[17 : 16];
  assign _zz_decode_ENV_CTRL_1 = _zz_decode_ENV_CTRL_2;
  assign _zz_decode_ALU_BITWISE_CTRL_2 = _zz_decode_SHIFT_CTRL_2[21 : 20];
  assign _zz_decode_ALU_BITWISE_CTRL_1 = _zz_decode_ALU_BITWISE_CTRL_2;
  assign _zz_decode_SHIFT_CTRL_8 = _zz_decode_SHIFT_CTRL_2[24 : 23];
  assign _zz_decode_SHIFT_CTRL_1 = _zz_decode_SHIFT_CTRL_8;
  assign _zz_decode_BRANCH_CTRL_2 = _zz_decode_SHIFT_CTRL_2[26 : 25];
  assign _zz_decode_BRANCH_CTRL = _zz_decode_BRANCH_CTRL_2;
  assign when_RegFilePlugin_l63 = (decode_INSTRUCTION[11 : 7] == 5'h0);
  assign decode_RegFilePlugin_regFileReadAddress1 = decode_INSTRUCTION_ANTICIPATED[19 : 15];
  assign decode_RegFilePlugin_regFileReadAddress2 = decode_INSTRUCTION_ANTICIPATED[24 : 20];
  assign decode_RegFilePlugin_rs1Data = _zz_VexRiscv_RegFilePlugin_regFile_port0;
  assign decode_RegFilePlugin_rs2Data = _zz_VexRiscv_RegFilePlugin_regFile_port1;
  always @(*) begin
    lastStageRegFileWrite_valid = (_zz_lastStageRegFileWrite_valid && writeBack_arbitration_isFiring);
    if(_zz_VexRiscv_2) begin
      lastStageRegFileWrite_valid = 1'b1;
    end
  end

  always @(*) begin
    lastStageRegFileWrite_payload_address = _zz_lastStageRegFileWrite_payload_address[11 : 7];
    if(_zz_VexRiscv_2) begin
      lastStageRegFileWrite_payload_address = 5'h0;
    end
  end

  always @(*) begin
    lastStageRegFileWrite_payload_data = _zz_decode_RS2_2;
    if(_zz_VexRiscv_2) begin
      lastStageRegFileWrite_payload_data = 32'h0;
    end
  end

  always @(*) begin
    case(execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_AND : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 & execute_SRC2);
      end
      `AluBitwiseCtrlEnum_defaultEncoding_OR : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 | execute_SRC2);
      end
      default : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 ^ execute_SRC2);
      end
    endcase
  end

  always @(*) begin
    case(execute_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_BITWISE : begin
        _zz_execute_REGFILE_WRITE_DATA = execute_IntAluPlugin_bitwise;
      end
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : begin
        _zz_execute_REGFILE_WRITE_DATA = {31'd0, _zz_VexRiscv__zz_execute_REGFILE_WRITE_DATA};
      end
      default : begin
        _zz_execute_REGFILE_WRITE_DATA = execute_SRC_ADD_SUB;
      end
    endcase
  end

  always @(*) begin
    case(decode_SRC1_CTRL)
      `Src1CtrlEnum_defaultEncoding_RS : begin
        _zz_decode_SRC1_1 = _zz_decode_SRC1;
      end
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : begin
        _zz_decode_SRC1_1 = {29'd0, _zz_VexRiscv__zz_decode_SRC1_1};
      end
      `Src1CtrlEnum_defaultEncoding_IMU : begin
        _zz_decode_SRC1_1 = {decode_INSTRUCTION[31 : 12],12'h0};
      end
      default : begin
        _zz_decode_SRC1_1 = {27'd0, _zz_VexRiscv__zz_decode_SRC1_1_1};
      end
    endcase
  end

  assign _zz_decode_SRC2_2 = decode_INSTRUCTION[31];
  always @(*) begin
    _zz_decode_SRC2_3[19] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[18] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[17] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[16] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[15] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[14] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[13] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[12] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[11] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[10] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[9] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[8] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[7] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[6] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[5] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[4] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[3] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[2] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[1] = _zz_decode_SRC2_2;
    _zz_decode_SRC2_3[0] = _zz_decode_SRC2_2;
  end

  assign _zz_decode_SRC2_4 = _zz_VexRiscv__zz_decode_SRC2_4[11];
  always @(*) begin
    _zz_decode_SRC2_5[19] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[18] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[17] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[16] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[15] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[14] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[13] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[12] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[11] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[10] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[9] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[8] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[7] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[6] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[5] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[4] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[3] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[2] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[1] = _zz_decode_SRC2_4;
    _zz_decode_SRC2_5[0] = _zz_decode_SRC2_4;
  end

  always @(*) begin
    case(decode_SRC2_CTRL)
      `Src2CtrlEnum_defaultEncoding_RS : begin
        _zz_decode_SRC2_6 = _zz_decode_SRC2_1;
      end
      `Src2CtrlEnum_defaultEncoding_IMI : begin
        _zz_decode_SRC2_6 = {_zz_decode_SRC2_3,decode_INSTRUCTION[31 : 20]};
      end
      `Src2CtrlEnum_defaultEncoding_IMS : begin
        _zz_decode_SRC2_6 = {_zz_decode_SRC2_5,{decode_INSTRUCTION[31 : 25],decode_INSTRUCTION[11 : 7]}};
      end
      default : begin
        _zz_decode_SRC2_6 = _zz_decode_SRC2;
      end
    endcase
  end

  always @(*) begin
    execute_SrcPlugin_addSub = _zz_VexRiscv_execute_SrcPlugin_addSub;
    if(execute_SRC2_FORCE_ZERO) begin
      execute_SrcPlugin_addSub = execute_SRC1;
    end
  end

  assign execute_SrcPlugin_less = ((execute_SRC1[31] == execute_SRC2[31]) ? execute_SrcPlugin_addSub[31] : (execute_SRC_LESS_UNSIGNED ? execute_SRC2[31] : execute_SRC1[31]));
  assign execute_LightShifterPlugin_isShift = (execute_SHIFT_CTRL != `ShiftCtrlEnum_defaultEncoding_DISABLE);
  assign execute_LightShifterPlugin_amplitude = (execute_LightShifterPlugin_isActive ? execute_LightShifterPlugin_amplitudeReg : execute_SRC2[4 : 0]);
  assign execute_LightShifterPlugin_shiftInput = (execute_LightShifterPlugin_isActive ? memory_REGFILE_WRITE_DATA : execute_SRC1);
  assign execute_LightShifterPlugin_done = (execute_LightShifterPlugin_amplitude[4 : 1] == 4'b0000);
  assign when_ShiftPlugins_l169 = ((execute_arbitration_isValid && execute_LightShifterPlugin_isShift) && (execute_SRC2[4 : 0] != 5'h0));
  always @(*) begin
    case(execute_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_SLL : begin
        _zz_decode_RS2_3 = (execute_LightShifterPlugin_shiftInput <<< 1);
      end
      default : begin
        _zz_decode_RS2_3 = _zz_VexRiscv__zz_decode_RS2_3;
      end
    endcase
  end

  assign when_ShiftPlugins_l175 = (! execute_arbitration_isStuckByOthers);
  assign when_ShiftPlugins_l184 = (! execute_LightShifterPlugin_done);
  always @(*) begin
    HazardSimplePlugin_src0Hazard = 1'b0;
    if(when_HazardSimplePlugin_l57) begin
      if(when_HazardSimplePlugin_l58) begin
        if(when_HazardSimplePlugin_l48) begin
          HazardSimplePlugin_src0Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l57_1) begin
      if(when_HazardSimplePlugin_l58_1) begin
        if(when_HazardSimplePlugin_l48_1) begin
          HazardSimplePlugin_src0Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l57_2) begin
      if(when_HazardSimplePlugin_l58_2) begin
        if(when_HazardSimplePlugin_l48_2) begin
          HazardSimplePlugin_src0Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l105) begin
      HazardSimplePlugin_src0Hazard = 1'b0;
    end
  end

  always @(*) begin
    HazardSimplePlugin_src1Hazard = 1'b0;
    if(when_HazardSimplePlugin_l57) begin
      if(when_HazardSimplePlugin_l58) begin
        if(when_HazardSimplePlugin_l51) begin
          HazardSimplePlugin_src1Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l57_1) begin
      if(when_HazardSimplePlugin_l58_1) begin
        if(when_HazardSimplePlugin_l51_1) begin
          HazardSimplePlugin_src1Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l57_2) begin
      if(when_HazardSimplePlugin_l58_2) begin
        if(when_HazardSimplePlugin_l51_2) begin
          HazardSimplePlugin_src1Hazard = 1'b1;
        end
      end
    end
    if(when_HazardSimplePlugin_l108) begin
      HazardSimplePlugin_src1Hazard = 1'b0;
    end
  end

  assign HazardSimplePlugin_writeBackWrites_valid = (_zz_lastStageRegFileWrite_valid && writeBack_arbitration_isFiring);
  assign HazardSimplePlugin_writeBackWrites_payload_address = _zz_lastStageRegFileWrite_payload_address[11 : 7];
  assign HazardSimplePlugin_writeBackWrites_payload_data = _zz_decode_RS2_2;
  assign HazardSimplePlugin_addr0Match = (HazardSimplePlugin_writeBackBuffer_payload_address == decode_INSTRUCTION[19 : 15]);
  assign HazardSimplePlugin_addr1Match = (HazardSimplePlugin_writeBackBuffer_payload_address == decode_INSTRUCTION[24 : 20]);
  assign when_HazardSimplePlugin_l47 = 1'b1;
  assign when_HazardSimplePlugin_l48 = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign when_HazardSimplePlugin_l51 = (writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign when_HazardSimplePlugin_l45 = (writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l57 = (writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l58 = (1'b0 || (! when_HazardSimplePlugin_l47));
  assign when_HazardSimplePlugin_l48_1 = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign when_HazardSimplePlugin_l51_1 = (memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign when_HazardSimplePlugin_l45_1 = (memory_arbitration_isValid && memory_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l57_1 = (memory_arbitration_isValid && memory_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l58_1 = (1'b0 || (! memory_BYPASSABLE_MEMORY_STAGE));
  assign when_HazardSimplePlugin_l48_2 = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]);
  assign when_HazardSimplePlugin_l51_2 = (execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]);
  assign when_HazardSimplePlugin_l45_2 = (execute_arbitration_isValid && execute_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l57_2 = (execute_arbitration_isValid && execute_REGFILE_WRITE_VALID);
  assign when_HazardSimplePlugin_l58_2 = (1'b0 || (! execute_BYPASSABLE_EXECUTE_STAGE));
  assign when_HazardSimplePlugin_l105 = (! decode_RS1_USE);
  assign when_HazardSimplePlugin_l108 = (! decode_RS2_USE);
  assign when_HazardSimplePlugin_l113 = (decode_arbitration_isValid && (HazardSimplePlugin_src0Hazard || HazardSimplePlugin_src1Hazard));
  assign execute_BranchPlugin_eq = (execute_SRC1 == execute_SRC2);
  assign switch_Misc_l199_4 = execute_INSTRUCTION[14 : 12];
  always @(*) begin
    casez(switch_Misc_l199_4)
      3'b000 : begin
        _zz_execute_BRANCH_COND_RESULT = execute_BranchPlugin_eq;
      end
      3'b001 : begin
        _zz_execute_BRANCH_COND_RESULT = (! execute_BranchPlugin_eq);
      end
      3'b1?1 : begin
        _zz_execute_BRANCH_COND_RESULT = (! execute_SRC_LESS);
      end
      default : begin
        _zz_execute_BRANCH_COND_RESULT = execute_SRC_LESS;
      end
    endcase
  end

  always @(*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : begin
        _zz_execute_BRANCH_COND_RESULT_1 = 1'b0;
      end
      `BranchCtrlEnum_defaultEncoding_JAL : begin
        _zz_execute_BRANCH_COND_RESULT_1 = 1'b1;
      end
      `BranchCtrlEnum_defaultEncoding_JALR : begin
        _zz_execute_BRANCH_COND_RESULT_1 = 1'b1;
      end
      default : begin
        _zz_execute_BRANCH_COND_RESULT_1 = _zz_execute_BRANCH_COND_RESULT;
      end
    endcase
  end

  assign execute_BranchPlugin_missAlignedTarget = 1'b0;
  always @(*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_JALR : begin
        execute_BranchPlugin_branch_src1 = execute_RS1;
      end
      default : begin
        execute_BranchPlugin_branch_src1 = execute_PC;
      end
    endcase
  end

  assign _zz_execute_BranchPlugin_branch_src2 = execute_INSTRUCTION[31];
  always @(*) begin
    _zz_execute_BranchPlugin_branch_src2_1[19] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[18] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[17] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[16] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[15] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[14] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[13] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[12] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[11] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[10] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[9] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[8] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[7] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[6] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[5] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[4] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[3] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[2] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[1] = _zz_execute_BranchPlugin_branch_src2;
    _zz_execute_BranchPlugin_branch_src2_1[0] = _zz_execute_BranchPlugin_branch_src2;
  end

  always @(*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_JALR : begin
        execute_BranchPlugin_branch_src2 = {_zz_execute_BranchPlugin_branch_src2_1,execute_INSTRUCTION[31 : 20]};
      end
      default : begin
        execute_BranchPlugin_branch_src2 = ((execute_BRANCH_CTRL == `BranchCtrlEnum_defaultEncoding_JAL) ? {{_zz_execute_BranchPlugin_branch_src2_3,{{{_zz_VexRiscv_execute_BranchPlugin_branch_src2,execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]}},1'b0} : {{_zz_execute_BranchPlugin_branch_src2_5,{{{_zz_VexRiscv_execute_BranchPlugin_branch_src2_1,_zz_VexRiscv_execute_BranchPlugin_branch_src2_2},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0});
        if(execute_PREDICTION_HAD_BRANCHED2) begin
          execute_BranchPlugin_branch_src2 = {29'd0, _zz_VexRiscv_execute_BranchPlugin_branch_src2_3};
        end
      end
    endcase
  end

  assign _zz_execute_BranchPlugin_branch_src2_2 = _zz_VexRiscv__zz_execute_BranchPlugin_branch_src2_2[19];
  always @(*) begin
    _zz_execute_BranchPlugin_branch_src2_3[10] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[9] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[8] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[7] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[6] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[5] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[4] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[3] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[2] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[1] = _zz_execute_BranchPlugin_branch_src2_2;
    _zz_execute_BranchPlugin_branch_src2_3[0] = _zz_execute_BranchPlugin_branch_src2_2;
  end

  assign _zz_execute_BranchPlugin_branch_src2_4 = _zz_VexRiscv__zz_execute_BranchPlugin_branch_src2_4[11];
  always @(*) begin
    _zz_execute_BranchPlugin_branch_src2_5[18] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[17] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[16] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[15] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[14] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[13] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[12] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[11] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[10] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[9] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[8] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[7] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[6] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[5] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[4] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[3] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[2] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[1] = _zz_execute_BranchPlugin_branch_src2_4;
    _zz_execute_BranchPlugin_branch_src2_5[0] = _zz_execute_BranchPlugin_branch_src2_4;
  end

  assign execute_BranchPlugin_branchAdder = (execute_BranchPlugin_branch_src1 + execute_BranchPlugin_branch_src2);
  assign BranchPlugin_jumpInterface_valid = ((memory_arbitration_isValid && memory_BRANCH_DO) && (! 1'b0));
  assign BranchPlugin_jumpInterface_payload = memory_BRANCH_CALC;
  assign IBusSimplePlugin_decodePrediction_rsp_wasWrong = BranchPlugin_jumpInterface_valid;
  assign when_DebugPlugin_l225 = (DebugPlugin_haltIt && (! DebugPlugin_isPipBusy));
  assign DebugPlugin_allowEBreak = (DebugPlugin_debugUsed && (! DebugPlugin_disableEbreak));
  always @(*) begin
    debug_bus_cmd_ready = 1'b1;
    if(debug_bus_cmd_valid) begin
      case(switch_DebugPlugin_l256)
        6'h01 : begin
          if(debug_bus_cmd_payload_wr) begin
            debug_bus_cmd_ready = IBusSimplePlugin_injectionPort_ready;
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @(*) begin
    debug_bus_rsp_data = DebugPlugin_busReadDataReg;
    if(when_DebugPlugin_l244) begin
      debug_bus_rsp_data[0] = DebugPlugin_resetIt;
      debug_bus_rsp_data[1] = DebugPlugin_haltIt;
      debug_bus_rsp_data[2] = DebugPlugin_isPipBusy;
      debug_bus_rsp_data[3] = DebugPlugin_haltedByBreak;
      debug_bus_rsp_data[4] = DebugPlugin_stepIt;
    end
  end

  assign when_DebugPlugin_l244 = (! _zz_when_DebugPlugin_l244);
  always @(*) begin
    IBusSimplePlugin_injectionPort_valid = 1'b0;
    if(debug_bus_cmd_valid) begin
      case(switch_DebugPlugin_l256)
        6'h01 : begin
          if(debug_bus_cmd_payload_wr) begin
            IBusSimplePlugin_injectionPort_valid = 1'b1;
          end
        end
        default : begin
        end
      endcase
    end
  end

  assign IBusSimplePlugin_injectionPort_payload = debug_bus_cmd_payload_data;
  assign switch_DebugPlugin_l256 = debug_bus_cmd_payload_address[7 : 2];
  assign when_DebugPlugin_l260 = debug_bus_cmd_payload_data[16];
  assign when_DebugPlugin_l260_1 = debug_bus_cmd_payload_data[24];
  assign when_DebugPlugin_l261 = debug_bus_cmd_payload_data[17];
  assign when_DebugPlugin_l261_1 = debug_bus_cmd_payload_data[25];
  assign when_DebugPlugin_l262 = debug_bus_cmd_payload_data[25];
  assign when_DebugPlugin_l263 = debug_bus_cmd_payload_data[25];
  assign when_DebugPlugin_l264 = debug_bus_cmd_payload_data[18];
  assign when_DebugPlugin_l264_1 = debug_bus_cmd_payload_data[26];
  assign when_DebugPlugin_l284 = (execute_arbitration_isValid && execute_DO_EBREAK);
  assign when_DebugPlugin_l287 = (({writeBack_arbitration_isValid,memory_arbitration_isValid} != 2'b00) == 1'b0);
  assign when_DebugPlugin_l300 = (DebugPlugin_stepIt && IBusSimplePlugin_incomingInstruction);
  assign debug_resetOut = DebugPlugin_resetIt_regNext;
  assign when_DebugPlugin_l316 = (DebugPlugin_haltIt || DebugPlugin_stepIt);
  assign when_Pipeline_l124 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_1 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_2 = ((! writeBack_arbitration_isStuck) && (! CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack));
  assign when_Pipeline_l124_3 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_4 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_5 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_6 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_7 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_8 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_9 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_10 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_11 = (! execute_arbitration_isStuck);
  assign _zz_decode_SRC1_CTRL = _zz_decode_SRC1_CTRL_1;
  assign when_Pipeline_l124_12 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_13 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_14 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_15 = (! writeBack_arbitration_isStuck);
  assign _zz_decode_to_execute_ALU_CTRL_1 = decode_ALU_CTRL;
  assign _zz_decode_ALU_CTRL = _zz_decode_ALU_CTRL_1;
  assign when_Pipeline_l124_16 = (! execute_arbitration_isStuck);
  assign _zz_execute_ALU_CTRL = decode_to_execute_ALU_CTRL;
  assign _zz_decode_SRC2_CTRL = _zz_decode_SRC2_CTRL_1;
  assign when_Pipeline_l124_17 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_18 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_19 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_20 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_21 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_22 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_23 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_24 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_25 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_26 = (! execute_arbitration_isStuck);
  assign _zz_decode_to_execute_ENV_CTRL_1 = decode_ENV_CTRL;
  assign _zz_execute_to_memory_ENV_CTRL_1 = execute_ENV_CTRL;
  assign _zz_memory_to_writeBack_ENV_CTRL_1 = memory_ENV_CTRL;
  assign _zz_decode_ENV_CTRL = _zz_decode_ENV_CTRL_1;
  assign when_Pipeline_l124_27 = (! execute_arbitration_isStuck);
  assign _zz_execute_ENV_CTRL = decode_to_execute_ENV_CTRL;
  assign when_Pipeline_l124_28 = (! memory_arbitration_isStuck);
  assign _zz_memory_ENV_CTRL = execute_to_memory_ENV_CTRL;
  assign when_Pipeline_l124_29 = (! writeBack_arbitration_isStuck);
  assign _zz_writeBack_ENV_CTRL = memory_to_writeBack_ENV_CTRL;
  assign when_Pipeline_l124_30 = (! execute_arbitration_isStuck);
  assign _zz_decode_to_execute_ALU_BITWISE_CTRL_1 = decode_ALU_BITWISE_CTRL;
  assign _zz_decode_ALU_BITWISE_CTRL = _zz_decode_ALU_BITWISE_CTRL_1;
  assign when_Pipeline_l124_31 = (! execute_arbitration_isStuck);
  assign _zz_execute_ALU_BITWISE_CTRL = decode_to_execute_ALU_BITWISE_CTRL;
  assign _zz_decode_to_execute_SHIFT_CTRL_1 = decode_SHIFT_CTRL;
  assign _zz_decode_SHIFT_CTRL = _zz_decode_SHIFT_CTRL_1;
  assign when_Pipeline_l124_32 = (! execute_arbitration_isStuck);
  assign _zz_execute_SHIFT_CTRL = decode_to_execute_SHIFT_CTRL;
  assign _zz_decode_to_execute_BRANCH_CTRL_1 = decode_BRANCH_CTRL;
  assign _zz_decode_BRANCH_CTRL_1 = _zz_decode_BRANCH_CTRL;
  assign when_Pipeline_l124_33 = (! execute_arbitration_isStuck);
  assign _zz_execute_BRANCH_CTRL = decode_to_execute_BRANCH_CTRL;
  assign when_Pipeline_l124_34 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_35 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_36 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_37 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_38 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_39 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_40 = (! execute_arbitration_isStuck);
  assign when_Pipeline_l124_41 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_42 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_43 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_44 = ((! memory_arbitration_isStuck) && (! execute_arbitration_isStuckByOthers));
  assign when_Pipeline_l124_45 = (! writeBack_arbitration_isStuck);
  assign when_Pipeline_l124_46 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_47 = (! memory_arbitration_isStuck);
  assign when_Pipeline_l124_48 = (! writeBack_arbitration_isStuck);
  assign decode_arbitration_isFlushed = (({writeBack_arbitration_flushNext,{memory_arbitration_flushNext,execute_arbitration_flushNext}} != 3'b000) || ({writeBack_arbitration_flushIt,{memory_arbitration_flushIt,{execute_arbitration_flushIt,decode_arbitration_flushIt}}} != 4'b0000));
  assign execute_arbitration_isFlushed = (({writeBack_arbitration_flushNext,memory_arbitration_flushNext} != 2'b00) || ({writeBack_arbitration_flushIt,{memory_arbitration_flushIt,execute_arbitration_flushIt}} != 3'b000));
  assign memory_arbitration_isFlushed = ((writeBack_arbitration_flushNext != 1'b0) || ({writeBack_arbitration_flushIt,memory_arbitration_flushIt} != 2'b00));
  assign writeBack_arbitration_isFlushed = (1'b0 || (writeBack_arbitration_flushIt != 1'b0));
  assign decode_arbitration_isStuckByOthers = (decode_arbitration_haltByOther || (((1'b0 || execute_arbitration_isStuck) || memory_arbitration_isStuck) || writeBack_arbitration_isStuck));
  assign decode_arbitration_isStuck = (decode_arbitration_haltItself || decode_arbitration_isStuckByOthers);
  assign decode_arbitration_isMoving = ((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt));
  assign decode_arbitration_isFiring = ((decode_arbitration_isValid && (! decode_arbitration_isStuck)) && (! decode_arbitration_removeIt));
  assign execute_arbitration_isStuckByOthers = (execute_arbitration_haltByOther || ((1'b0 || memory_arbitration_isStuck) || writeBack_arbitration_isStuck));
  assign execute_arbitration_isStuck = (execute_arbitration_haltItself || execute_arbitration_isStuckByOthers);
  assign execute_arbitration_isMoving = ((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt));
  assign execute_arbitration_isFiring = ((execute_arbitration_isValid && (! execute_arbitration_isStuck)) && (! execute_arbitration_removeIt));
  assign memory_arbitration_isStuckByOthers = (memory_arbitration_haltByOther || (1'b0 || writeBack_arbitration_isStuck));
  assign memory_arbitration_isStuck = (memory_arbitration_haltItself || memory_arbitration_isStuckByOthers);
  assign memory_arbitration_isMoving = ((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt));
  assign memory_arbitration_isFiring = ((memory_arbitration_isValid && (! memory_arbitration_isStuck)) && (! memory_arbitration_removeIt));
  assign writeBack_arbitration_isStuckByOthers = (writeBack_arbitration_haltByOther || 1'b0);
  assign writeBack_arbitration_isStuck = (writeBack_arbitration_haltItself || writeBack_arbitration_isStuckByOthers);
  assign writeBack_arbitration_isMoving = ((! writeBack_arbitration_isStuck) && (! writeBack_arbitration_removeIt));
  assign writeBack_arbitration_isFiring = ((writeBack_arbitration_isValid && (! writeBack_arbitration_isStuck)) && (! writeBack_arbitration_removeIt));
  assign when_Pipeline_l151 = ((! execute_arbitration_isStuck) || execute_arbitration_removeIt);
  assign when_Pipeline_l154 = ((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt));
  assign when_Pipeline_l151_1 = ((! memory_arbitration_isStuck) || memory_arbitration_removeIt);
  assign when_Pipeline_l154_1 = ((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt));
  assign when_Pipeline_l151_2 = ((! writeBack_arbitration_isStuck) || writeBack_arbitration_removeIt);
  assign when_Pipeline_l154_2 = ((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt));
  always @(*) begin
    IBusSimplePlugin_injectionPort_ready = 1'b0;
    case(switch_Fetcher_l362)
      3'b100 : begin
        IBusSimplePlugin_injectionPort_ready = 1'b1;
      end
      default : begin
      end
    endcase
  end

  assign when_Fetcher_l360 = (switch_Fetcher_l362 != 3'b000);
  assign when_Fetcher_l378 = (! decode_arbitration_isStuck);
  assign when_Fetcher_l398 = (switch_Fetcher_l362 != 3'b000);
  assign when_CsrPlugin_l1264 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_1 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_2 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_3 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_4 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_5 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_6 = (! execute_arbitration_isStuck);
  assign when_CsrPlugin_l1264_7 = (! execute_arbitration_isStuck);
  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit = 32'h0;
    if(execute_CsrPlugin_csr_768) begin
      _zz_CsrPlugin_csrMapping_readDataInit[12 : 11] = CsrPlugin_mstatus_MPP;
      _zz_CsrPlugin_csrMapping_readDataInit[7 : 7] = CsrPlugin_mstatus_MPIE;
      _zz_CsrPlugin_csrMapping_readDataInit[3 : 3] = CsrPlugin_mstatus_MIE;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_1 = 32'h0;
    if(execute_CsrPlugin_csr_836) begin
      _zz_CsrPlugin_csrMapping_readDataInit_1[11 : 11] = CsrPlugin_mip_MEIP;
      _zz_CsrPlugin_csrMapping_readDataInit_1[7 : 7] = CsrPlugin_mip_MTIP;
      _zz_CsrPlugin_csrMapping_readDataInit_1[3 : 3] = CsrPlugin_mip_MSIP;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_2 = 32'h0;
    if(execute_CsrPlugin_csr_772) begin
      _zz_CsrPlugin_csrMapping_readDataInit_2[11 : 11] = CsrPlugin_mie_MEIE;
      _zz_CsrPlugin_csrMapping_readDataInit_2[7 : 7] = CsrPlugin_mie_MTIE;
      _zz_CsrPlugin_csrMapping_readDataInit_2[3 : 3] = CsrPlugin_mie_MSIE;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_3 = 32'h0;
    if(execute_CsrPlugin_csr_833) begin
      _zz_CsrPlugin_csrMapping_readDataInit_3[31 : 0] = CsrPlugin_mepc;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_4 = 32'h0;
    if(execute_CsrPlugin_csr_834) begin
      _zz_CsrPlugin_csrMapping_readDataInit_4[31 : 31] = CsrPlugin_mcause_interrupt;
      _zz_CsrPlugin_csrMapping_readDataInit_4[3 : 0] = CsrPlugin_mcause_exceptionCode;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_5 = 32'h0;
    if(execute_CsrPlugin_csr_835) begin
      _zz_CsrPlugin_csrMapping_readDataInit_5[31 : 0] = CsrPlugin_mtval;
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_6 = 32'h0;
    if(execute_CsrPlugin_csr_3072) begin
      _zz_CsrPlugin_csrMapping_readDataInit_6[31 : 0] = CsrPlugin_mcycle[31 : 0];
    end
  end

  always @(*) begin
    _zz_CsrPlugin_csrMapping_readDataInit_7 = 32'h0;
    if(execute_CsrPlugin_csr_3200) begin
      _zz_CsrPlugin_csrMapping_readDataInit_7[31 : 0] = CsrPlugin_mcycle[63 : 32];
    end
  end

  assign CsrPlugin_csrMapping_readDataInit = (((_zz_CsrPlugin_csrMapping_readDataInit | _zz_CsrPlugin_csrMapping_readDataInit_1) | (_zz_CsrPlugin_csrMapping_readDataInit_2 | _zz_CsrPlugin_csrMapping_readDataInit_3)) | ((_zz_CsrPlugin_csrMapping_readDataInit_4 | _zz_CsrPlugin_csrMapping_readDataInit_5) | (_zz_CsrPlugin_csrMapping_readDataInit_6 | _zz_CsrPlugin_csrMapping_readDataInit_7)));
  assign when_CsrPlugin_l1297 = (CsrPlugin_privilege < execute_CsrPlugin_csrAddress[9 : 8]);
  assign when_CsrPlugin_l1302 = ((! execute_arbitration_isValid) || (! execute_IS_CSR));
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      IBusSimplePlugin_fetchPc_pcReg <= 32'h0;
      IBusSimplePlugin_fetchPc_correctionReg <= 1'b0;
      IBusSimplePlugin_fetchPc_booted <= 1'b0;
      IBusSimplePlugin_fetchPc_inc <= 1'b0;
      IBusSimplePlugin_decodePc_pcReg <= 32'h0;
      _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready_2 <= 1'b0;
      IBusSimplePlugin_decompressor_bufferValid <= 1'b0;
      IBusSimplePlugin_decompressor_throw2BytesReg <= 1'b0;
      _zz_IBusSimplePlugin_injector_decodeInput_valid <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      IBusSimplePlugin_pending_value <= 3'b000;
      IBusSimplePlugin_rspJoin_rspBuffer_discardCounter <= 3'b000;
      CsrPlugin_mstatus_MIE <= 1'b0;
      CsrPlugin_mstatus_MPIE <= 1'b0;
      CsrPlugin_mstatus_MPP <= 2'b11;
      CsrPlugin_mie_MEIE <= 1'b0;
      CsrPlugin_mie_MTIE <= 1'b0;
      CsrPlugin_mie_MSIE <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
      CsrPlugin_interrupt_valid <= 1'b0;
      CsrPlugin_pipelineLiberator_pcValids_0 <= 1'b0;
      CsrPlugin_pipelineLiberator_pcValids_1 <= 1'b0;
      CsrPlugin_pipelineLiberator_pcValids_2 <= 1'b0;
      CsrPlugin_hadException <= 1'b0;
      execute_CsrPlugin_wfiWake <= 1'b0;
      _zz_VexRiscv_2 <= 1'b1;
      execute_LightShifterPlugin_isActive <= 1'b0;
      HazardSimplePlugin_writeBackBuffer_valid <= 1'b0;
      DebugPlugin_resetIt <= 1'b0;
      DebugPlugin_haltIt <= 1'b0;
      DebugPlugin_stepIt <= 1'b0;
      DebugPlugin_godmode <= 1'b0;
      DebugPlugin_haltedByBreak <= 1'b0;
      DebugPlugin_debugUsed <= 1'b0;
      DebugPlugin_disableEbreak <= 1'b0;
      _zz_VexRiscv_3 <= 1'b0;
      execute_arbitration_isValid <= 1'b0;
      memory_arbitration_isValid <= 1'b0;
      writeBack_arbitration_isValid <= 1'b0;
      switch_Fetcher_l362 <= 3'b000;
    end else begin
      if(IBusSimplePlugin_fetchPc_correction) begin
        IBusSimplePlugin_fetchPc_correctionReg <= 1'b1;
      end
      if(when_Fetcher_l127) begin
        IBusSimplePlugin_fetchPc_correctionReg <= 1'b0;
      end
      IBusSimplePlugin_fetchPc_booted <= 1'b1;
      if(when_Fetcher_l131) begin
        IBusSimplePlugin_fetchPc_inc <= 1'b0;
      end
      if(when_Fetcher_l131_1) begin
        IBusSimplePlugin_fetchPc_inc <= 1'b1;
      end
      if(when_Fetcher_l131_2) begin
        IBusSimplePlugin_fetchPc_inc <= 1'b0;
      end
      if(when_Fetcher_l158) begin
        IBusSimplePlugin_fetchPc_pcReg <= IBusSimplePlugin_fetchPc_pc;
      end
      if(when_Fetcher_l180) begin
        IBusSimplePlugin_decodePc_pcReg <= IBusSimplePlugin_decodePc_pcPlus;
      end
      if(when_Fetcher_l192) begin
        IBusSimplePlugin_decodePc_pcReg <= IBusSimplePlugin_jump_pcLoad_payload;
      end
      if(IBusSimplePlugin_iBusRsp_flush) begin
        _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready_2 <= 1'b0;
      end
      if(_zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready) begin
        _zz_IBusSimplePlugin_iBusRsp_stages_0_output_ready_2 <= (IBusSimplePlugin_iBusRsp_stages_0_output_valid && (! 1'b0));
      end
      if(when_Fetcher_l279) begin
        IBusSimplePlugin_decompressor_throw2BytesReg <= ((((! IBusSimplePlugin_decompressor_unaligned) && IBusSimplePlugin_decompressor_isInputLowRvc) && IBusSimplePlugin_decompressor_isInputHighRvc) || (IBusSimplePlugin_decompressor_bufferValid && IBusSimplePlugin_decompressor_isInputHighRvc));
      end
      if(when_Fetcher_l283) begin
        IBusSimplePlugin_decompressor_bufferValid <= 1'b0;
      end
      if(when_Fetcher_l286) begin
        if(IBusSimplePlugin_decompressor_bufferFill) begin
          IBusSimplePlugin_decompressor_bufferValid <= 1'b1;
        end
      end
      if(when_Fetcher_l291) begin
        IBusSimplePlugin_decompressor_throw2BytesReg <= 1'b0;
        IBusSimplePlugin_decompressor_bufferValid <= 1'b0;
      end
      if(decode_arbitration_removeIt) begin
        _zz_IBusSimplePlugin_injector_decodeInput_valid <= 1'b0;
      end
      if(IBusSimplePlugin_decompressor_output_ready) begin
        _zz_IBusSimplePlugin_injector_decodeInput_valid <= (IBusSimplePlugin_decompressor_output_valid && (! IBusSimplePlugin_externalFlush));
      end
      if(when_Fetcher_l329) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_0 <= 1'b1;
      end
      if(IBusSimplePlugin_decodePc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      end
      if(when_Fetcher_l329_1) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_1 <= IBusSimplePlugin_injector_nextPcCalc_valids_0;
      end
      if(IBusSimplePlugin_decodePc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if(when_Fetcher_l329_2) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_2 <= IBusSimplePlugin_injector_nextPcCalc_valids_1;
      end
      if(IBusSimplePlugin_decodePc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if(when_Fetcher_l329_3) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_3 <= IBusSimplePlugin_injector_nextPcCalc_valids_2;
      end
      if(IBusSimplePlugin_decodePc_flushed) begin
        IBusSimplePlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      IBusSimplePlugin_pending_value <= IBusSimplePlugin_pending_next;
      IBusSimplePlugin_rspJoin_rspBuffer_discardCounter <= (IBusSimplePlugin_rspJoin_rspBuffer_discardCounter - _zz_VexRiscv_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter);
      if(IBusSimplePlugin_iBusRsp_flush) begin
        IBusSimplePlugin_rspJoin_rspBuffer_discardCounter <= (IBusSimplePlugin_pending_value - _zz_VexRiscv_IBusSimplePlugin_rspJoin_rspBuffer_discardCounter_2);
      end
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! (((dBus_rsp_ready && memory_MEMORY_ENABLE) && memory_arbitration_isValid) && memory_arbitration_isStuck)));
        `else
          if(!(! (((dBus_rsp_ready && memory_MEMORY_ENABLE) && memory_arbitration_isValid) && memory_arbitration_isStuck))) begin
            $display("FAILURE DBusSimplePlugin doesn't allow memory stage stall when read happend");
            $finish;
          end
        `endif
      `endif
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! (((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE) && (! writeBack_MEMORY_STORE)) && writeBack_arbitration_isStuck)));
        `else
          if(!(! (((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE) && (! writeBack_MEMORY_STORE)) && writeBack_arbitration_isStuck))) begin
            $display("FAILURE DBusSimplePlugin doesn't allow writeback stage stall when read happend");
            $finish;
          end
        `endif
      `endif
      if(when_CsrPlugin_l909) begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= 1'b0;
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
      end
      if(when_CsrPlugin_l909_1) begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= (CsrPlugin_exceptionPortCtrl_exceptionValids_execute && (! execute_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
      end
      if(when_CsrPlugin_l909_2) begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= (CsrPlugin_exceptionPortCtrl_exceptionValids_memory && (! memory_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
      end
      CsrPlugin_interrupt_valid <= 1'b0;
      if(when_CsrPlugin_l946) begin
        if(when_CsrPlugin_l952) begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(when_CsrPlugin_l952_1) begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(when_CsrPlugin_l952_2) begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
      end
      if(CsrPlugin_pipelineLiberator_active) begin
        if(when_CsrPlugin_l980) begin
          CsrPlugin_pipelineLiberator_pcValids_0 <= 1'b1;
        end
        if(when_CsrPlugin_l980_1) begin
          CsrPlugin_pipelineLiberator_pcValids_1 <= CsrPlugin_pipelineLiberator_pcValids_0;
        end
        if(when_CsrPlugin_l980_2) begin
          CsrPlugin_pipelineLiberator_pcValids_2 <= CsrPlugin_pipelineLiberator_pcValids_1;
        end
      end
      if(when_CsrPlugin_l985) begin
        CsrPlugin_pipelineLiberator_pcValids_0 <= 1'b0;
        CsrPlugin_pipelineLiberator_pcValids_1 <= 1'b0;
        CsrPlugin_pipelineLiberator_pcValids_2 <= 1'b0;
      end
      if(CsrPlugin_interruptJump) begin
        CsrPlugin_interrupt_valid <= 1'b0;
      end
      CsrPlugin_hadException <= CsrPlugin_exception;
      if(when_CsrPlugin_l1019) begin
        case(CsrPlugin_targetPrivilege)
          2'b11 : begin
            CsrPlugin_mstatus_MIE <= 1'b0;
            CsrPlugin_mstatus_MPIE <= CsrPlugin_mstatus_MIE;
            CsrPlugin_mstatus_MPP <= CsrPlugin_privilege;
          end
          default : begin
          end
        endcase
      end
      if(when_CsrPlugin_l1064) begin
        case(switch_CsrPlugin_l1068)
          2'b11 : begin
            CsrPlugin_mstatus_MPP <= 2'b00;
            CsrPlugin_mstatus_MIE <= CsrPlugin_mstatus_MPIE;
            CsrPlugin_mstatus_MPIE <= 1'b1;
          end
          default : begin
          end
        endcase
      end
      execute_CsrPlugin_wfiWake <= (({_zz_when_CsrPlugin_l952_2,{_zz_when_CsrPlugin_l952_1,_zz_when_CsrPlugin_l952}} != 3'b000) || CsrPlugin_thirdPartyWake);
      _zz_VexRiscv_2 <= 1'b0;
      if(when_ShiftPlugins_l169) begin
        if(when_ShiftPlugins_l175) begin
          execute_LightShifterPlugin_isActive <= 1'b1;
          if(execute_LightShifterPlugin_done) begin
            execute_LightShifterPlugin_isActive <= 1'b0;
          end
        end
      end
      if(execute_arbitration_removeIt) begin
        execute_LightShifterPlugin_isActive <= 1'b0;
      end
      HazardSimplePlugin_writeBackBuffer_valid <= HazardSimplePlugin_writeBackWrites_valid;
      if(when_DebugPlugin_l225) begin
        DebugPlugin_godmode <= 1'b1;
      end
      if(debug_bus_cmd_valid) begin
        DebugPlugin_debugUsed <= 1'b1;
      end
      if(debug_bus_cmd_valid) begin
        case(switch_DebugPlugin_l256)
          6'h0 : begin
            if(debug_bus_cmd_payload_wr) begin
              DebugPlugin_stepIt <= debug_bus_cmd_payload_data[4];
              if(when_DebugPlugin_l260) begin
                DebugPlugin_resetIt <= 1'b1;
              end
              if(when_DebugPlugin_l260_1) begin
                DebugPlugin_resetIt <= 1'b0;
              end
              if(when_DebugPlugin_l261) begin
                DebugPlugin_haltIt <= 1'b1;
              end
              if(when_DebugPlugin_l261_1) begin
                DebugPlugin_haltIt <= 1'b0;
              end
              if(when_DebugPlugin_l262) begin
                DebugPlugin_haltedByBreak <= 1'b0;
              end
              if(when_DebugPlugin_l263) begin
                DebugPlugin_godmode <= 1'b0;
              end
              if(when_DebugPlugin_l264) begin
                DebugPlugin_disableEbreak <= 1'b1;
              end
              if(when_DebugPlugin_l264_1) begin
                DebugPlugin_disableEbreak <= 1'b0;
              end
            end
          end
          default : begin
          end
        endcase
      end
      if(when_DebugPlugin_l284) begin
        if(when_DebugPlugin_l287) begin
          DebugPlugin_haltIt <= 1'b1;
          DebugPlugin_haltedByBreak <= 1'b1;
        end
      end
      if(when_DebugPlugin_l300) begin
        if(decode_arbitration_isValid) begin
          DebugPlugin_haltIt <= 1'b1;
        end
      end
      _zz_VexRiscv_3 <= (DebugPlugin_stepIt && decode_arbitration_isFiring);
      if(when_Pipeline_l151) begin
        execute_arbitration_isValid <= 1'b0;
      end
      if(when_Pipeline_l154) begin
        execute_arbitration_isValid <= decode_arbitration_isValid;
      end
      if(when_Pipeline_l151_1) begin
        memory_arbitration_isValid <= 1'b0;
      end
      if(when_Pipeline_l154_1) begin
        memory_arbitration_isValid <= execute_arbitration_isValid;
      end
      if(when_Pipeline_l151_2) begin
        writeBack_arbitration_isValid <= 1'b0;
      end
      if(when_Pipeline_l154_2) begin
        writeBack_arbitration_isValid <= memory_arbitration_isValid;
      end
      case(switch_Fetcher_l362)
        3'b000 : begin
          if(IBusSimplePlugin_injectionPort_valid) begin
            switch_Fetcher_l362 <= 3'b001;
          end
        end
        3'b001 : begin
          switch_Fetcher_l362 <= 3'b010;
        end
        3'b010 : begin
          switch_Fetcher_l362 <= 3'b011;
        end
        3'b011 : begin
          if(when_Fetcher_l378) begin
            switch_Fetcher_l362 <= 3'b100;
          end
        end
        3'b100 : begin
          switch_Fetcher_l362 <= 3'b000;
        end
        default : begin
        end
      endcase
      if(execute_CsrPlugin_csr_768) begin
        if(execute_CsrPlugin_writeEnable) begin
          CsrPlugin_mstatus_MPP <= CsrPlugin_csrMapping_writeDataSignal[12 : 11];
          CsrPlugin_mstatus_MPIE <= CsrPlugin_csrMapping_writeDataSignal[7];
          CsrPlugin_mstatus_MIE <= CsrPlugin_csrMapping_writeDataSignal[3];
        end
      end
      if(execute_CsrPlugin_csr_772) begin
        if(execute_CsrPlugin_writeEnable) begin
          CsrPlugin_mie_MEIE <= CsrPlugin_csrMapping_writeDataSignal[11];
          CsrPlugin_mie_MTIE <= CsrPlugin_csrMapping_writeDataSignal[7];
          CsrPlugin_mie_MSIE <= CsrPlugin_csrMapping_writeDataSignal[3];
        end
      end
    end
  end

  always @(posedge clk) begin
    if(IBusSimplePlugin_decompressor_input_valid) begin
      IBusSimplePlugin_decompressor_bufferValidLatch <= IBusSimplePlugin_decompressor_bufferValid;
    end
    if(IBusSimplePlugin_decompressor_input_valid) begin
      IBusSimplePlugin_decompressor_throw2BytesLatch <= IBusSimplePlugin_decompressor_throw2Bytes;
    end
    if(when_Fetcher_l286) begin
      IBusSimplePlugin_decompressor_bufferData <= IBusSimplePlugin_decompressor_input_payload_rsp_inst[31 : 16];
    end
    if(IBusSimplePlugin_decompressor_output_ready) begin
      _zz_IBusSimplePlugin_injector_decodeInput_payload_pc <= IBusSimplePlugin_decompressor_output_payload_pc;
      _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_error <= IBusSimplePlugin_decompressor_output_payload_rsp_error;
      _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_inst <= IBusSimplePlugin_decompressor_output_payload_rsp_inst;
      _zz_IBusSimplePlugin_injector_decodeInput_payload_isRvc <= IBusSimplePlugin_decompressor_output_payload_isRvc;
    end
    if(IBusSimplePlugin_injector_decodeInput_ready) begin
      IBusSimplePlugin_injector_formal_rawInDecode <= IBusSimplePlugin_decompressor_raw;
    end
    CsrPlugin_mip_MEIP <= externalInterrupt;
    CsrPlugin_mip_MTIP <= timerInterrupt;
    CsrPlugin_mip_MSIP <= softwareInterrupt;
    CsrPlugin_mcycle <= (CsrPlugin_mcycle + 64'h0000000000000001);
    if(writeBack_arbitration_isFiring) begin
      CsrPlugin_minstret <= (CsrPlugin_minstret + 64'h0000000000000001);
    end
    if(CsrPlugin_selfException_valid) begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= CsrPlugin_selfException_payload_code;
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= CsrPlugin_selfException_payload_badAddr;
    end
    if(DBusSimplePlugin_memoryExceptionPort_valid) begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= DBusSimplePlugin_memoryExceptionPort_payload_code;
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= DBusSimplePlugin_memoryExceptionPort_payload_badAddr;
    end
    if(when_CsrPlugin_l946) begin
      if(when_CsrPlugin_l952) begin
        CsrPlugin_interrupt_code <= 4'b0111;
        CsrPlugin_interrupt_targetPrivilege <= 2'b11;
      end
      if(when_CsrPlugin_l952_1) begin
        CsrPlugin_interrupt_code <= 4'b0011;
        CsrPlugin_interrupt_targetPrivilege <= 2'b11;
      end
      if(when_CsrPlugin_l952_2) begin
        CsrPlugin_interrupt_code <= 4'b1011;
        CsrPlugin_interrupt_targetPrivilege <= 2'b11;
      end
    end
    if(when_CsrPlugin_l1019) begin
      case(CsrPlugin_targetPrivilege)
        2'b11 : begin
          CsrPlugin_mcause_interrupt <= (! CsrPlugin_hadException);
          CsrPlugin_mcause_exceptionCode <= CsrPlugin_trapCause;
          CsrPlugin_mepc <= writeBack_PC;
          if(CsrPlugin_hadException) begin
            CsrPlugin_mtval <= CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
          end
        end
        default : begin
        end
      endcase
    end
    if(when_ShiftPlugins_l169) begin
      if(when_ShiftPlugins_l175) begin
        execute_LightShifterPlugin_amplitudeReg <= (execute_LightShifterPlugin_amplitude - 5'h01);
      end
    end
    HazardSimplePlugin_writeBackBuffer_payload_address <= HazardSimplePlugin_writeBackWrites_payload_address;
    HazardSimplePlugin_writeBackBuffer_payload_data <= HazardSimplePlugin_writeBackWrites_payload_data;
    DebugPlugin_firstCycle <= 1'b0;
    if(debug_bus_cmd_ready) begin
      DebugPlugin_firstCycle <= 1'b1;
    end
    DebugPlugin_secondCycle <= DebugPlugin_firstCycle;
    DebugPlugin_isPipBusy <= (({writeBack_arbitration_isValid,{memory_arbitration_isValid,{execute_arbitration_isValid,decode_arbitration_isValid}}} != 4'b0000) || IBusSimplePlugin_incomingInstruction);
    if(writeBack_arbitration_isValid) begin
      DebugPlugin_busReadDataReg <= _zz_decode_RS2_2;
    end
    _zz_when_DebugPlugin_l244 <= debug_bus_cmd_payload_address[2];
    if(when_DebugPlugin_l284) begin
      DebugPlugin_busReadDataReg <= execute_PC;
    end
    DebugPlugin_resetIt_regNext <= DebugPlugin_resetIt;
    if(when_Pipeline_l124) begin
      decode_to_execute_PC <= _zz_decode_SRC2;
    end
    if(when_Pipeline_l124_1) begin
      execute_to_memory_PC <= execute_PC;
    end
    if(when_Pipeline_l124_2) begin
      memory_to_writeBack_PC <= memory_PC;
    end
    if(when_Pipeline_l124_3) begin
      decode_to_execute_INSTRUCTION <= decode_INSTRUCTION;
    end
    if(when_Pipeline_l124_4) begin
      execute_to_memory_INSTRUCTION <= execute_INSTRUCTION;
    end
    if(when_Pipeline_l124_5) begin
      memory_to_writeBack_INSTRUCTION <= memory_INSTRUCTION;
    end
    if(when_Pipeline_l124_6) begin
      decode_to_execute_IS_RVC <= decode_IS_RVC;
    end
    if(when_Pipeline_l124_7) begin
      decode_to_execute_FORMAL_PC_NEXT <= _zz_decode_to_execute_FORMAL_PC_NEXT;
    end
    if(when_Pipeline_l124_8) begin
      execute_to_memory_FORMAL_PC_NEXT <= execute_FORMAL_PC_NEXT;
    end
    if(when_Pipeline_l124_9) begin
      memory_to_writeBack_FORMAL_PC_NEXT <= _zz_memory_to_writeBack_FORMAL_PC_NEXT;
    end
    if(when_Pipeline_l124_10) begin
      decode_to_execute_CSR_WRITE_OPCODE <= decode_CSR_WRITE_OPCODE;
    end
    if(when_Pipeline_l124_11) begin
      decode_to_execute_CSR_READ_OPCODE <= decode_CSR_READ_OPCODE;
    end
    if(when_Pipeline_l124_12) begin
      decode_to_execute_SRC_USE_SUB_LESS <= decode_SRC_USE_SUB_LESS;
    end
    if(when_Pipeline_l124_13) begin
      decode_to_execute_MEMORY_ENABLE <= decode_MEMORY_ENABLE;
    end
    if(when_Pipeline_l124_14) begin
      execute_to_memory_MEMORY_ENABLE <= execute_MEMORY_ENABLE;
    end
    if(when_Pipeline_l124_15) begin
      memory_to_writeBack_MEMORY_ENABLE <= memory_MEMORY_ENABLE;
    end
    if(when_Pipeline_l124_16) begin
      decode_to_execute_ALU_CTRL <= _zz_decode_to_execute_ALU_CTRL;
    end
    if(when_Pipeline_l124_17) begin
      decode_to_execute_REGFILE_WRITE_VALID <= decode_REGFILE_WRITE_VALID;
    end
    if(when_Pipeline_l124_18) begin
      execute_to_memory_REGFILE_WRITE_VALID <= execute_REGFILE_WRITE_VALID;
    end
    if(when_Pipeline_l124_19) begin
      memory_to_writeBack_REGFILE_WRITE_VALID <= memory_REGFILE_WRITE_VALID;
    end
    if(when_Pipeline_l124_20) begin
      decode_to_execute_BYPASSABLE_EXECUTE_STAGE <= decode_BYPASSABLE_EXECUTE_STAGE;
    end
    if(when_Pipeline_l124_21) begin
      decode_to_execute_BYPASSABLE_MEMORY_STAGE <= decode_BYPASSABLE_MEMORY_STAGE;
    end
    if(when_Pipeline_l124_22) begin
      execute_to_memory_BYPASSABLE_MEMORY_STAGE <= execute_BYPASSABLE_MEMORY_STAGE;
    end
    if(when_Pipeline_l124_23) begin
      decode_to_execute_MEMORY_STORE <= decode_MEMORY_STORE;
    end
    if(when_Pipeline_l124_24) begin
      execute_to_memory_MEMORY_STORE <= execute_MEMORY_STORE;
    end
    if(when_Pipeline_l124_25) begin
      memory_to_writeBack_MEMORY_STORE <= memory_MEMORY_STORE;
    end
    if(when_Pipeline_l124_26) begin
      decode_to_execute_IS_CSR <= decode_IS_CSR;
    end
    if(when_Pipeline_l124_27) begin
      decode_to_execute_ENV_CTRL <= _zz_decode_to_execute_ENV_CTRL;
    end
    if(when_Pipeline_l124_28) begin
      execute_to_memory_ENV_CTRL <= _zz_execute_to_memory_ENV_CTRL;
    end
    if(when_Pipeline_l124_29) begin
      memory_to_writeBack_ENV_CTRL <= _zz_memory_to_writeBack_ENV_CTRL;
    end
    if(when_Pipeline_l124_30) begin
      decode_to_execute_SRC_LESS_UNSIGNED <= decode_SRC_LESS_UNSIGNED;
    end
    if(when_Pipeline_l124_31) begin
      decode_to_execute_ALU_BITWISE_CTRL <= _zz_decode_to_execute_ALU_BITWISE_CTRL;
    end
    if(when_Pipeline_l124_32) begin
      decode_to_execute_SHIFT_CTRL <= _zz_decode_to_execute_SHIFT_CTRL;
    end
    if(when_Pipeline_l124_33) begin
      decode_to_execute_BRANCH_CTRL <= _zz_decode_to_execute_BRANCH_CTRL;
    end
    if(when_Pipeline_l124_34) begin
      decode_to_execute_RS1 <= _zz_decode_SRC1;
    end
    if(when_Pipeline_l124_35) begin
      decode_to_execute_RS2 <= _zz_decode_SRC2_1;
    end
    if(when_Pipeline_l124_36) begin
      decode_to_execute_SRC2_FORCE_ZERO <= decode_SRC2_FORCE_ZERO;
    end
    if(when_Pipeline_l124_37) begin
      decode_to_execute_SRC1 <= decode_SRC1;
    end
    if(when_Pipeline_l124_38) begin
      decode_to_execute_SRC2 <= decode_SRC2;
    end
    if(when_Pipeline_l124_39) begin
      decode_to_execute_PREDICTION_HAD_BRANCHED2 <= decode_PREDICTION_HAD_BRANCHED2;
    end
    if(when_Pipeline_l124_40) begin
      decode_to_execute_DO_EBREAK <= decode_DO_EBREAK;
    end
    if(when_Pipeline_l124_41) begin
      execute_to_memory_ALIGNEMENT_FAULT <= execute_ALIGNEMENT_FAULT;
    end
    if(when_Pipeline_l124_42) begin
      execute_to_memory_MEMORY_ADDRESS_LOW <= execute_MEMORY_ADDRESS_LOW;
    end
    if(when_Pipeline_l124_43) begin
      memory_to_writeBack_MEMORY_ADDRESS_LOW <= memory_MEMORY_ADDRESS_LOW;
    end
    if(when_Pipeline_l124_44) begin
      execute_to_memory_REGFILE_WRITE_DATA <= _zz_decode_RS2_1;
    end
    if(when_Pipeline_l124_45) begin
      memory_to_writeBack_REGFILE_WRITE_DATA <= _zz_decode_RS2;
    end
    if(when_Pipeline_l124_46) begin
      execute_to_memory_BRANCH_DO <= execute_BRANCH_DO;
    end
    if(when_Pipeline_l124_47) begin
      execute_to_memory_BRANCH_CALC <= execute_BRANCH_CALC;
    end
    if(when_Pipeline_l124_48) begin
      memory_to_writeBack_MEMORY_READ_DATA <= memory_MEMORY_READ_DATA;
    end
    if(when_Fetcher_l398) begin
      _zz_IBusSimplePlugin_injector_decodeInput_payload_rsp_inst <= IBusSimplePlugin_injectionPort_payload;
    end
    if(when_CsrPlugin_l1264) begin
      execute_CsrPlugin_csr_768 <= (decode_INSTRUCTION[31 : 20] == 12'h300);
    end
    if(when_CsrPlugin_l1264_1) begin
      execute_CsrPlugin_csr_836 <= (decode_INSTRUCTION[31 : 20] == 12'h344);
    end
    if(when_CsrPlugin_l1264_2) begin
      execute_CsrPlugin_csr_772 <= (decode_INSTRUCTION[31 : 20] == 12'h304);
    end
    if(when_CsrPlugin_l1264_3) begin
      execute_CsrPlugin_csr_833 <= (decode_INSTRUCTION[31 : 20] == 12'h341);
    end
    if(when_CsrPlugin_l1264_4) begin
      execute_CsrPlugin_csr_834 <= (decode_INSTRUCTION[31 : 20] == 12'h342);
    end
    if(when_CsrPlugin_l1264_5) begin
      execute_CsrPlugin_csr_835 <= (decode_INSTRUCTION[31 : 20] == 12'h343);
    end
    if(when_CsrPlugin_l1264_6) begin
      execute_CsrPlugin_csr_3072 <= (decode_INSTRUCTION[31 : 20] == 12'hc00);
    end
    if(when_CsrPlugin_l1264_7) begin
      execute_CsrPlugin_csr_3200 <= (decode_INSTRUCTION[31 : 20] == 12'hc80);
    end
    if(execute_CsrPlugin_csr_836) begin
      if(execute_CsrPlugin_writeEnable) begin
        CsrPlugin_mip_MSIP <= CsrPlugin_csrMapping_writeDataSignal[3];
      end
    end
    if(execute_CsrPlugin_csr_833) begin
      if(execute_CsrPlugin_writeEnable) begin
        CsrPlugin_mepc <= CsrPlugin_csrMapping_writeDataSignal[31 : 0];
      end
    end
  end


endmodule

module FlowCCByToggle (
  input               io_input_valid,
  input               io_input_payload_last,
  input      [0:0]    io_input_payload_fragment,
  output              io_output_valid,
  output              io_output_payload_last,
  output     [0:0]    io_output_payload_fragment,
  input               io_jtag_tck,
  input               clk,
  input               reset
);
  wire                inputArea_target_buffercc_io_dataOut;
  wire                outHitSignal;
  reg                 inputArea_target = 0;
  reg                 inputArea_data_last;
  reg        [0:0]    inputArea_data_fragment;
  wire                outputArea_target;
  reg                 outputArea_hit;
  wire                outputArea_flow_valid;
  wire                outputArea_flow_payload_last;
  wire       [0:0]    outputArea_flow_payload_fragment;
  reg                 outputArea_flow_regNext_valid;
  reg                 outputArea_flow_regNext_payload_last;
  reg        [0:0]    outputArea_flow_regNext_payload_fragment;

  BufferCC inputArea_target_buffercc (
    .io_dataIn     (inputArea_target                      ), //i
    .io_dataOut    (inputArea_target_buffercc_io_dataOut  ), //o
    .clk           (clk                                   ), //i
    .reset         (reset                                 )  //i
  );
  assign outputArea_target = inputArea_target_buffercc_io_dataOut;
  assign outputArea_flow_valid = (outputArea_target != outputArea_hit);
  assign outputArea_flow_payload_last = inputArea_data_last;
  assign outputArea_flow_payload_fragment = inputArea_data_fragment;
  assign io_output_valid = outputArea_flow_regNext_valid;
  assign io_output_payload_last = outputArea_flow_regNext_payload_last;
  assign io_output_payload_fragment = outputArea_flow_regNext_payload_fragment;
  always @(posedge io_jtag_tck) begin
    if(io_input_valid) begin
      inputArea_target <= (! inputArea_target);
      inputArea_data_last <= io_input_payload_last;
      inputArea_data_fragment <= io_input_payload_fragment;
    end
  end

  always @(posedge clk) begin
    outputArea_hit <= outputArea_target;
    outputArea_flow_regNext_payload_last <= outputArea_flow_payload_last;
    outputArea_flow_regNext_payload_fragment <= outputArea_flow_payload_fragment;
  end

  always @(posedge clk or posedge reset) begin
    if(reset) begin
      outputArea_flow_regNext_valid <= 1'b0;
    end else begin
      outputArea_flow_regNext_valid <= outputArea_flow_valid;
    end
  end


endmodule

module StreamFifoLowLatency (
  input               io_push_valid,
  output              io_push_ready,
  input               io_push_payload_error,
  input      [31:0]   io_push_payload_inst,
  output reg          io_pop_valid,
  input               io_pop_ready,
  output reg          io_pop_payload_error,
  output reg [31:0]   io_pop_payload_inst,
  input               io_flush,
  output     [0:0]    io_occupancy,
  input               clk,
  input               reset
);
  reg                 when_Phase_l623;
  reg                 pushPtr_willIncrement;
  reg                 pushPtr_willClear;
  wire                pushPtr_willOverflowIfInc;
  wire                pushPtr_willOverflow;
  reg                 popPtr_willIncrement;
  reg                 popPtr_willClear;
  wire                popPtr_willOverflowIfInc;
  wire                popPtr_willOverflow;
  wire                ptrMatch;
  reg                 risingOccupancy;
  wire                empty;
  wire                full;
  wire                pushing;
  wire                popping;
  wire                when_Stream_l1017;
  wire       [32:0]   _zz_io_pop_payload_error;
  wire                when_Stream_l1030;
  reg        [32:0]   _zz_io_pop_payload_error_1;

  always @(*) begin
    when_Phase_l623 = 1'b0;
    if(pushing) begin
      when_Phase_l623 = 1'b1;
    end
  end

  always @(*) begin
    pushPtr_willIncrement = 1'b0;
    if(pushing) begin
      pushPtr_willIncrement = 1'b1;
    end
  end

  always @(*) begin
    pushPtr_willClear = 1'b0;
    if(io_flush) begin
      pushPtr_willClear = 1'b1;
    end
  end

  assign pushPtr_willOverflowIfInc = 1'b1;
  assign pushPtr_willOverflow = (pushPtr_willOverflowIfInc && pushPtr_willIncrement);
  always @(*) begin
    popPtr_willIncrement = 1'b0;
    if(popping) begin
      popPtr_willIncrement = 1'b1;
    end
  end

  always @(*) begin
    popPtr_willClear = 1'b0;
    if(io_flush) begin
      popPtr_willClear = 1'b1;
    end
  end

  assign popPtr_willOverflowIfInc = 1'b1;
  assign popPtr_willOverflow = (popPtr_willOverflowIfInc && popPtr_willIncrement);
  assign ptrMatch = 1'b1;
  assign empty = (ptrMatch && (! risingOccupancy));
  assign full = (ptrMatch && risingOccupancy);
  assign pushing = (io_push_valid && io_push_ready);
  assign popping = (io_pop_valid && io_pop_ready);
  assign io_push_ready = (! full);
  assign when_Stream_l1017 = (! empty);
  always @(*) begin
    if(when_Stream_l1017) begin
      io_pop_valid = 1'b1;
    end else begin
      io_pop_valid = io_push_valid;
    end
  end

  assign _zz_io_pop_payload_error = _zz_io_pop_payload_error_1;
  always @(*) begin
    if(when_Stream_l1017) begin
      io_pop_payload_error = _zz_io_pop_payload_error[0];
    end else begin
      io_pop_payload_error = io_push_payload_error;
    end
  end

  always @(*) begin
    if(when_Stream_l1017) begin
      io_pop_payload_inst = _zz_io_pop_payload_error[32 : 1];
    end else begin
      io_pop_payload_inst = io_push_payload_inst;
    end
  end

  assign when_Stream_l1030 = (pushing != popping);
  assign io_occupancy = (risingOccupancy && ptrMatch);
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      risingOccupancy <= 1'b0;
    end else begin
      if(when_Stream_l1030) begin
        risingOccupancy <= pushing;
      end
      if(io_flush) begin
        risingOccupancy <= 1'b0;
      end
    end
  end

  always @(posedge clk) begin
    if(when_Phase_l623) begin
      _zz_io_pop_payload_error_1 <= {io_push_payload_inst,io_push_payload_error};
    end
  end


endmodule

module BufferCC (
  input               io_dataIn,
  output              io_dataOut,
  input               clk,
  input               reset
);
  (* async_reg = "true" *) reg                 buffers_0;
  (* async_reg = "true" *) reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @(posedge clk) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end


endmodule
