module bcd_counter_top (
    input  wire         clk,    // Conectado a W22 (LVCMOS33)
    input  wire         reset,  // Conectado a U18 (LVCMOS33)
    input  wire         btn,    // Botón de inicio (por ejemplo, btn[0] asignado a G13, LVCMOS12)
    output wire [3:0]   an,     // Ánodos del display (J55.1, J55.3, J55.5, J55.7; LVCMOS18)
    output wire [7:0]   sseg    // Segmentos del display (J55.2, J55.4, J55.6, J55.8, J87.1, J87.3, J87.5, J87.7; LVCMOS18)
);

  // Divisor de reloj para desacelerar la actualización del contador
  reg [23:0] clk_div;
  always @(posedge clk or posedge reset) begin
    if (reset)
      clk_div <= 24'd0;
    else
      clk_div <= clk_div + 1;
  end
  
  // Contador binario de 13 bits (se incrementa en cada reinicio del divisor)
  reg [12:0] bin_counter;
  always @(posedge clk or posedge reset) begin
    if (reset)
      bin_counter <= 13'd0;
    else if (clk_div == 24'd0)  // Cada vez que el divisor se reinicia
      bin_counter <= bin_counter + 1;
  end
  
  // La señal start se genera con el botón (se asume que btn está debounced)
  wire start = btn;
  
  // Instanciación del conversor bin2bcd
  wire ready, done_tick;
  wire [3:0] bcd3, bcd2, bcd1, bcd0;
  
  bin2bcd converter (
    .clk(clk),
    .reset(reset),
    .start(start),
    .bin(bin_counter),
    .ready(ready),
    .done_tick(done_tick),
    .bcd3(bcd3),
    .bcd2(bcd2),
    .bcd1(bcd1),
    .bcd0(bcd0)
  );
  
  // Instanciación del multiplexor/decodificador para el display de 7 segmentos
  // Se asume que el módulo disp_hex_mux está diseñado para recibir 4 dígitos BCD (hex3, hex2, hex1, hex0)
  // y generar las señales de ánodos (an) y segmentos (sseg).
  disp_hex_mux display_mux (
    .clk(clk),
    .reset(reset),
    .hex3(bcd3),
    .hex2(bcd2),
    .hex1(bcd1),
    .hex0(bcd0),
    .dp_in(4'b1111),   // Apagar puntos decimales (o ajustarlos según desees)
    .an(an),
    .sseg(sseg)
  );
  
endmodule