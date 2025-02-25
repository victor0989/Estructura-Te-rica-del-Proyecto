##############################################################################
## Constraints para xczu7ev-ffvc1156-2-e (Active) ZCU106 UltraScale dev kit
###############################################################################

# Reloj principal 'clk' a 125 MHz
set_property PACKAGE_PIN AH12 [get_ports clk]
set_property IOSTANDARD SSTL12 [get_ports clk]
# Definir el reloj 'clk' (asumiendo 125 MHz)
create_clock -name clk -period 8.0 [get_ports clk]

# DDR4 RAM reloj 'clock' a 74.25 MHz
set_property PACKAGE_PIN AH18 [get_ports clock]
set_property IOSTANDARD POD12_DCI [get_ports clock]
create_clock -name clock -period 13.468 [get_ports clock]

# Señal 'clock_enable' a 33.33 MHz
set_property PACKAGE_PIN AJ15 [get_ports clock_enable]
set_property IOSTANDARD POD12_DCI [get_ports clock_enable]
create_clock -name clock_enable -period 30.0 [get_ports clock_enable]

# Señal 'clock_enable' a 33.33 MHzset_property PACKAGE_PIN AJ15      [get_ports clock_enable] ;# Bank  64 VCCO - VCC1V2   - IO_L12N_T1U_N11_GC_64
set_property PACKAGE_PIN AJ16      [get_ports data_out] ;# Bank  64 VCCO - VCC1V2   - IO_L12P_T1U_N10_GC_64
set_property IOSTANDARD  POD12_DCI [get_ports data_out] ;# Bank  64 VCCO - VCC1V2   - IO_L12P_T1U_N10_GC_64
set_property PACKAGE_PIN AK17      [get_ports write_enab] ;# Bank  64 VCCO - VCC1V2   - IO_L11N_T1U_N9_GC_64
set_property IOSTANDARD  POD12_DCI [get_ports write_enab] ;# Bank  64 VCCO - VCC1V2   - IO_L11N_T1U_N9_GC_64
set_property PACKAGE_PIN AJ17      [get_ports data_in] ;# Bank  64 VCCO - VCC1V2   - IO_L11P_T1U_N8_GC_64
set_property IOSTANDARD  POD12_DCI [get_ports data_in] ;# Bank  64 VCCO - VCC1V2   - IO_L11P_T1U_N8_GC_64

