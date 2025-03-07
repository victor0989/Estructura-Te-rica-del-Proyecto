`timescale 1ns/1ps

module tb_spi_flash_ctrl;
  reg         clock;
  reg         start;
  reg  [7:0]  command;
  reg  [23:0] address;
  wire [7:0]  data_out;
  wire        active;
  wire        done;
  wire        spi_clk;
  wire        spi_mosi;
  reg         spi_miso;  // Se simula la salida del flash
  wire        spi_cs;
  
  // Instanciar el diseño
  spi_flash_ctrl #(.CLKS_PER_BIT(8)) dut (
    .clock(clock),
    .start(start),
    .command(command),
    .address(address),
    .data_out(data_out),
    .active(active),
    .done(done),
    .spi_clk(spi_clk),
    .spi_mosi(spi_mosi),
    .spi_miso(spi_miso),
    .spi_cs(spi_cs)
  );
  
  // Generación del reloj (periodo de 10 ns)
  initial begin
    clock = 0;
    forever #5 clock = ~clock;
  end

  // Simulación del comportamiento de la salida MISO del flash:
  // Aquí se simula que el flash responde con un byte fijo (por ejemplo 8'hA5).
  // Se usa un registro para recorrer los bits del dato (MSB primero).
  reg [7:0] flash_data = 8'hA5;
  reg [2:0] tb_bit_index = 7;
  
  always @(negedge spi_clk) begin
    if (spi_cs == 0) begin
      spi_miso <= flash_data[tb_bit_index];
      if (tb_bit_index == 0)
        tb_bit_index <= 7;
      else
        tb_bit_index <= tb_bit_index - 1;
    end
    else begin
      spi_miso <= 0;
    end
  end
  
  // Secuencia de prueba
  initial begin
    // Inicializar señales
    start   = 0;
    command = 8'h03;     // Comando de lectura en muchos SPI Flash
    address = 24'h001234;
    
    // Esperar algunos ciclos
    #20;
    // Iniciar transacción
    start = 1;
    #10;
    start = 0;
    
    // Esperar a que se complete la transacción
    wait (done);
    #20;
    $display("Dato leído: %h", data_out);
    
    $finish;
  end
  
endmodule
