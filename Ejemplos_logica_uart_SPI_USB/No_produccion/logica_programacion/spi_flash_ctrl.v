`timescale 1ns/1ps

module spi_flash_ctrl 
  #(
    // Parámetro para definir el número de ciclos de reloj por bit (ajusta según la frecuencia deseada)
    parameter CLKS_PER_BIT = 8
  )
  (
    input         clock,
    input         start,       // Señal de inicio de la transacción SPI
    input  [7:0]  command,     // Comando SPI (por ejemplo, 8'h03 para lectura)
    input  [23:0] address,     // Dirección de 24 bits
    output reg [7:0] data_out, // Dato recibido del SPI Flash (en este ejemplo se lee 1 byte)
    output reg    active,      // Alto mientras la transacción está activa
    output reg    done,        // Pulse alto un ciclo al terminar la transacción
    // Señales dedicadas al bus SPI
    output reg    spi_clk,
    output reg    spi_mosi,
    input         spi_miso,
    output reg    spi_cs
  );

  // Definición de los estados del FSM
  localparam IDLE      = 3'b000,
             SEND_CMD  = 3'b001,
             SEND_ADDR = 3'b010,
             READ_DATA = 3'b011,
             STOP      = 3'b100;

  reg [2:0] state = IDLE;      // Estado actual
  reg [7:0] shift_reg;         // Registro de desplazamiento para comando/dato
  reg [2:0] bit_index;         // Índice del bit en transmisión/recepción
  reg [1:0] addr_byte_cnt;     // Contador para los 3 bytes de dirección
  reg [15:0] clk_counter;      // Contador para generar CLKS_PER_BIT ciclos

  always @(posedge clock) begin
    case (state)
      
      // Estado de reposo
      IDLE: begin
        spi_cs      <= 1;   // CS inactivo
        spi_clk     <= 0;
        spi_mosi    <= 0;
        active      <= 0;
        done        <= 0;
        clk_counter <= 0;
        bit_index   <= 7;
        addr_byte_cnt <= 0;
        // Cuando se levanta "start", se prepara la transacción
        if (start) begin
          active      <= 1;
          spi_cs      <= 0;         // Activa el chip select
          shift_reg   <= command;   // Carga el comando a enviar
          state       <= SEND_CMD;
        end 
        else begin
          state <= IDLE;
        end
      end  // IDLE

      // ENVIAR COMANDO SPI (8 bits)
      SEND_CMD: begin
        if (clk_counter < CLKS_PER_BIT - 1) begin
          clk_counter <= clk_counter + 1;
          state       <= SEND_CMD;
        end 
        else begin
          clk_counter <= 0;
          // Generamos un pulso de reloj SPI (invertir cada ciclo útil)
          spi_clk  <= ~spi_clk;
          // Actualizamos la salida de MOSI con el bit correspondiente
          spi_mosi <= shift_reg[bit_index];
          if (bit_index == 0) begin
            // Terminado el envío del comando; preparar la dirección
            bit_index      <= 7;
            addr_byte_cnt  <= 0;
            // Cargar el primer byte de la dirección (MSB)
            shift_reg      <= address[23:16];
            state          <= SEND_ADDR;
          end 
          else begin
            bit_index <= bit_index - 1;
          end
        end
      end  // SEND_CMD

      // ENVIAR DIRECCIÓN SPI (24 bits divididos en 3 bytes)
      SEND_ADDR: begin
        if (clk_counter < CLKS_PER_BIT - 1) begin
          clk_counter <= clk_counter + 1;
          state       <= SEND_ADDR;
        end 
        else begin
          clk_counter <= 0;
          spi_clk  <= ~spi_clk;
          spi_mosi <= shift_reg[bit_index];
          if (bit_index == 0) begin
            if (addr_byte_cnt == 0) begin
              // Cargar el segundo byte de dirección
              shift_reg     <= address[15:8];
              addr_byte_cnt <= 1;
              bit_index     <= 7;
            end 
            else if (addr_byte_cnt == 1) begin
              // Cargar el tercer byte de dirección
              shift_reg     <= address[7:0];
              addr_byte_cnt <= 2;
              bit_index     <= 7;
            end 
            else begin
              // Finalizado el envío de la dirección, pasar a la lectura de datos
              bit_index <= 7;
              state     <= READ_DATA;
            end
          end 
          else begin
            bit_index <= bit_index - 1;
          end
        end
      end  // SEND_ADDR

      // LEER UN BYTE DE DATOS DEL FLASH SPI
      READ_DATA: begin
        if (clk_counter < CLKS_PER_BIT - 1) begin
          clk_counter <= clk_counter + 1;
          state       <= READ_DATA;
        end 
        else begin
          clk_counter <= 0;
          spi_clk  <= ~spi_clk;
          // Suponiendo que la captura del dato se hace en el flanco ascendente:
          // Aquí se toma el valor de spi_miso y se almacena en el registro de desplazamiento
          if (spi_clk == 0) begin
            shift_reg[bit_index] <= spi_miso;
          end
          if (bit_index == 0) begin
            // Al terminar, se asigna el dato leído a la salida
            data_out <= shift_reg;
            state    <= STOP;
          end 
          else begin
            bit_index <= bit_index - 1;
          end
        end
      end  // READ_DATA

      // TERMINAR LA TRANSACCIÓN
      STOP: begin
        spi_cs <= 1;   // Desactiva el chip select
        active <= 0;
        done   <= 1;   // Señala que la transacción ha finalizado (pulse de un ciclo)
        state  <= IDLE;
      end
      
      default: state <= IDLE;
      
    endcase
  end

endmodule