# STATE_REGISTER DRAM
set_property PACKAGE_PIN AK14       [get_ports "clock"] ;# Bank  64 VCCO - VCC1V2   - IO_L10N_T1U_N7_QBC_AD4N_64
set_property IOSTANDARD  DIFF_POD12 [get_ports "clock"] ;# Bank  64 VCCO - VCC1V2   - IO_L10N_T1U_N7_QBC_AD4N_64
#set_property PACKAGE_PIN AK15       [get_ports "reset"] ;# Bank  64 VCCO - VCC1V2   - IO_L10P_T1U_N6_QBC_AD4P_64
#set_property IOSTANDARD  DIFF_POD12 [get_ports "reset"] ;# Bank  64 VCCO - VCC1V2   - IO_L10P_T1U_N6_QBC_AD4P_64
set_property PACKAGE_PIN AL18       [get_ports "clock_enable"] ;# Bank  64 VCCO - VCC1V2   - IO_L9N_T1L_N5_AD12N_64
set_property IOSTANDARD  POD12_DCI  [get_ports "clock_enable"] ;# Bank  64 VCCO - VCC1V2   - IO_L9N_T1L_N5_AD12N_64
set_property PACKAGE_PIN AK18       [get_ports "mmu_ready"] ;# Bank  64 VCCO - VCC1V2   - IO_L9P_T1L_N4_AD12P_64
set_property IOSTANDARD  POD12_DCI  [get_ports "mmu_ready"] ;# Bank  64 VCCO - VCC1V2   - IO_L9P_T1L_N4_AD12P_64
set_property PACKAGE_PIN AL15       [get_ports "is_illegal"] ;# Bank  64 VCCO - VCC1V2   - IO_L8N_T1L_N3_AD5N_64
set_property IOSTANDARD  POD12_DCI  [get_ports "is_illegal"] ;# Bank  64 VCCO - VCC1V2   - IO_L8N_T1L_N3_AD5N_64
set_property PACKAGE_PIN AL16       [get_ports "is_load_store"] ;# Bank  64 VCCO - VCC1V2   - IO_L8P_T1L_N2_AD5P_64
set_property IOSTANDARD  POD12_DCI  [get_ports "is_load_store"] ;# Bank  64 VCCO - VCC1V2   - IO_L8P_T1L_N2_AD5P_64
set_property PACKAGE_PIN AL16       [get_ports "is_branch_taken"] ;# Bank  64 VCCO - VCC1V2   - IO_L8P_T1L_N2_AD5P_64
set_property IOSTANDARD  POD12_DCI  [get_ports "is_branch_taken"] ;# Bank  64 VCCO - VCC1V2   - IO_L8P_T1L_N2_AD5P_64
set_property PACKAGE_PIN AL17       [get_ports "is_fence"] ;# Bank  64 VCCO - VCC1V2   - IO_T1U_N12_64
set_property IOSTANDARD  LVCMOS12   [get_ports "is_fence"] ;# Bank  64 VCCO - VCC1V2   - IO_T1U_N12_64
set_property PACKAGE_PIN AM15       [get_ports "exception_triggered"] ;# Bank  64 VCCO - VCC1V2   - IO_L7N_T1L_N1_QBC_AD13N_64
set_property IOSTANDARD  POD12_DCI  [get_ports "exception_triggered"] ;# Bank  64 VCCO - VCC1V2   - IO_L7N_T1L_N1_QBC_AD13N_64
set_property PACKAGE_PIN AM16       [get_ports "singlestep_trap_triggered"] ;# Bank  64 VCCO - VCC1V2   - IO_L7P_T1L_N0_QBC_AD13P_64
set_property IOSTANDARD  POD12_DCI  [get_ports "singlestep_trap_triggered"] ;# Bank  64 VCCO - VCC1V2   - IO_L7P_T1L_N0_QBC_AD13P_64
set_property PACKAGE_PIN AL17       [get_ports "timer_interrupt_triggered"] ;# Bank  64 VCCO - VCC1V2   - IO_T1U_N12_64
set_property IOSTANDARD  LVCMOS12   [get_ports "timer_interrupt_triggered"] ;# Bank  64 VCCO - VCC1V2   - IO_T1U_N12_64
set_property PACKAGE_PIN AP14       [get_ports "csr_trapvec_from_CSR[0]"] ;# Bank  64 VCCO - VCC1V2   - IO_T0U_N12_VRP_64
set_property IOSTANDARD  LVCMOS12   [get_ports "csr_trapvec_from_CSR[0]"] ;# Bank  64 VCCO - VCC1V2   - IO_T0U_N12_VRP_64
#set_property IOSTANDARD           [get_ports "VRP_64"] ;# Bank  64 VCCO - VCC1V2   - IO_T0U_N12_VRP_64
set_property PACKAGE_PIN AN16       [get_ports "mmu_result_data[0]"] ;# Bank  64 VCCO - VCC1V2   - IO_L6N_T0U_N11_AD6N_64
set_property IOSTANDARD  POD12_DCI  [get_ports "mmu_result_data[0]"] ;# Bank  64 VCCO - VCC1V2   - IO_L6N_T0U_N11_AD6N_64
set_property PACKAGE_PIN AN17       [get_ports "mmu_result_code[0]"] ;# Bank  64 VCCO - VCC1V2   - IO_L6P_T0U_N10_AD6P_64
set_property IOSTANDARD  POD12_DCI  [get_ports "mmu_result_code[0]"] ;# Bank  64 VCCO - VCC1V2   - IO_L6P_T0U_N10_AD6P_64
set_property PACKAGE_PIN AP15       [get_ports "regD_data[0]"] ;# Bank  64 VCCO - VCC1V2   - IO_L5N_T0U_N9_AD14N_64
set_property IOSTANDARD  POD12_DCI  [get_ports "regD_data[0]"] ;# Bank  64 VCCO - VCC1V2   - IO_L5N_T0U_N9_AD14N_64
set_property PACKAGE_PIN AP16       [get_ports "target_address[0]"] ;# Bank  64 VCCO - VCC1V2   - IO_L5P_T0U_N8_AD14P_64
set_property IOSTANDARD  POD12_DCI  [get_ports "target_address[0]"] ;# Bank  64 VCCO - VCC1V2   - IO
set_property PACKAGE_PIN AN14       [get_ports "pc_of_next_inst"] ;# Bank  64 VCCO - VCC1V2   - IO_L4N_T0U_N7_DBC_AD7N_64
set_property IOSTANDARD  DIFF_POD12 [get_ports "pc_of_next_inst"] ;# Bank  64 VCCO - VCC1V2   - IO_L4N_T0U_N7_DBC_AD7N_64
set_property PACKAGE_PIN AM14       [get_ports "cycle_count"] ;# Bank  64 VCCO - VCC1V2   - IO_L4P_T0U_N6_DBC_AD7P_64
set_property IOSTANDARD  DIFF_POD12 [get_ports "cycle_count"] ;# Bank  64 VCCO - VCC1V2   - IO_L4P_T0U_N6_DBC_AD7P_64
set_property PACKAGE_PIN AN18       [get_ports "in_final_state_of_instr"] ;# Bank  64 VCCO - VCC1V2   - IO_L3N_T0L_N5_AD15N_64
set_property IOSTANDARD  POD12_DCI  [get_ports "in_final_state_of_instr"] ;# Bank  64 VCCO - VCC1V2   - IO_L3N_T0L_N5_AD15N_64
set_property PACKAGE_PIN AM18       [get_ports "pc"] ;# Bank  64 VCCO - VCC1V2   - IO_L3P_T0L_N4_AD15P_64
set_property IOSTANDARD  POD12_DCI  [get_ports "pc"] ;# Bank  64 VCCO - VCC1V2   - IO_L3P_T0L_N4_AD15P_64
set_property PACKAGE_PIN AP13       [get_ports "inst"] ;# Bank  64 VCCO - VCC1V2   - IO_L2N_T0L_N3_64
set_property IOSTANDARD  POD12_DCI  [get_ports "inst"] ;# Bank  64 VCCO - VCC1V2   - IO_L2N_T0L_N3_64
set_property PACKAGE_PIN AN13       [get_ports "inst_code"] ;# Bank  64 VCCO - VCC1V2   - IO_L2P_T0L_N2_64
set_property IOSTANDARD  POD12_DCI  [get_ports "inst_code"] ;# Bank  64 VCCO - VCC1V2   - IO_L2P_T0L_N2_64
set_property PACKAGE_PIN AP14       [get_ports "inst_count"] ;# Bank  64 VCCO - VCC1V2   - IO_T0U_N12_VRP_64
set_property IOSTANDARD  LVCMOS12   [get_ports "inst_count"] ;# Bank  64 VCCO - VCC1V2   - IO_T0U_N12_VRP_64


