// This module is the UART Receiver.  This receiver is able to
// receive 8 bits of serial data, one start bit, one stop bit,
// and no parity bit (i.e., 8-N-1).  When receive is complete,
// o_data_avail will be driven high for one clock cycle.
//
// Set Parameter CLKS_PER_BIT as follows:
//   CLKS_PER_BIT = (Frequency of clock)/(Frequency of UART)
//     Example: 10 MHz Clock, 115200 baud UART
//              10000000/115200 = 87

module uart_rx
  #(parameter CLKS_PER_BIT = 434)  // Set a default value for CLKS_PER_BIT
  (
    input        clock,
    input        i_rx,
    output reg   o_data_avail,  // Output signals need to be 'reg' if assigned in always block
    output reg [7:0] o_data_byte  // Same here
  );

  localparam IDLE_STATE     = 2'b00;
  localparam START_STATE    = 2'b01;
  localparam GET_BIT_STATE  = 2'b10;
  localparam STOP_STATE     = 2'b11;

  reg        rx_buffer      = 1'b1;
  reg        rx             = 1'b1;

  reg [1:0]  state          = IDLE_STATE;  // Initialize state
  reg [15:0] counter        = 0;
  reg [2:0]  bit_index      = 0;   // where to place the next bit (0...7)
  reg [7:0]  data_byte      = 0;

  // Double-buffer the incoming RX line. This allows it to be
  // used in the UART RX Clock Domain and removes problems caused
  // by metastability.
  always @(posedge clock)
    begin
      rx_buffer <= i_rx;
      rx        <= rx_buffer;
    end

  // The state machine.
  always @(posedge clock)
    begin

      case (state)
      
        IDLE_STATE :
          begin
            o_data_avail <= 0;
            counter    <= 0;
            bit_index  <= 0;
            if (rx == 0)          // Start bit detected
              state <= START_STATE;
            else
              state <= IDLE_STATE;
          end

        // Wait until the middle of the start bit
        START_STATE :
          begin
            if (counter == (CLKS_PER_BIT-1)/2)
              begin
                if (rx == 0)  // If still low at the middle of the start bit...
                  begin
                    counter <= 0;
                    state   <= GET_BIT_STATE;
                  end
                else
                  state <= IDLE_STATE;
              end
            else
              begin
                counter <= counter + 16'd1;
                state   <= START_STATE;
              end
          end

        // Wait CLKS_PER_BIT-1 clock cycles to sample RX for next bit
        GET_BIT_STATE :
          begin
            if (counter < CLKS_PER_BIT-1)
              begin
                counter <= counter + 16'd1;
                state   <= GET_BIT_STATE;
              end
            else
              begin
                counter              <= 0;
                data_byte[bit_index] <= rx;

                // Check if we have received all bits
                if (bit_index < 7)
                  begin
                    bit_index <= bit_index + 3'd1;
                    state     <= GET_BIT_STATE;
                  end
                else
                  begin
                    state     <= STOP_STATE;
                  end
              end
          end

        // Wait until the middle of the Stop bit.
        STOP_STATE :
          begin
            if (counter < CLKS_PER_BIT-1)
              begin
                counter <= counter + 16'd1;
                state   <= STOP_STATE;
              end
            else
              begin
                o_data_avail <= 1;    // Signal that we have a complete byte.
                state      <= IDLE_STATE;
              end
          end

        default:
          state <= IDLE_STATE;

      endcase
    end

endmodule
