# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "MEM_DELAY" -parent ${Page_0}
  ipgui::add_param $IPINST -name "W_ADDR" -parent ${Page_0}


}

proc update_PARAM_VALUE.MEM_DELAY { PARAM_VALUE.MEM_DELAY } {
	# Procedure called to update MEM_DELAY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.MEM_DELAY { PARAM_VALUE.MEM_DELAY } {
	# Procedure called to validate MEM_DELAY
	return true
}

proc update_PARAM_VALUE.W_ADDR { PARAM_VALUE.W_ADDR } {
	# Procedure called to update W_ADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.W_ADDR { PARAM_VALUE.W_ADDR } {
	# Procedure called to validate W_ADDR
	return true
}


proc update_MODELPARAM_VALUE.W_ADDR { MODELPARAM_VALUE.W_ADDR PARAM_VALUE.W_ADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.W_ADDR}] ${MODELPARAM_VALUE.W_ADDR}
}

proc update_MODELPARAM_VALUE.MEM_DELAY { MODELPARAM_VALUE.MEM_DELAY PARAM_VALUE.MEM_DELAY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.MEM_DELAY}] ${MODELPARAM_VALUE.MEM_DELAY}
}