#GTH transcievers communication/best for reaction motors
#GPIO, CONTROL_SIGNALS.v
set_property PACKAGE_PIN J6       [get_ports "clock"] ;# Bank  87 VCCO - VCC3V3   - IO_L9N_AD3N_87
set_property IOSTANDARD  LVCMOS33 [get_ports "clock"] ;# Bank  87 VCCO - VCC3V3   - IO_L9N_AD3N_87
set_property PACKAGE_PIN J7       [get_ports "reset_in"] ;# Bank  87 VCCO - VCC3V3   - IO_L9P_AD3P_87
set_property IOSTANDARD  LVCMOS33 [get_ports "digital_input"] ;# Bank  87 VCCO - VCC3V3   - IO_L9P_AD3P_87
set_property PACKAGE_PIN J9       [get_ports "digital_output"] ;# Bank  87 VCCO - VCC3V3   - IO_L8N_HDGC_AD4N_87
set_property IOSTANDARD  LVCMOS33 [get_ports "digital_output"] ;# Bank  87 VCCO - VCC3V3   - IO_L8N_HDGC_AD4N_87
set_property PACKAGE_PIN K9       [get_ports "clk50MHz"] ;# Bank  87 VCCO - VCC3V3   - IO_L8P_HDGC_AD4P_87
set_property IOSTANDARD  LVCMOS33 [get_ports "clk50MHz"] ;# Bank  87 VCCO - VCC3V3   - IO_L8P_HDGC_AD4P_87
set_property PACKAGE_PIN K8       [get_ports "clk125MHz"] ;# Bank  87 VCCO - VCC3V3   - IO_L7N_HDGC_AD5N_87
set_property IOSTANDARD  LVCMOS33 [get_ports "clk125MH"] ;# Bank  87 VCCO - VCC3V3   - IO_L7N_HDGC_AD5N_87
set_property PACKAGE_PIN L8       [get_ports "UART_RX"] ;# Bank  87 VCCO - VCC3V3   - IO_L7P_HDGC_AD5P_87
set_property IOSTANDARD  LVCMOS33 [get_ports "UART_RX"] ;# Bank  87 VCCO - VCC3V3   - IO_L7P_HDGC_AD5P_87
set_property PACKAGE_PIN L10      [get_ports "UART_TX"] ;# Bank  87 VCCO - VCC3V3   - IO_L6N_HDGC_AD6N_87
set_property IOSTANDARD  LVCMOS33 [get_ports "UART_TX"] ;# Bank  87 VCCO - VCC3V3   - IO_L6N_HDGC_AD6N_87
set_property PACKAGE_PIN M10      [get_ports "csr_prevpc_out"] ;# Bank  87 VCCO - VCC3V3   - IO_L6P_HDGC_AD6P_87
set_property IOSTANDARD  LVCMOS33 [get_ports "csr_prevpc_out"] ;# Bank  87 VCCO - VCC3V3   - IO_L6P_HDGC_AD6P_87

