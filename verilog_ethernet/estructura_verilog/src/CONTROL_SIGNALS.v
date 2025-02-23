module CONTROL_SIGNALS (
    input  wire        clock,
    input  wire        reset_in,
    input  wire [63:0] digital_input,
    output wire [63:0] digital_output,
    input  wire        clk50MHz,
    input  wire        clk125MHz,
    input  wire        UART_RX,
    output wire        UART_TX,
    output wire [63:0] csr_prevpc_out,        // For FPGA debugging
    output wire [35:0] pc_of_current_inst,    // For FPGA debugging
    output wire [15:0] csr_cause_out,         // For FPGA debugging
    output wire  [3:0] state_out,             // For FPGA debugging
    output wire        line                   // Unused (draws a big red line in ModelSim wave display)
);

  // --------------------  Registers  --------------------
  localparam STATE_RESET = 4'b0000;
  localparam STATE_RUN = 4'b0001;
  // Add other states as necessary

  reg      [2:0] reset_count;
  reg     [3:0] state;
  reg     [35:0] pc;
  reg     [31:0] inst;           // Instruction register
  reg     [15:0] inst_code;      // Exception code from fetch
  reg     [63:0] hold;           // Holds an instruction or register value
  reg     [15:0] hold_code;      // Exception code (if instruction)
  reg     [63:0] cycle_count;
  reg     [63:0] inst_count;
  reg            ss_trig_save;   // Used to compute single-step trap triggered
  reg     [63:0] digital_out_reg;
  reg     [7:0]  serial_out_reg;
  reg            serial_out_start;
  reg     [63:0] m_data_save;
  reg     [15:0] m_code_save;
  reg            clock_enable;
  reg      [7:0] clock_enable_counter;

  //  --------------------  Not registers  --------------------
  wire         reset;
  reg    [3:0] next_state;
  reg          in_final_state_of_instr;
  wire         is_sleep;                   // Indicates SLEEP_STATE
  wire         is_illegal;                 // Indicates ILLEGAL_STATE
  wire         is_load_store;              // Indicates RD_WR_STATE
  wire         is_branch_taken;            // Indicates BRANCH_STATE
  wire         is_fence;                   // Indicates FENCE_STATE
  reg          exception_triggered;        // Indicates EXCEPT_STATE (no update)
  reg          singlestep_trap_triggered;  // Indicates EXCEPT_STATE (perform updates)
  reg          timer_interrupt_triggered;  // Indicates EXCEPT_STATE (perform updates)
  reg          restart_instruction;        // Driven HIGH by RESTART

endmodule // Add this line to mark the end of the module
