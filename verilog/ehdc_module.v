`timescale 1ns / 1ps
module ehdc_module (
    input  wire         clk,               // Reloj de sistema
    input  wire         reset,             // Reset del sistema
    input  wire [15:0]  cam_data_in,       // Datos de entrada de la cámara
    input  wire         cam_clk,           // Reloj de la cámara
    input  wire         cam_sync,          // Sincronización de la cámara
    output wire [15:0]  cam_data_out,      // Datos procesados de salida
    input  wire [15:0]  pos_x,             // Posición en eje x
    input  wire [15:0]  pos_y,             // Posición en eje y
    input  wire [15:0]  pos_z,             // Posición en eje z
    output wire         tmds_clk_p,        // HDMI TMDS clock positive
    output wire         tmds_clk_n,        // HDMI TMDS clock negative
    output wire [2:0]   tmds_data_p,       // HDMI TMDS data positive
    output wire [2:0]   tmds_data_n,       // HDMI TMDS data negative
    input  wire         temp_sensor,       // Sensor de temperatura
    input  wire         press_sensor,      // Sensor de presión
    input  wire         current_sensor,    // Sensor de corriente
    output wire         heater_control,    // Control del calentador
    output wire         watchdog_reset,    // Señal de reset del watchdog
    output wire [7:0]   status_leds,       // LEDs de estado
    input  wire         zoom_control,      // Control del zoom de la cámara
    input  wire         power_control,     // Control de alimentación
    input  wire [1:0]   btn,               // Botones para detección de flancos
    output wire [3:0]   an,                // Ánodos de display de 7 segmentos
    output wire [7:0]   sseg               // Segmentos de display de 7 segmentos
);

    //==========================================================================
    // Declaración de señales internas
    //--------------------------------------------------------------------------
    // Corregimos el error declarando video_data como un bus de 8 bits,
    // en lugar de un array. Así se puede indexar o conectar directamente.
    wire [7:0] video_data;
    // Declaramos la señal de salida del codificador TMDS (usualmente 10 bits)
    wire [9:0] tmds_encoded;
    
    //==========================================================================
    // Lógica de control de alimentación
    //--------------------------------------------------------------------------
    reg power_state;
    always @(posedge clk or posedge reset) begin
        if (reset)
            power_state <= 1'b0;
        else if (power_control)
            power_state <= ~power_state;
    end

    //==========================================================================
    // Lógica de telemetría de estado
    //--------------------------------------------------------------------------
    reg [15:0] temperature, pressure, current;
    always @(posedge clk) begin
        // Aquí se asume que los sensores son señales de 1 bit o que se adaptan;
        // ajusta según el ancho real de tus sensores.
        temperature <= {8'b0, temp_sensor};
        pressure    <= {8'b0, press_sensor};
        current     <= {8'b0, current_sensor};
    end

    //==========================================================================
    // Lógica del watchdog timer
    //--------------------------------------------------------------------------
    reg [31:0] watchdog_counter;
    always @(posedge clk or posedge reset) begin
        if (reset)
            watchdog_counter <= 32'b0;
        else
            watchdog_counter <= watchdog_counter + 1;
    end
    assign watchdog_reset = (watchdog_counter == 32'hFFFFFFFF);

    //==========================================================================
    // Control del zoom de la cámara
    //--------------------------------------------------------------------------
    reg [15:0] zoom_level;
    always @(posedge clk or posedge reset) begin
        if (reset)
            zoom_level <= 16'b0;
        else if (zoom_control)
            zoom_level <= zoom_level + 1;
    end

    //==========================================================================
    // Control del calentador
    //--------------------------------------------------------------------------
    assign heater_control = (temperature < 16'd300); // Ejemplo: encender si temp < 300

    //==========================================================================
    // Módulo de cámara
    //--------------------------------------------------------------------------
    camera_module cam_mod (
        .clk          (clk),
        .cam_data_in  (cam_data_in),
        .cam_data_out (cam_data_out),
        .cam_clk      (cam_clk),
        .cam_sync     (cam_sync),
        .pos_x        (pos_x),
        .pos_y        (pos_y),
        .pos_z        (pos_z)
    );

    //==========================================================================
    // Conversión de datos térmicos a formato de video
    //--------------------------------------------------------------------------
    thermal_to_video converter (
        .clk         (clk),
        .thermal_data(cam_data_out),
        .rgb_data    (video_data)  // Se conecta el bus de 8 bits video_data
    );

    //==========================================================================
    // Codificación TMDS para HDMI
    //--------------------------------------------------------------------------
    tmds_encoder tmds_enc (
        .clk        (clk),
        .video_data (video_data),  // Se utiliza el bus completo sin indexar, pues ya es de 8 bits
        .video_ctrl (1'b0),        // Ejemplo: sin señal de control
        .tmds_data  (tmds_encoded)
    );

    //==========================================================================
    // Módulo HDMI para transmitir los datos codificados
    //--------------------------------------------------------------------------
    hdmi_module hdmi_mod (
        .pix_clk    (clk),            // Se asume que clk es adecuado como pixel clock
        .video_data (tmds_encoded),   // Se usa la señal codificada
        .tmds_clk_p (tmds_clk_p),
        .tmds_clk_n (tmds_clk_n),
        .tmds_data_p(tmds_data_p),
        .tmds_data_n(tmds_data_n)
    );

    //==========================================================================
    // LEDs de estado
    //--------------------------------------------------------------------------
    assign status_leds = {power_state, temperature[7:0]};

    //==========================================================================
    // Circuito de verificación y detección de flancos
    //--------------------------------------------------------------------------
    reg [7:0] b_reg, d_reg;
    wire [7:0] b_next, d_next;
    reg btn_reg, db_reg;
    wire db_level, db_tick, btn_tick, clr;

    // Instancia del módulo de multiplexación del display de 7 segmentos
    disp_hex_mux disp_unit (
        .clk   (clk),
        .reset (reset),
        .hex3  (b_reg[7:4]),
        .hex2  (b_reg[3:0]),
        .hex1  (d_reg[7:4]),
        .hex0  (d_reg[3:0]),
        .dp_in (4'b1011),
        .an    (an),
        .sseg  (sseg)
    );

    // Instancia del circuito de debouncing
    db_fsm db_unit (
        .clk   (clk),
        .reset (reset),
        .sw    (btn[1]),
        .db    (db_level)
    );

    // Detección de flancos
    always @(posedge clk) begin
        btn_reg <= btn[1];
        db_reg  <= db_level;
    end
    assign btn_tick = ~btn_reg & btn[1];
    assign db_tick  = ~db_reg  & db_level;

    //==========================================================================
    // Contadores y reinicio mediante botón
    //--------------------------------------------------------------------------
    assign clr = btn[0];
    always @(posedge clk) begin
        b_reg <= b_next;
        d_reg <= d_next;
    end
    assign b_next = (clr) ? 8'b0 : (btn_tick) ? b_reg + 1 : b_reg;
    assign d_next = (clr) ? 8'b0 : (db_tick)  ? d_reg + 1 : d_reg;

endmodule