set_property PACKAGE_PIN M8       [get_ports "pc_of_current_inst"] ;# Bank  87 VCCO - VCC3V3   - IO_L5N_HDGC_AD7N_87
set_property IOSTANDARD  LVCMOS33 [get_ports "pc_of_current_inst"] ;# Bank  87 VCCO - VCC3V3   - IO_L5N_HDGC_AD7N_87
set_property PACKAGE_PIN M9       [get_ports "csr_cause_out"] ;# Bank  87 VCCO - VCC3V3   - IO_L5P_HDGC_AD7P_87
set_property IOSTANDARD  LVCMOS33 [get_ports "csr_cause_out"] ;# Bank  87 VCCO - VCC3V3   - IO_L5P_HDGC_AD7P_87
set_property PACKAGE_PIN M11      [get_ports "state_out"] ;# Bank  87 VCCO - VCC3V3   - IO_L4N_AD8N_87
set_property IOSTANDARD  LVCMOS33 [get_ports "state_out"] ;# Bank  87 VCCO - VCC3V3   - IO_L4N_AD8N_87


set_property PACKAGE_PIN N11      [get_ports "addr"] ;# Bank  87 VCCO - VCC3V3   - IO_L4P_AD8P_87
set_property IOSTANDARD  LVCMOS33 [get_ports "addr"] ;# Bank  87 VCCO - VCC3V3   - IO_L4P_AD8P_87
set_property PACKAGE_PIN M12      [get_ports "data_val"] ;# Bank  87 VCCO - VCC3V3   - IO_L3N_AD9N_87
set_property IOSTANDARD  LVCMOS33 [get_ports "data_val"] ;# Bank  87 VCCO - VCC3V3   - IO_L3N_AD9N_87


