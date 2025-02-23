module REGS (
    input  wire         clock,
    input  wire         clock_enable,
    input  wire         reset_in,
    input  wire         mmu_ready,

    input  wire   [3:0] reg1_addr,
    input  wire   [3:0] reg2_addr,
    input  wire   [3:0] reg3_addr,

    output wire  [63:0] reg1_data,
    output wire  [63:0] reg2_data,
    output wire  [63:0] reg3_data,
    output wire  [63:0] regLR_data,
    output wire  [63:0] regSP_data,

    input  wire   [3:0] regD_addr,
    input  wire  [63:0] regD_data,
    input  wire         reg_write_en
);       

    // Registro de 16 x 64 bits
    reg [63:0] regs [15:0];

    // Inicialización del registro 0 a 0
    assign reg1_data = (reg1_addr == 4'd0) ? 64'b0 : regs[reg1_addr];
    assign reg2_data = (reg2_addr == 4'd0) ? 64'b0 : regs[reg2_addr];
    assign reg3_data = (reg3_addr == 4'd0) ? 64'b0 : regs[reg3_addr];
    assign regLR_data = regs[14];
    assign regSP_data = regs[15];

    // Generar bloques always para cada registro
    genvar k;
    generate
        for (k = 1; k < 16; k = k + 1) begin : reg_block
            always @(posedge clock) begin
                if (clock_enable) begin
                    if (reset_in) begin
                        regs[k] <= 64'b0;
                    end else if (reg_write_en && (regD_addr == k) && mmu_ready) begin
                        regs[k] <= regD_data;
                    end
                end
            end
        end
    endgenerate
endmodule

