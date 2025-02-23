##############################################################################
## Constraints para xczu7ev-ffvc1156-2-e (Active) ZCU106 UltraScale dev kit
###############################################################################

set_property PACKAGE_PIN AH12 [get_ports clk]
set_property IOSTANDARD SSTL12 [get_ports clk]

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

set_property PACKAGE_PIN AA18 [get_ports {eth_state[1]}]
set_property IOSTANDARD LVCMOS12 [get_ports {eth_state[1]}]

set_property PACKAGE_PIN AA20 [get_ports {eth_state[0]}]
set_property IOSTANDARD LVCMOS12 [get_ports {eth_state[0]}]

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

# Reset (reset) – LVCMOS33 ✅ (Cambiado para coincidir con `sw` y evitar conflicto)
set_property PACKAGE_PIN H7 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

# Interruptores (sw) – LVCMOS33
set_property PACKAGE_PIN H6 [get_ports sw]
set_property IOSTANDARD LVCMOS33 [get_ports sw]

set_property PACKAGE_PIN AK12     [get_ports a] ;# Bank  66 VCCO - VCC1V2   - IO_L9P_T1L_N4_AD12P_66
set_property IOSTANDARD  LVCMOS12 [get_ports a] ;# Bank  66 VCCO - VCC1V2   - IO_L9P_T1L_N4_AD12P_66
set_property PACKAGE_PIN AL10     [get_ports b] ;# Bank  66 VCCO - VCC1V2   - IO_L8N_T1L_N3_AD5N_66
set_property IOSTANDARD  LVCMOS12 [get_ports b] ;# Bank  66 VCCO - VCC1V2   - IO_L8N_T1L_N3_AD5N_66

set_property PACKAGE_PIN AL11     [get_ports y] ;# Bank  66 VCCO - VCC1V2   - IO_L8P_T1L_N2_AD5P_66
set_property IOSTANDARD  LVCMOS12 [get_ports y] ;# Bank  66 VCCO - VCC1V2   - IO_L8P_T1L_N2_AD5P_66

