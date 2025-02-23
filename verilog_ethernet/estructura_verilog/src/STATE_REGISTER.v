module STATE_REGISTER (
    input clock,
    input reset,
    input clock_enable,
    input mmu_ready,
    input is_sleep,
    input is_illegal,
    input is_load_store,
    input is_branch_taken,
    input is_fence,
    input exception_triggered,
    input singlestep_trap_triggered,
    input timer_interrupt_triggered,
    input [35:0] csr_trapvec_from_CSR,
    input [63:0] mmu_result_data,
    input [15:0] mmu_result_code,
    input [63:0] regD_data,
    input [35:0] target_address,
    input [35:0] pc_of_next_inst,
    input [63:0] cycle_count,
    output reg in_final_state_of_instr,
    output reg [35:0] pc,
    output reg [31:0] inst,
    output reg [15:0] inst_code,
    output reg [31:0] inst_count
    // Agrega otras señales de salida según sea necesario
);

    // Definición de los estados del FSM
    localparam BEGIN_STATE       = 4'd0;
    localparam PRE_EXEC_STATE    = 4'd1;
    localparam EXEC_STATE        = 4'd2;
    localparam RD_WR_STATE       = 4'd3;
    localparam BRANCH_STATE      = 4'd4;
    localparam EXCEPT_STATE      = 4'd5;
    localparam FENCE_STATE       = 4'd6;
    localparam SLEEP_STATE       = 4'd7;
    localparam ILLEGAL_STATE     = 4'd8;

    // Señales internas
    reg [3:0] state, next_state;
    reg [63:0] hold;
    reg [15:0] hold_code;

    // Constantes
    localparam NOP_INSTRUCTION = 32'h0000_0013; // Instrucción NOP para RISC-V

    // Computar el siguiente estado desde el estado actual y la información del módulo EXECUTE
    always @* begin
        case (state)
            BEGIN_STATE:    next_state = PRE_EXEC_STATE;
            PRE_EXEC_STATE: next_state = EXEC_STATE;
            EXEC_STATE: begin
                if (is_sleep)
                    next_state = SLEEP_STATE;
                else if (is_illegal)
                    next_state = ILLEGAL_STATE;
                else if (is_load_store)
                    next_state = RD_WR_STATE;
                else if (is_branch_taken)
                    next_state = BRANCH_STATE;
                else
                    next_state = EXEC_STATE;
            end
            RD_WR_STATE: begin
                if (is_fence)
                    next_state = FENCE_STATE;
                else if (is_branch_taken)
                    next_state = BRANCH_STATE;
                else
                    next_state = EXEC_STATE;
            end
            BRANCH_STATE:  next_state = EXEC_STATE;
            EXCEPT_STATE:  next_state = PRE_EXEC_STATE;
            FENCE_STATE:   next_state = PRE_EXEC_STATE;
            SLEEP_STATE:   next_state = SLEEP_STATE;
            ILLEGAL_STATE: next_state = ILLEGAL_STATE;
            default:       next_state = ILLEGAL_STATE;
        endcase

        // Determinar cuándo actualizar los registros y CSRs
        in_final_state_of_instr = (next_state != RD_WR_STATE) &&
                                  (next_state != BRANCH_STATE) &&
                                  (state != SLEEP_STATE) &&
                                  (state != EXCEPT_STATE) &&
                                  (state != FENCE_STATE);

        // Manejo de excepciones y trampas
        if (exception_triggered && ((state == EXEC_STATE) || (state == RD_WR_STATE) || (state == BRANCH_STATE))) begin
            next_state = EXCEPT_STATE;
        end else if ((singlestep_trap_triggered || timer_interrupt_triggered) && (next_state == EXEC_STATE)) begin
            next_state = EXCEPT_STATE;
        end
    end

    // Actualización del estado en cada flanco de reloj
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            state      <= BEGIN_STATE;
            pc         <= 36'h4_0000_0000;     // Dirección de inicio (primer byte de ROM)
            inst       <= NOP_INSTRUCTION;     // Instrucción NOP inicial
            inst_code  <= 16'b0;
            hold       <= 64'b0;
            hold_code  <= 16'b0;
            inst_count <= 32'b0;
        end else if (clock_enable) begin
            if (state == BEGIN_STATE) begin
                if (!mmu_ready || (cycle_count < 64'd2)) begin
                    state <= BEGIN_STATE;
                end else begin
                    state     <= PRE_EXEC_STATE;
                    inst      <= NOP_INSTRUCTION;
                    inst_code <= 16'b0;
                    pc        <= pc + 36'd4;
                end
            end else if (mmu_ready) begin
                if (next_state == EXEC_STATE) begin
                    if (state == RD_WR_STATE) begin
                        inst       <= hold[63:32];
                        inst_code  <= hold_code;
                        inst_count <= inst_count + 32'd1;
                    end else begin
                        inst       <= mmu_result_data[63:32];
                        inst_code  <= mmu_result_code;
                        inst_count <= inst_count + 32'd1;
                    end
                end

                if ((next_state == RD_WR_STATE) || (state == EXEC_STATE)) begin
                    hold      <= mmu_result_data;
                    hold_code <= mmu_result_code;
                end

                if ((next_state == EXEC_STATE) || (next_state == PRE_EXEC_STATE)) begin
                    pc <= pc + 36'd4;
                end else if (next_state == BRANCH_STATE) begin
                    pc   <= target_address + 36'd4;
                    hold <= regD_data;
                end else if (next_state == EXCEPT_STATE) begin
                    pc        <= csr_trapvec_from_CSR;  // Cargar PC desde csr_trapvec
                    inst      <= NOP_INSTRUCTION;       // Instrucción NOP para limpiar
                    inst_code <= 16'b0;
                end else if (next_state == FENCE_STATE) begin
                    pc        <= pc_of_next_inst;       // Dirección de la instrucción siguiente al FENCE
                    inst      <= NOP_INSTRUCTION;
                    inst_code <= 16'b0;
                end

                state <= next_state;
            end
        end
    end

endmodule
