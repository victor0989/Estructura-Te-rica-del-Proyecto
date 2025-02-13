// Módulo pico_sio: integra la unidad KCPSM3 y la ROM
module pico_sio (
  input  wire       clk,    // Se conecta al pin definido en el XDC (p.ej. PACKAGE_PIN W22, LVCMOS33)
  input  wire       reset,  // Señal de reset (puede conectarse a otro pin según tu criterio)
  input  wire [7:0] sw,     // Interruptores o entradas digitales; asigna en el XDC el pin deseado
  output wire [7:0] led     // Salida para LEDs; asigna en el XDC los pines de tus LEDs (ej. LED_0, LED_1, LED_2...)
);

  // Declaración de señales internas
  wire [9:0]  address;
  wire [17:0] instruction;
  // Si deseas usar la funcionalidad de lectura/escritura vía puerto, define estos buses:
  wire [7:0]  port_id;
  wire [7:0]  in_port;
  wire [7:0]  out_port;
  wire        write_strobe;

  // Registro para la salida LED
  reg  [7:0] led_reg;

  // Instanciación del procesador PicoBlaze (KCPSM3)
  kcpsm3 proc_unit (
    .clk          (clk),
    .reset        (reset),
    .address      (address),
    .instruction  (instruction),
    .port_id      (port_id),      // Puedes conectar o dejar sin conectar según tu diseño
    .write_strobe (write_strobe),
    .out_port     (out_port),
    .read_strobe  (),             // No usado en este ejemplo
    .in_port      (in_port),
    .interrupt    (1'b0),
    .interrupt_ack(1'b0)
  );

  // Instanciación de la ROM de programa
  sio_rom rom_unit (
    .clk         (clk),
    .address     (address),
    .instruction (instruction)
  );

  // Interfaz de salida: actualiza los LEDs cuando se activa write_strobe
  always @(posedge clk) begin
    if (write_strobe)
      led_reg <= out_port;
  end

  assign led = led_reg;

  // Interfaz de entrada: los interruptores se leen en el bus in_port
  assign in_port = sw;

endmodule

