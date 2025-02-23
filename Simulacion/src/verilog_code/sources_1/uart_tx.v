module uart_tx
  #(parameter CLKS_PER_BIT = 434)  // Establecer un valor predeterminado para CLKS_PER_BIT
  (
    input       clock,
    input       i_data_avail,     // Si está en ALTO, iniciar la transmisión
    input [7:0] i_data_byte,      // Se guarda cuando i_data_avail está en ALTO
    output reg  o_active,         // ALTO mientras está ocupado transmitiendo
    output reg  o_tx,             // Conectar esto a la línea Tx
    output reg  o_done            // ALTO durante un ciclo de reloj cuando complete
  );

  localparam IDLE_STATE     = 2'b00;
  localparam START_STATE    = 2'b01;
  localparam SEND_BIT_STATE = 2'b10;
  localparam STOP_STATE     = 2'b11;

  reg [1:0]  state          = IDLE_STATE;  // Inicializar state
  reg [15:0] counter        = 0;
  reg [2:0]  bit_index      = 0;
  reg [7:0]  data_byte      = 0;

  always @(posedge clock)
    begin

      case (state)
      
        IDLE_STATE :
          begin
            o_tx      <= 1;
            o_done    <= 0;
            counter   <= 0;
            bit_index <= 0;

            if (i_data_avail == 1)
              begin
                o_active  <= 1;
                data_byte <= i_data_byte;
                state     <= START_STATE;
              end
            else
              begin
                state    <= IDLE_STATE;
                o_active <= 0;
              end
          end

        // Enviar bit de inicio
        START_STATE :
          begin
            o_tx <= 0;
            // Esperar CLKS_PER_BIT-1 ciclos de reloj para finalizar el bit de inicio
            if (counter < CLKS_PER_BIT-1)
              begin
                counter <= counter + 16'd1;
                state   <= START_STATE;
              end
            else
              begin
                counter <= 0;
                state   <= SEND_BIT_STATE;
              end
          end

        // Esperar CLKS_PER_BIT-1 ciclos de reloj para finalizar cada bit de datos
        SEND_BIT_STATE :
          begin
            o_tx <= data_byte[bit_index];
            if (counter < CLKS_PER_BIT-1)
              begin
                counter <= counter + 16'd1;
                state   <= SEND_BIT_STATE;
              end
            else
              begin
                counter <= 0;
                // Verificar si hemos enviado todos los bits
                if (bit_index < 7)
                  begin
                    bit_index <= bit_index + 3'd1;
                    state     <= SEND_BIT_STATE;
                  end
                else
                  begin
                    state     <= STOP_STATE;
                  end
              end
          end

        // Enviar bit de parada
        STOP_STATE :
          begin
            o_tx <= 1;
            // Esperar CLKS_PER_BIT-1 ciclos de reloj para finalizar el bit de parada
            if (counter < CLKS_PER_BIT-1)
              begin
                counter <= counter + 16'd1;
                state   <= STOP_STATE;
              end
            else
              begin
                o_done   <= 1;    // Levantar o_done para el ciclo de reloj final
                o_active <= 0;
                state    <= IDLE_STATE;
              end
          end

        default :
          state <= IDLE_STATE;

      endcase
    end

endmodule

