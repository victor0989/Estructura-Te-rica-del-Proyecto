`timescale 1 ns / 1 ps

module myip_v1_0_S00_AXI #(
    parameter integer C_S_AXI_DATA_WIDTH = 32,
    parameter integer C_S_AXI_ADDR_WIDTH = 4
)(
    // Señales de usuario
    input  wire                     SignalEnable,
    output wire                     SignalOut,
    input  wire [2:0]               PatternIn,
    output wire [9:0]               PatternCountTotal,         // se asigna a internal_count
    output wire                     PatternCountDone,          // se activa cuando internal_count >= 1023
    output wire                     PatternCountDone_interrupt, // se asigna al valor de interrupt_signal
    
    // Interfaz AXI4-Lite
    input  wire                     S_AXI_ACLK,
    input  wire                     S_AXI_ARESETN,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] S_AXI_AWADDR,
    input  wire [2:0]               S_AXI_AWPROT,
    input  wire                     S_AXI_AWVALID,
    output reg                      S_AXI_AWREADY,
    input  wire [C_S_AXI_DATA_WIDTH-1:0] S_AXI_WDATA,
    input  wire [(C_S_AXI_DATA_WIDTH/8)-1:0] S_AXI_WSTRB,
    input  wire                     S_AXI_WVALID,
    output reg                      S_AXI_WREADY,
    output reg [1:0]                S_AXI_BRESP,
    output reg                      S_AXI_BVALID,
    input  wire                     S_AXI_BREADY,
    input  wire [C_S_AXI_ADDR_WIDTH-1:0] S_AXI_ARADDR,
    input  wire [2:0]               S_AXI_ARPROT,
    input  wire                     S_AXI_ARVALID,
    output reg                      S_AXI_ARREADY,
    output reg [C_S_AXI_DATA_WIDTH-1:0] S_AXI_RDATA,
    output reg [1:0]                S_AXI_RRESP,
    output reg                      S_AXI_RVALID,
    input  wire                     S_AXI_RREADY
);

    // Registros internos
    reg [C_S_AXI_DATA_WIDTH-1:0] reg_data;
    reg [9:0] internal_count;
    reg       interrupt_signal;

    // Escritura (Write) de direcciones y datos
    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            S_AXI_AWREADY <= 1'b0;
            S_AXI_WREADY  <= 1'b0;
            S_AXI_BVALID  <= 1'b0;
            S_AXI_BRESP   <= 2'b00;
            reg_data      <= {C_S_AXI_DATA_WIDTH{1'b0}};
        end else begin
            // Handshake en canal de dirección
            if (!S_AXI_AWREADY && S_AXI_AWVALID)
                S_AXI_AWREADY <= 1'b1;
            else
                S_AXI_AWREADY <= 1'b0;
            
            // Handshake en canal de datos
            if (!S_AXI_WREADY && S_AXI_WVALID) begin
                S_AXI_WREADY <= 1'b1;
                reg_data     <= S_AXI_WDATA;
            end else begin
                S_AXI_WREADY <= 1'b0;
            end
            
            // Genera respuesta de escritura cuando ambos canales (AW y W) son aceptados
            if (S_AXI_AWREADY && S_AXI_AWVALID && S_AXI_WREADY && S_AXI_WVALID) begin
                S_AXI_BVALID <= 1'b1;
                S_AXI_BRESP  <= 2'b00; // respuesta OKAY
            end else if (S_AXI_BVALID && S_AXI_BREADY) begin
                S_AXI_BVALID <= 1'b0;
            end
        end
    end

    // Lectura (Read) de direcciones y datos
    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            S_AXI_ARREADY <= 1'b0;
            S_AXI_RVALID  <= 1'b0;
            S_AXI_RRESP   <= 2'b00;
            S_AXI_RDATA   <= {C_S_AXI_DATA_WIDTH{1'b0}};
        end else begin
            if (!S_AXI_ARREADY && S_AXI_ARVALID)
                S_AXI_ARREADY <= 1'b1;
            else
                S_AXI_ARREADY <= 1'b0;
            
            if (S_AXI_ARREADY && S_AXI_ARVALID) begin
                S_AXI_RDATA <= reg_data;
                S_AXI_RRESP <= 2'b00; // respuesta OKAY
                S_AXI_RVALID <= 1'b1;
            end else if (S_AXI_RVALID && S_AXI_RREADY) begin
                S_AXI_RVALID <= 1'b0;
            end
        end
    end

    // Lógica de usuario: contar cuando PatternIn es igual a 3'b101
    always @(posedge S_AXI_ACLK) begin
        if (!S_AXI_ARESETN) begin
            internal_count <= 10'd0;
            interrupt_signal <= 1'b0;
        end else if (SignalEnable) begin
            // Si PatternIn equivale a 101, incrementar el contador
            if (PatternIn == 3'b101)
                internal_count <= internal_count + 1;
                
            // Si se alcanza o sobrepasa el tope (1023), activar la señal de interrupción
            if (internal_count >= 10'd1023)
                interrupt_signal <= 1'b1;
            else
                interrupt_signal <= 1'b0;
        end
    end

    // Asignar salidas de usuario
    assign PatternCountTotal = internal_count;
    assign PatternCountDone  = (internal_count >= 10'd1023);
    assign PatternCountDone_interrupt = interrupt_signal;
    assign SignalOut = SignalEnable;

endmodule

