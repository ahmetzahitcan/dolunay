# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "W_IROM_ADDR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "W_WRAM_ADDR" -parent ${Page_0}


}

proc update_PARAM_VALUE.W_IROM_ADDR { PARAM_VALUE.W_IROM_ADDR } {
	# Procedure called to update W_IROM_ADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.W_IROM_ADDR { PARAM_VALUE.W_IROM_ADDR } {
	# Procedure called to validate W_IROM_ADDR
	return true
}

proc update_PARAM_VALUE.W_WRAM_ADDR { PARAM_VALUE.W_WRAM_ADDR } {
	# Procedure called to update W_WRAM_ADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.W_WRAM_ADDR { PARAM_VALUE.W_WRAM_ADDR } {
	# Procedure called to validate W_WRAM_ADDR
	return true
}


proc update_MODELPARAM_VALUE.W_WRAM_ADDR { MODELPARAM_VALUE.W_WRAM_ADDR PARAM_VALUE.W_WRAM_ADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.W_WRAM_ADDR}] ${MODELPARAM_VALUE.W_WRAM_ADDR}
}

proc update_MODELPARAM_VALUE.W_IROM_ADDR { MODELPARAM_VALUE.W_IROM_ADDR PARAM_VALUE.W_IROM_ADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.W_IROM_ADDR}] ${MODELPARAM_VALUE.W_IROM_ADDR}
}