# Señales analógicas (an[3:0]) – LVCMOS18
set_property PACKAGE_PIN A22 [get_ports {an[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {an[3]}]

set_property PACKAGE_PIN A21 [get_ports {an[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {an[2]}]

set_property PACKAGE_PIN A20 [get_ports {an[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {an[1]}]

set_property PACKAGE_PIN A19 [get_ports {an[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {an[0]}]

# Señales de estado Ethernet (eth_state[2:0]) – LVCMOS12
set_property PACKAGE_PIN AA19 [get_ports {eth_state[2]}]
set_property IOSTANDARD LVCMOS12 [get_ports {eth_state[2]}]
set_input_delay -clock clk -max 3.0 [get_ports eth_state[2]]
set_input_delay -clock clk -min 1.0 [get_ports eth_state[2]]
# Definir retrasos de salida para las señales relevantes
set_output_delay -clock clk -max 2.0 [get_ports eth_state[2]]
set_output_delay -clock clk -min 0.5 [get_ports eth_state[2]]

set_property PACKAGE_PIN AA18 [get_ports {eth_state[1]}]
set_property IOSTANDARD LVCMOS12 [get_ports {eth_state[1]}]
set_input_delay -clock clk -max 3.0 [get_ports eth_state[1]]
set_input_delay -clock clk -min 1.0 [get_ports eth_state[1]]
#RETARDOS DE SALIDA
set_output_delay -clock clk -max 2.0 [get_ports eth_state[1]]
set_output_delay -clock clk -min 0.5 [get_ports eth_state[1]]


set_property PACKAGE_PIN AA20 [get_ports {eth_state[0]}]
set_property IOSTANDARD LVCMOS12 [get_ports {eth_state[0]}]
set_input_delay -clock clk -max 3.0 [get_ports eth_state[0]]
set_input_delay -clock clk -min 1.0 [get_ports eth_state[0]]
#RETARDOS DE SALIDA
set_output_delay -clock clk -max 2.0 [get_ports eth_state[0]]
set_output_delay -clock clk -min 0.5 [get_ports eth_state[0]]

# Señales de estado LED (led_status[2:0]) – LVCMOS12
set_property PACKAGE_PIN AA17 [get_ports {led_status[2]}]
set_property IOSTANDARD LVCMOS12 [get_ports {led_status[2]}]

set_property PACKAGE_PIN AA14 [get_ports {led_status[1]}]
set_property IOSTANDARD LVCMOS12 [get_ports {led_status[1]}]

set_property PACKAGE_PIN AA15 [get_ports {led_status[0]}]
set_property IOSTANDARD LVCMOS12 [get_ports {led_status[0]}]

# Display de 7 segmentos (sseg[7:0]) – LVCMOS12
set_property PACKAGE_PIN A6 [get_ports {sseg[7]}]
set_property IOSTANDARD LVCMOS12 [get_ports {sseg[7]}]

set_property PACKAGE_PIN A7 [get_ports {sseg[6]}]
set_property IOSTANDARD LVCMOS12 [get_ports {sseg[6]}]

set_property PACKAGE_PIN A8 [get_ports {sseg[5]}]
set_property IOSTANDARD LVCMOS12 [get_ports {sseg[5]}]

set_property PACKAGE_PIN A9 [get_ports {sseg[4]}]
set_property IOSTANDARD LVCMOS12 [get_ports {sseg[4]}]

set_property PACKAGE_PIN A10 [get_ports {sseg[3]}]
set_property IOSTANDARD LVCMOS12 [get_ports {sseg[3]}]

set_property PACKAGE_PIN A11 [get_ports {sseg[2]}]
set_property IOSTANDARD LVCMOS12 [get_ports {sseg[2]}]

set_property PACKAGE_PIN A12 [get_ports {sseg[1]}]
set_property IOSTANDARD LVCMOS12 [get_ports {sseg[1]}]

set_property PACKAGE_PIN A13 [get_ports {sseg[0]}]
set_property IOSTANDARD LVCMOS12 [get_ports {sseg[0]}]

# Botón (btn) – LVCMOS18
set_property PACKAGE_PIN C18 [get_ports btn]
set_property IOSTANDARD LVCMOS18 [get_ports btn]

# db  AE20  LVCMOS18
set_property PACKAGE_PIN AE20 [get_ports db]
set_property IOSTANDARD LVCMOS12 [get_ports db]
set_input_delay -clock clk -max 3.0 [get_ports db]
set_input_delay -clock clk -min 1.0 [get_ports db]
#RETARDOS DE SALIDA
set_output_delay -clock clk -max 2.0 [get_ports db]
set_output_delay -clock clk -min 0.5 [get_ports db]

# Reset (reset) – LVCMOS33 ✅ (Cambiado para coincidir con `sw` y evitar conflicto)
set_property PACKAGE_PIN H7 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]
# Agregar retrasos de entrada para la señal 'reset'
set_input_delay -clock clk -max 3.0 [get_ports reset]
set_input_delay -clock clk -min 1.0 [get_ports reset]
#RETARDOS DE SALIDA
set_output_delay -clock clk -max 2.0 [get_ports reset]
set_output_delay -clock clk -max 0.5 [get_ports reset]


# Interruptores (sw) – LVCMOS33
set_property PACKAGE_PIN H6 [get_ports sw]
set_property IOSTANDARD LVCMOS33 [get_ports sw]
set_input_delay -clock clk -max 3.0 [get_ports sw]
set_input_delay -clock clk -min 1.0 [get_ports sw]

set_property PACKAGE_PIN AK12     [get_ports a] ;# Bank  66 VCCO - VCC1V2   - IO_L9P_T1L_N4_AD12P_66
set_property IOSTANDARD  LVCMOS12 [get_ports a] ;# Bank  66 VCCO - VCC1V2   - IO_L9P_T1L_N4_AD12P_66
set_property PACKAGE_PIN AL10     [get_ports b] ;# Bank  66 VCCO - VCC1V2   - IO_L8N_T1L_N3_AD5N_66
set_property IOSTANDARD  LVCMOS12 [get_ports b] ;# Bank  66 VCCO - VCC1V2   - IO_L8N_T1L_N3_AD5N_66

set_property PACKAGE_PIN AL11     [get_ports y] ;# Bank  66 VCCO - VCC1V2   - IO_L8P_T1L_N2_AD5P_66
set_property IOSTANDARD  LVCMOS12 [get_ports y] ;# Bank  66 VCCO - VCC1V2   - IO_L8P_T1L_N2_AD5P_66

#UART RX OPTIONS
set_property PACKAGE_PIN AM15      [get_ports "clock"] ;# Bank  64 VCCO - VCC1V2   - IO_L7N_T1L_N1_QBC_AD13N_64
set_property IOSTANDARD  LVCMOS12  [get_ports "clock"] ;# Bank  64 VCCO - VCC1V2   - IO_L7N_T1L_N1_QBC_AD13N_64
set_property PACKAGE_PIN AM16      [get_ports "i_rx"] ;# Bank  64 VCCO - VCC1V2   - IO_L7P_T1L_N0_QBC_AD13P_64
set_property IOSTANDARD  POD12_DCI [get_ports "i_rx"] ;# Bank  64 VCCO - VCC1V2   - IO_L7P_T1L_N0_QBC_AD13P_64
set_property PACKAGE_PIN AL17      [get_ports "o_data_avail"] ;# Bank  64 VCCO - VCC1V2   - IO_T1U_N12_64
set_property IOSTANDARD  LVCMOS12  [get_ports "o_data_avail"] ;# Bank  64 VCCO - VCC1V2   - IO_T1U_N12_64
set_property PACKAGE_PIN N9       [get_ports "i_data_byte"] ;# Bank  87 VCCO - VCC3V3   - IO_L2P_AD10P_87
set_property IOSTANDARD  LVCMOS33 [get_ports "i_data_byte"] ;# Bank  87 VCCO - VCC3V3   - IO_L2P_AD10P_87

#UART & REGS 
set_property PACKAGE_PIN J6       [get_ports "o_tx"] ;# Bank  87 VCCO - VCC3V3   - IO_L9N_AD3N_87
set_property IOSTANDARD  LVCMOS33 [get_ports "o_tx"] ;# Bank  87 VCCO - VCC3V3   - IO_L9N_AD3N_87
set_property PACKAGE_PIN J7       [get_ports "o_done"] ;# Bank  87 VCCO - VCC3V3   - IO_L9P_AD3P_87
set_property IOSTANDARD  LVCMOS33 [get_ports "o_done"] ;# Bank  87 VCCO - VCC3V3   - IO_L9P_AD3P_87

#REGS-REGISTERS-TRANSMIT BYTES ASSEMBLER
# Asignación de puertos para el módulo REGS

set_property PACKAGE_PIN J9       [get_ports "clock"]            ; # Bank 87 VCCO - VCC3V3   - IO_L8N_HDGC_AD4N_87
set_property IOSTANDARD  LVCMOS33 [get_ports "clock"]            ; # Bank 87 VCCO - VCC3V3   - IO_L8N_HDGC_AD4N_87

set_property PACKAGE_PIN K9       [get_ports "clock_enable"]     ; # Bank 87 VCCO - VCC3V3   - IO_L8P_HDGC_AD4P_87
set_property IOSTANDARD  LVCMOS33 [get_ports "clock_enable"]     ; # Bank 87 VCCO - VCC3V3   - IO_L8P_HDGC_AD4P_87

set_property PACKAGE_PIN C13      [get_ports "reset_in"]         ; # Bank 67 VCCO - VADJ_FMC - IO_L6N_T0U_N11_AD6N_67
set_property IOSTANDARD  LVDS     [get_ports "reset_in"]         ; # Bank 67 VCCO - VADJ_FMC - IO_L6N_T0U_N11_AD6N_67

set_property PACKAGE_PIN A12      [get_ports "mmu_ready"]        ; # Bank 67 VCCO - VADJ_FMC - IO_L6P_T0U_N10_AD6P_67
set_property IOSTANDARD  LVDS     [get_ports "mmu_ready"]        ; # Bank 67 VCCO - VADJ_FMC - IO_L6P_T0U_N10_AD6P_67

# Asignación de reg1_addr[3:0]

set_property PACKAGE_PIN A13      [get_ports "reg1_addr[0]"]     ; # Bank 67 VCCO - VADJ_FMC - IO_L5N_T0U_N9_AD14N_67
set_property IOSTANDARD  LVCMOS18 [get_ports "reg1_addr[0]"]     ; # Bank 67 VCCO - VADJ_FMC - IO_L5N_T0U_N9_AD14N_67

set_property PACKAGE_PIN B13      [get_ports "reg1_addr[1]"]     ; # Bank 67 VCCO - VADJ_FMC - IO_L5P_T0U_N8_AD14P_67
set_property IOSTANDARD  LVCMOS18 [get_ports "reg1_addr[1]"]     ; # Bank 67 VCCO - VADJ_FMC - IO_L5P_T0U_N8_AD14P_67

set_property PACKAGE_PIN B14      [get_ports "reg1_addr[2]"]     ; # Bank 67 VCCO - VADJ_FMC - IO_L4N_T0U_N7_DBC_AD7N_67
set_property IOSTANDARD  LVCMOS18 [get_ports "reg1_addr[2]"]     ; # Bank 67 VCCO - VADJ_FMC - IO_L4N_T0U_N7_DBC_AD7N_67

set_property PACKAGE_PIN A14      [get_ports "reg1_addr[3]"]     ; # Bank 67 VCCO - VADJ_FMC - IO_L4P_T0U_N6_DBC_AD7P_67
set_property IOSTANDARD  LVCMOS18 [get_ports "reg1_addr[3]"]     ; # Bank 67 VCCO - VADJ_FMC - IO_L4P_T0U_N6_DBC_AD7P_67

# Asignación de GPIO_DIP_SW

set_property PACKAGE_PIN B15      [get_ports "reg2_addr[0]"]     ; # Bank 67 VCCO - VADJ_FMC - IO_L3N_T0L_N5_AD15N_67
set_property IOSTANDARD  LVCMOS18 [get_ports "reg2_addr[0]"]     ; # Bank 67 VCCO - VADJ_FMC - IO_L3N_T0L_N5_AD15N_67

set_property PACKAGE_PIN B16      [get_ports "reg2_addr[1]"]     ; # Bank 67 VCCO - VADJ_FMC - IO_L3P_T0L_N4_AD15P_67
set_property IOSTANDARD  LVCMOS18 [get_ports "reg2_addr[1]"]     ; # Bank 67 VCCO - VADJ_FMC - IO_L3P_T0L_N4_AD15P_67

set_property PACKAGE_PIN A16      [get_ports "reg2_addr[2]"]     ; # Bank 67 VCCO - VADJ_FMC - IO_L2N_T0L_N3_67
set_property IOSTANDARD  LVCMOS18 [get_ports "reg2_addr[2]"]     ; # Bank 67 VCCO - VADJ_FMC - IO_L2N_T0L_N3_67

set_property PACKAGE_PIN A17      [get_ports "reg2_addr[3]"]     ; # Bank 67 VCCO - VADJ_FMC - IO_L2P_T0L_N2_67
set_property IOSTANDARD  LVCMOS18 [get_ports "reg2_addr[3]"]     ; # Bank 67 VCCO - VADJ_FMC - IO_L2P_T0L_N2_67

# Agregar los extras: SDI

set_property PACKAGE_PIN J20      [get_ports "SDI_CS_RCVR_LS"]   ; # Bank 67 VCCO - VADJ_FMC - IO_T3U_N12_67
set_property IOSTANDARD  LVCMOS18 [get_ports "SDI_CS_RCVR_LS"]   ; # Bank 67 VCCO - VADJ_FMC - IO_T3U_N12_67

set_property PACKAGE_PIN J19      [get_ports "SDI_CS_DRVR_LS"]   ; # Bank 67 VCCO - VADJ_FMC - IO_T2U_N12_67
set_property IOSTANDARD  LVCMOS18 [get_ports "SDI_CS_DRVR_LS"]   ; # Bank 67 VCCO - VADJ_FMC - IO_T2U_N12_67

# Asignación de puertos para el módulo REGS

# Puerto regLR_data[63:0]
# Dado que es un bus de 64 bits, es necesario asignar cada bit individualmente.
# Ejemplo para los primeros bits:

set_property PACKAGE_PIN B19      [get_ports "regLR_data[0]"]     ; # Bank 28 VCCO - VADJ_FMC - IO_L22N_T3U_N7_DBC_AD0N_28
set_property IOSTANDARD  LVDS     [get_ports "regLR_data[0]"]     ; # LVDS para señal diferencial

set_property PACKAGE_PIN B18      [get_ports "regLR_data[1]"]     ; # Bank 28 VCCO - VADJ_FMC - IO_L22P_T3U_N6_DBC_AD0P_28
set_property IOSTANDARD  LVDS     [get_ports "regLR_data[1]"]     ; # LVDS para señal diferencial

# Continúa asignando los pines correspondientes para regLR_data[2] hasta regLR_data[63]

# Puerto regSP_data[63:0]

set_property PACKAGE_PIN A21      [get_ports "regSP_data[0]"]     ; # Bank 28 VCCO - VADJ_FMC - IO_L21N_T3L_N5_AD8N_28
set_property IOSTANDARD  LVDS     [get_ports "regSP_data[0]"]     ; # LVDS para señal diferencial

set_property PACKAGE_PIN A20      [get_ports "regSP_data[1]"]     ; # Bank 28 VCCO - VADJ_FMC - IO_L21P_T3L_N4_AD8P_28
set_property IOSTANDARD  LVDS     [get_ports "regSP_data[1]"]     ; # LVDS para señal diferencial

# Continúa asignando los pines correspondientes para regSP_data[2] hasta regSP_data[63]

# Puerto regD_addr[3:0]

set_property PACKAGE_PIN C19      [get_ports "regD_addr[0]"]      ; # Bank 28 VCCO - VADJ_FMC - IO_L20N_T3L_N3_AD1N_28
set_property IOSTANDARD  LVDS     [get_ports "regD_addr[0]"]      ; # LVDS para señal diferencial

set_property PACKAGE_PIN C18      [get_ports "regD_addr[1]"]      ; # Bank 28 VCCO - VADJ_FMC - IO_L20P_T3L_N2_AD1P_28
set_property IOSTANDARD  LVDS     [get_ports "regD_addr[1]"]      ; # LVDS para señal diferencial

set_property PACKAGE_PIN A19      [get_ports "regD_addr[2]"]      ; # Bank 28 VCCO - VADJ_FMC - IO_L19N_T3L_N1_DBC_AD9N_28
set_property IOSTANDARD  LVDS     [get_ports "regD_addr[2]"]      ; # LVDS para señal diferencial

set_property PACKAGE_PIN A18      [get_ports "regD_addr[3]"]      ; # Bank 28 VCCO - VADJ_FMC - IO_L19P_T3L_N0_DBC_AD9P_28
set_property IOSTANDARD  LVDS     [get_ports "regD_addr[3]"]      ; # LVDS para señal diferencial

# Puerto reg_write_en

set_property PACKAGE_PIN D17      [get_ports "reg_write_en"]      ; # Asigna un pin disponible para esta señal
set_property IOSTANDARD  LVCMOS18 [get_ports "reg_write_en"]      ; # Ajusta el estándar de E/S según corresponda

# Puerto regD_data[63:0]

# Ejemplo para los primeros bits:

set_property PACKAGE_PIN E19      [get_ports "regD_data[0]"]      ; # Asigna el pin correspondiente
set_property IOSTANDARD  LVDS     [get_ports "regD_data[0]"]      ; # LVDS para señal diferencial

set_property PACKAGE_PIN E18      [get_ports "regD_data[1]"]      ; # Asigna el pin correspondiente
set_property IOSTANDARD  LVDS     [get_ports "regD_data[1]"]      ; # LVDS para señal diferencial



#UART HDMI TX OPTIONS
set_property PACKAGE_PIN N11      [get_ports "clock"] ;# Bank  87 VCCO - VCC3V3   - IO_L4P_AD8P_87
set_property IOSTANDARD  LVCMOS33 [get_ports "clock"] ;# Bank  87 VCCO - VCC3V3   - IO_L4P_AD8P_87
set_property PACKAGE_PIN M12      [get_ports "i_rx"] ;# Bank  87 VCCO - VCC3V3   - IO_L3N_AD9N_87
set_property IOSTANDARD  LVCMOS33 [get_ports "i_rx"] ;# Bank  87 VCCO - VCC3V3   - IO_L3N_AD9N_87
set_property PACKAGE_PIN N13      [get_ports "o_data_avail"] ;# Bank  87 VCCO - VCC3V3   - IO_L3P_AD9P_87
set_property IOSTANDARD  LVCMOS33 [get_ports "o_data_avail"] ;# Bank  87 VCCO - VCC3V3   - IO_L3P_AD9P_87
set_property PACKAGE_PIN N8       [get_ports "o_data_byte"] ;# Bank  87 VCCO - VCC3V3   - IO_L2N_AD10N_87
set_property IOSTANDARD  LVCMOS33 [get_ports "o_data_byte"] ;# Bank  87 VCCO - VCC3V3   - IO_L2N_AD10N_87
