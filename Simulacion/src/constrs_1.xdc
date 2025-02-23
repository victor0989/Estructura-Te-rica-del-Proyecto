
####################################################################################
# Generated by Vivado 2024.1.2 built on 'Thu Sep  5 14:37:11 MDT 2024' by 'xbuild'
# Command Used: write_xdc -force C:/Users/PC/ZCU106_board/constrs_1.xdc -no_fixed_only
####################################################################################


####################################################################################
# Constraints from file : 'constraint.xdc'
####################################################################################

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



# Vivado Generated physical constraints 

set_property BEL OUTBUF [get_cells {an_OBUF[0]_inst}]
set_property BEL OUTBUF [get_cells {an_OBUF[1]_inst}]
set_property BEL OUTBUF [get_cells {an_OBUF[2]_inst}]
set_property BEL OUTBUF [get_cells {an_OBUF[3]_inst}]
set_property BEL BUFCE [get_cells clk_IBUF_BUFG_inst]
set_property BEL INBUF [get_cells clk_IBUF_inst]
set_property BEL OUTBUF [get_cells db_OBUF_inst]
set_property BEL G5LUT [get_cells {eth_fsm/FSM_onehot_state_reg[0]_i_1}]
set_property BEL H5LUT [get_cells {eth_fsm/FSM_onehot_state_reg[0]_i_2}]
set_property BEL D6LUT [get_cells {eth_fsm/FSM_onehot_state_reg[2]_i_1__0}]
set_property BEL H6LUT [get_cells {eth_fsm/FSM_onehot_state_reg[3]_i_1}]
set_property BEL D5LUT [get_cells {eth_fsm/FSM_onehot_state_reg[4]_i_1}]
set_property BEL C5LUT [get_cells {eth_fsm/FSM_onehot_state_reg[6]_i_1}]
set_property BEL F6LUT [get_cells {eth_fsm/FSM_onehot_state_reg[7]_i_1}]
set_property BEL D5LUT [get_cells {eth_fsm/FSM_onehot_state_reg[7]_i_2}]
set_property BEL B5LUT [get_cells {eth_fsm/FSM_onehot_state_reg[7]_i_3}]
set_property BEL H6LUT [get_cells {eth_fsm/FSM_onehot_state_reg[7]_i_4}]
set_property BEL D6LUT [get_cells {eth_fsm/FSM_onehot_state_reg[7]_i_5}]
set_property BEL G6LUT [get_cells {eth_fsm/FSM_onehot_state_reg[7]_i_6}]
set_property BEL H6LUT [get_cells {eth_fsm/FSM_onehot_state_reg[7]_i_7}]
set_property BEL G6LUT [get_cells {eth_fsm/FSM_onehot_state_reg[7]_i_8}]
set_property BEL F6LUT [get_cells {eth_fsm/FSM_onehot_state_reg[7]_i_9}]
set_property BEL GFF2 [get_cells {eth_fsm/FSM_onehot_state_reg_reg[0]}]
set_property BEL EFF [get_cells {eth_fsm/FSM_onehot_state_reg_reg[1]}]
set_property BEL DFF [get_cells {eth_fsm/FSM_onehot_state_reg_reg[2]}]
set_property BEL AFF [get_cells {eth_fsm/FSM_onehot_state_reg_reg[3]}]
set_property BEL EFF2 [get_cells {eth_fsm/FSM_onehot_state_reg_reg[4]}]
set_property BEL FFF [get_cells {eth_fsm/FSM_onehot_state_reg_reg[5]}]
set_property BEL FFF2 [get_cells {eth_fsm/FSM_onehot_state_reg_reg[6]}]
set_property BEL DFF2 [get_cells {eth_fsm/FSM_onehot_state_reg_reg[7]}]
set_property BEL C6LUT [get_cells eth_fsm/db_OBUF_inst_i_1]
set_property BEL D5LUT [get_cells {eth_fsm/eth_state[0]_i_1}]
set_property BEL B6LUT [get_cells {eth_fsm/eth_state[1]_i_1}]
set_property BEL DFF2 [get_cells {eth_fsm/eth_state_reg[0]}]
set_property BEL EFF [get_cells {eth_fsm/eth_state_reg[1]}]
set_property BEL EFF [get_cells {eth_fsm/eth_state_reg[2]}]
set_property BEL A6LUT [get_cells {eth_fsm/q_reg[0]_i_2}]
set_property BEL AFF [get_cells {eth_fsm/q_reg_reg[0]}]
set_property BEL CARRY8 [get_cells {eth_fsm/q_reg_reg[0]_i_1}]
set_property BEL CFF [get_cells {eth_fsm/q_reg_reg[10]}]
set_property BEL DFF [get_cells {eth_fsm/q_reg_reg[11]}]
set_property BEL EFF [get_cells {eth_fsm/q_reg_reg[12]}]
set_property BEL FFF [get_cells {eth_fsm/q_reg_reg[13]}]
set_property BEL GFF [get_cells {eth_fsm/q_reg_reg[14]}]
set_property BEL HFF [get_cells {eth_fsm/q_reg_reg[15]}]
set_property BEL AFF [get_cells {eth_fsm/q_reg_reg[16]}]
set_property BEL CARRY8 [get_cells {eth_fsm/q_reg_reg[16]_i_1}]
set_property BEL BFF [get_cells {eth_fsm/q_reg_reg[17]}]
set_property BEL CFF [get_cells {eth_fsm/q_reg_reg[18]}]
set_property BEL BFF [get_cells {eth_fsm/q_reg_reg[1]}]
set_property BEL CFF [get_cells {eth_fsm/q_reg_reg[2]}]
set_property BEL DFF [get_cells {eth_fsm/q_reg_reg[3]}]
set_property BEL EFF [get_cells {eth_fsm/q_reg_reg[4]}]
set_property BEL FFF [get_cells {eth_fsm/q_reg_reg[5]}]
set_property BEL GFF [get_cells {eth_fsm/q_reg_reg[6]}]
set_property BEL HFF [get_cells {eth_fsm/q_reg_reg[7]}]
set_property BEL AFF [get_cells {eth_fsm/q_reg_reg[8]}]
set_property BEL CARRY8 [get_cells {eth_fsm/q_reg_reg[8]_i_1}]
set_property BEL BFF [get_cells {eth_fsm/q_reg_reg[9]}]
set_property BEL OUTBUF [get_cells {eth_state_OBUF[0]_inst}]
set_property BEL OUTBUF [get_cells {eth_state_OBUF[1]_inst}]
set_property BEL OUTBUF [get_cells {eth_state_OBUF[2]_inst}]
set_property BEL OUTBUF [get_cells {led_status_OBUF[0]_inst}]
set_property BEL OUTBUF [get_cells {led_status_OBUF[1]_inst}]
set_property BEL OUTBUF [get_cells {led_status_OBUF[2]_inst}]
set_property BEL INBUF [get_cells reset_IBUF_inst]
set_property BEL OUTBUF [get_cells {sseg_OBUF[0]_inst}]
set_property BEL OUTBUF [get_cells {sseg_OBUF[1]_inst}]
set_property BEL OUTBUF [get_cells {sseg_OBUF[2]_inst}]
set_property BEL OUTBUF [get_cells {sseg_OBUF[3]_inst}]
set_property BEL OUTBUF [get_cells {sseg_OBUF[4]_inst}]
set_property BEL OUTBUF [get_cells {sseg_OBUF[5]_inst}]
set_property BEL OUTBUF [get_cells {sseg_OBUF[6]_inst}]
set_property BEL OUTBUF [get_cells {sseg_OBUF[7]_inst}]
set_property BEL INBUF [get_cells sw_IBUF_inst]
set_property LOC BUFGCE_X1Y81 [get_cells clk_IBUF_BUFG_inst]
set_property LOC SLICE_X67Y198 [get_cells {eth_fsm/FSM_onehot_state_reg[0]_i_1}]
set_property LOC SLICE_X67Y198 [get_cells {eth_fsm/FSM_onehot_state_reg[0]_i_2}]
set_property LOC SLICE_X68Y198 [get_cells {eth_fsm/FSM_onehot_state_reg[2]_i_1__0}]
set_property LOC SLICE_X67Y198 [get_cells {eth_fsm/FSM_onehot_state_reg[3]_i_1}]
set_property LOC SLICE_X67Y198 [get_cells {eth_fsm/FSM_onehot_state_reg[4]_i_1}]
set_property LOC SLICE_X67Y198 [get_cells {eth_fsm/FSM_onehot_state_reg[6]_i_1}]
set_property LOC SLICE_X67Y198 [get_cells {eth_fsm/FSM_onehot_state_reg[7]_i_1}]
set_property LOC SLICE_X68Y198 [get_cells {eth_fsm/FSM_onehot_state_reg[7]_i_2}]
set_property LOC SLICE_X67Y198 [get_cells {eth_fsm/FSM_onehot_state_reg[7]_i_3}]
set_property LOC SLICE_X67Y199 [get_cells {eth_fsm/FSM_onehot_state_reg[7]_i_4}]
set_property LOC SLICE_X67Y198 [get_cells {eth_fsm/FSM_onehot_state_reg[7]_i_5}]
set_property LOC SLICE_X67Y199 [get_cells {eth_fsm/FSM_onehot_state_reg[7]_i_6}]
set_property LOC SLICE_X67Y202 [get_cells {eth_fsm/FSM_onehot_state_reg[7]_i_7}]
set_property LOC SLICE_X67Y202 [get_cells {eth_fsm/FSM_onehot_state_reg[7]_i_8}]
set_property LOC SLICE_X67Y202 [get_cells {eth_fsm/FSM_onehot_state_reg[7]_i_9}]
set_property LOC SLICE_X67Y198 [get_cells {eth_fsm/FSM_onehot_state_reg_reg[0]}]
set_property LOC SLICE_X67Y198 [get_cells {eth_fsm/FSM_onehot_state_reg_reg[1]}]
set_property LOC SLICE_X68Y198 [get_cells {eth_fsm/FSM_onehot_state_reg_reg[2]}]
set_property LOC SLICE_X67Y198 [get_cells {eth_fsm/FSM_onehot_state_reg_reg[3]}]
set_property LOC SLICE_X67Y198 [get_cells {eth_fsm/FSM_onehot_state_reg_reg[4]}]
set_property LOC SLICE_X67Y198 [get_cells {eth_fsm/FSM_onehot_state_reg_reg[5]}]
set_property LOC SLICE_X67Y198 [get_cells {eth_fsm/FSM_onehot_state_reg_reg[6]}]
set_property LOC SLICE_X68Y198 [get_cells {eth_fsm/FSM_onehot_state_reg_reg[7]}]
set_property LOC SLICE_X67Y198 [get_cells eth_fsm/db_OBUF_inst_i_1]
set_property LOC SLICE_X67Y197 [get_cells {eth_fsm/eth_state[0]_i_1}]
set_property LOC SLICE_X67Y198 [get_cells {eth_fsm/eth_state[1]_i_1}]
set_property LOC SLICE_X67Y197 [get_cells {eth_fsm/eth_state_reg[0]}]
set_property LOC SLICE_X66Y188 [get_cells {eth_fsm/eth_state_reg[1]}]
set_property LOC SLICE_X66Y177 [get_cells {eth_fsm/eth_state_reg[2]}]
set_property LOC SLICE_X67Y200 [get_cells {eth_fsm/q_reg[0]_i_2}]
set_property LOC SLICE_X67Y200 [get_cells {eth_fsm/q_reg_reg[0]}]
set_property LOC SLICE_X67Y200 [get_cells {eth_fsm/q_reg_reg[0]_i_1}]
set_property LOC SLICE_X67Y201 [get_cells {eth_fsm/q_reg_reg[10]}]
set_property LOC SLICE_X67Y201 [get_cells {eth_fsm/q_reg_reg[11]}]
set_property LOC SLICE_X67Y201 [get_cells {eth_fsm/q_reg_reg[12]}]
set_property LOC SLICE_X67Y201 [get_cells {eth_fsm/q_reg_reg[13]}]
set_property LOC SLICE_X67Y201 [get_cells {eth_fsm/q_reg_reg[14]}]
set_property LOC SLICE_X67Y201 [get_cells {eth_fsm/q_reg_reg[15]}]
set_property LOC SLICE_X67Y202 [get_cells {eth_fsm/q_reg_reg[16]}]
set_property LOC SLICE_X67Y202 [get_cells {eth_fsm/q_reg_reg[16]_i_1}]
set_property LOC SLICE_X67Y202 [get_cells {eth_fsm/q_reg_reg[17]}]
set_property LOC SLICE_X67Y202 [get_cells {eth_fsm/q_reg_reg[18]}]
set_property LOC SLICE_X67Y200 [get_cells {eth_fsm/q_reg_reg[1]}]
set_property LOC SLICE_X67Y200 [get_cells {eth_fsm/q_reg_reg[2]}]
set_property LOC SLICE_X67Y200 [get_cells {eth_fsm/q_reg_reg[3]}]
set_property LOC SLICE_X67Y200 [get_cells {eth_fsm/q_reg_reg[4]}]
set_property LOC SLICE_X67Y200 [get_cells {eth_fsm/q_reg_reg[5]}]
set_property LOC SLICE_X67Y200 [get_cells {eth_fsm/q_reg_reg[6]}]
set_property LOC SLICE_X67Y200 [get_cells {eth_fsm/q_reg_reg[7]}]
set_property LOC SLICE_X67Y201 [get_cells {eth_fsm/q_reg_reg[8]}]
set_property LOC SLICE_X67Y201 [get_cells {eth_fsm/q_reg_reg[8]_i_1}]
set_property LOC SLICE_X67Y201 [get_cells {eth_fsm/q_reg_reg[9]}]

# Vivado Generated miscellaneous constraints 

#revert back to original instance
current_instance -quiet
