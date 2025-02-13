module pico_system (
    input  wire         clk,          // Reloj del sistema (conectado a W22, LVCMOS33)
    input  wire         reset,        // Reset del sistema (conectado a U18, LVCMOS33)
    input  wire [7:0]   sw,           // Interruptores (de usuario; asigna pines aparte)
    input  wire         rx,           // Entrada UART (puedes asignar un pin libre)
    input  wire [1:0]   btn,          // Botones (btn[0] y btn[1] asignados a G13 y A17, LVCMOS12)
    output wire         tx,           // Salida UART (puedes asignar un pin libre)
    output wire [3:0]   an,           // Anodos del display de 7 segmentos (J55.1, J55.3, J55.5, J55.7, LVCMOS18)
    output wire [7:0]   sseg,         // Segmentos del display de 7 segmentos (J55.2, J55.4, J55.6, J55.8, J87.1, J87.3, J87.5, J87.7, LVCMOS18)
    output wire [7:0]   status_leds   // LEDs de estado (conectados a AL11, AL13, AK13, AG13, AE15, AM8, AM9, AM10, LVCMOS12)
);

  //===========================================================================
  // Señales internas del PicoBlaze y su ROM
  //===========================================================================
  wire [9:0]   address;
  wire [17:0]  instruction;
  wire [7:0]   port_id;
  wire [7:0]   out_port;
  reg  [7:0]   in_port;
  wire         write_strobe;
  wire         read_strobe;

  //===========================================================================
  // Señales internas para la interfaz de salida (actualización de registros)
  //===========================================================================
  reg  [6:0]   en_d;  // Bits de habilitación para actualizar registros

  // Registros para el display de 7 segmentos
  reg [7:0] ds3_reg, ds2_reg, ds1_reg, ds0_reg;
  
  //===========================================================================
  // Señales y registros para el manejo de botones (flags)
  //===========================================================================
  reg         btnc_flag_reg, btns_flag_reg;
  wire        btnc_flag_next, btns_flag_next;
  wire        set_btnc_flag, set_btns_flag, clr_btn_flag;

  //===========================================================================
  // Señales para la UART
  //===========================================================================
  wire [7:0]  rx_char;
  wire        rd_uart, rx_empty, tx_full;
  wire        wr_uart;
  wire        rx_not_empty;
  
  //===========================================================================
  // Señales para el multiplicador combinacional
  //===========================================================================
  reg  [7:0]  m_src0_reg, m_src1_reg;
  wire [15:0] prod;

  //===========================================================================
  // Instanciación de módulos de salida y debounce
  //===========================================================================

  // Módulo para multiplexar el display de 7 segmentos
  disp_mux disp_unit (
    .clk   (clk),
    .reset (reset),
    .in3   (ds3_reg),
    .in2   (ds2_reg),
    .in1   (ds1_reg),
    .in0   (ds0_reg),
    .an    (an),
    .sseg  (sseg)
  );

  // Debounce para btn[0] (por ejemplo, botón central)
  debounce btnc_unit (
    .clk     (clk),
    .reset   (reset),
    .sw      (btn[0]),
    .db_tick (set_btnc_flag)
  );

  // Debounce para btn[1] (por ejemplo, botón lateral)
  debounce btns_unit (
    .clk     (clk),
    .reset   (reset),
    .sw      (btn[1]),
    .db_tick (set_btns_flag)
  );

  //===========================================================================
  // Instanciación de la UART
  // (Si no deseas usar UART, puedes desconectar esta parte)
  //===========================================================================
  uart uart_unit (
    .clk      (clk),
    .reset    (reset),
    .rd_uart  (rd_uart),
    .wr_uart  (wr_uart),
    .rx       (rx),
    .w_data   (out_port),
    .tx_full  (tx_full),
    .rx_empty (rx_empty),
    .r_data   (rx_char),
    .tx       (tx)
  );

  //===========================================================================
  // Multiplicador combinacional (usa el operador "*")
  //===========================================================================
  assign prod = m_src0_reg * m_src1_reg;

  //===========================================================================
  // Instanciación del procesador PicoBlaze (KCPSM3) y de la ROM
  //===========================================================================
  kcpsm3 proc_unit (
    .clk          (clk),
    .reset        (1'b0),       // Se asume reset interno; el reset global ya llega a otros módulos
    .address      (address),
    .instruction  (instruction),
    .port_id      (port_id),
    .write_strobe (write_strobe),
    .out_port     (out_port),
    .read_strobe  (read_strobe),
    .in_port      (in_port),
    .interrupt    (1'b0),
    .interrupt_ack(1'b0)
  );

  uart_rom rom_unit (
    .clk         (clk),
    .address     (address),
    .instruction (instruction)
  );

  //===========================================================================
  // Interfaz de salida: Actualización de registros según en_d
  //===========================================================================
  always @(posedge clk) begin
    if (en_d[0])
      ds0_reg <= out_port;
    if (en_d[1])
      ds1_reg <= out_port;
    if (en_d[2])
      ds2_reg <= out_port;
    if (en_d[3])
      ds3_reg <= out_port;
    if (en_d[5])
      m_src0_reg <= out_port;
    if (en_d[6])
      m_src1_reg <= out_port;
  end

  // Decodificación de la señal de habilitación según los 3 bits menos significativos de port_id
  always @(*) begin
    if (write_strobe) begin
      case (port_id[2:0])
        3'b000: en_d = 7'b0000001; // Actualiza ds0_reg
        3'b001: en_d = 7'b0000010; // Actualiza ds1_reg
        3'b010: en_d = 7'b0000100; // Actualiza ds2_reg
        3'b011: en_d = 7'b0001000; // Actualiza ds3_reg
        3'b100: en_d = 7'b0010000; // Actualiza m_src0_reg
        3'b101: en_d = 7'b0100000; // Actualiza m_src1_reg
        default: en_d = 7'b1000000;
      endcase
    end else
      en_d = 7'b0000000;
  end

  // Se asigna la señal de escritura de la UART (wr_uart) a partir del bit 4 de en_d
  assign wr_uart = en_d[4];

  //===========================================================================
  // Interfaz de entrada: multiplexado de datos
  //===========================================================================
  // Actualización de flags de los botones
  always @(posedge clk) begin
    btnc_flag_reg <= btnc_flag_next;
    btns_flag_reg <= btns_flag_next;
  end

  assign btnc_flag_next = (set_btnc_flag) ? 1'b1 :
                          (clr_btn_flag) ? 1'b0 : btnc_flag_reg;
  assign btns_flag_next = (set_btns_flag) ? 1'b1 :
                          (clr_btn_flag) ? 1'b0 : btns_flag_reg;

  // Señal de clear para los flags (cuando se lee el puerto 0x00)
  assign clr_btn_flag = read_strobe && (port_id[2:0] == 3'b000);

  // Señal para lectura del UART (cuando se accede al puerto 0x02)
  assign rd_uart = read_strobe && (port_id[2:0] == 3'b010);

  // rx_not_empty es la negación de rx_empty
  assign rx_not_empty = ~rx_empty;

  // Multiplexado de la entrada (in_port) según el port_id:
  // 0x00: {4'b0, tx_full, rx_not_empty, btns_flag_reg, btnc_flag_reg}
  // 0x01: sw (interruptores)
  // 0x02: dato recibido por UART (rx_char)
  // 0x03: parte baja del producto (prod[7:0])
  // 0x04 (default): parte alta del producto (prod[15:8])
  always @(*) begin
    case (port_id[2:0])
      3'b000: in_port = {4'b0, tx_full, rx_not_empty, btns_flag_reg, btnc_flag_reg};
      3'b001: in_port = sw;
      3'b010: in_port = rx_char;
      3'b011: in_port = prod[7:0];
      default: in_port = prod[15:8];
    endcase
  end

  //===========================================================================
  // Asignación a los status LEDs: en este ejemplo se usan para visualizar out_port
  //===========================================================================
  assign status_leds = out_port;

endmodule
