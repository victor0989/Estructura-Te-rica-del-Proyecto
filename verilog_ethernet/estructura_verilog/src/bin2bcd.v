module bin2bcd (
    input  wire         clk,       // Conectado a W22 (LVCMOS33)
    input  wire         reset,     // Conectado a U18 (LVCMOS33)
    input  wire         start,     // Se puede conectar al botón btn[0]
    input  wire [12:0]  bin,       // Número binario de 13 bits (por ejemplo, desde un contador)
    output reg          ready,     // Indica que el módulo está listo para iniciar
    output reg          done_tick, // Pulso de finalización de la conversión
    output wire [3:0]   bcd3,      // Dígito de millar
    output wire [3:0]   bcd2,      // Dígito de centena
    output wire [3:0]   bcd1,      // Dígito de decena
    output wire [3:0]   bcd0       // Dígito de unidad
);

  // Estado de la FSM
  localparam [1:0]
    IDLE = 2'b00,
    OP   = 2'b01,
    DONE = 2'b10;
    
  // Registros de estado y datos
  reg [1:0]  state_reg, state_next;
  reg [12:0] p2s_reg, p2s_next;   // Registro de desplazamiento para el binario
  reg [3:0]  count_reg, count_next; // Contador de ciclos (de 13 iteraciones)
  
  // Registros para los dígitos BCD
  reg [3:0]  bcd3_reg, bcd3_next;
  reg [3:0]  bcd2_reg, bcd2_next;
  reg [3:0]  bcd1_reg, bcd1_next;
  reg [3:0]  bcd0_reg, bcd0_next;
  
  // Corrección: si el dígito > 4 se le suma 3
  wire [3:0] bcd0_corr = (bcd0_reg > 4) ? (bcd0_reg + 3) : bcd0_reg;
  wire [3:0] bcd1_corr = (bcd1_reg > 4) ? (bcd1_reg + 3) : bcd1_reg;
  wire [3:0] bcd2_corr = (bcd2_reg > 4) ? (bcd2_reg + 3) : bcd2_reg;
  wire [3:0] bcd3_corr = (bcd3_reg > 4) ? (bcd3_reg + 3) : bcd3_reg;
  
  // Lógica combinacional de next-state y datos
  always @(*) begin
    // Valores por defecto
    state_next  = state_reg;
    ready       = 1'b0;
    done_tick   = 1'b0;
    count_next  = count_reg;
    p2s_next    = p2s_reg;
    bcd3_next   = bcd3_reg;
    bcd2_next   = bcd2_reg;
    bcd1_next   = bcd1_reg;
    bcd0_next   = bcd0_reg;
    
    case (state_reg)
      IDLE: begin
        ready = 1'b1;
        if (start) begin
          state_next = OP;
          p2s_next   = bin;     // Cargar el número binario
          count_next = 4'd13;    // 13 iteraciones para 13 bits
          bcd3_next  = 4'd0;
          bcd2_next  = 4'd0;
          bcd1_next  = 4'd0;
          bcd0_next  = 4'd0;
        end
      end
      
      OP: begin
        // Se realiza el desplazamiento y corrección simultánea:
        bcd0_next = {bcd0_corr[2:0], p2s_reg[12]};
        bcd1_next = {bcd1_corr[2:0], bcd0_reg[3]};
        bcd2_next = {bcd2_corr[2:0], bcd1_reg[3]};
        bcd3_next = {bcd3_corr[2:0], bcd2_reg[3]};
        p2s_next  = p2s_reg << 1;
        count_next = count_reg - 1;
        if (count_reg == 0)
          state_next = DONE;
      end
      
      DONE: begin
        done_tick = 1'b1;
        state_next = IDLE;
      end
      
      default: state_next = IDLE;
    endcase
  end
  
  // Lógica secuencial
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state_reg <= IDLE;
      p2s_reg   <= 13'd0;
      count_reg <= 4'd0;
      bcd3_reg  <= 4'd0;
      bcd2_reg  <= 4'd0;
      bcd1_reg  <= 4'd0;
      bcd0_reg  <= 4'd0;
    end
    else begin
      state_reg <= state_next;
      p2s_reg   <= p2s_next;
      count_reg <= count_next;
      bcd3_reg  <= bcd3_next;
      bcd2_reg  <= bcd2_next;
      bcd1_reg  <= bcd1_next;
      bcd0_reg  <= bcd0_next;
    end
  end
  
  // Asignación de salidas
  assign bcd3 = bcd3_reg;
  assign bcd2 = bcd2_reg;
  assign bcd1 = bcd1_reg;
  assign bcd0 = bcd0_reg;
  
endmodule

