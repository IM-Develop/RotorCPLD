# TCL File Generated by Component Editor 18.1
# Thu Nov 28 07:58:33 IST 2019
# DO NOT MODIFY


# 
# I2C2AvalonBridge "I2C2AvalonBridge" v1.0
#  2019.11.28.07:58:33
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module I2C2AvalonBridge
# 
set_module_property DESCRIPTION ""
set_module_property NAME I2C2AvalonBridge
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP "CusP components"
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME I2C2AvalonBridge
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL I2C2AvalonBridge
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file I2C2AvalonBridge.vhd VHDL PATH I2C2AvalonBridge.vhd TOP_LEVEL_FILE


# 
# parameters
# 
add_parameter DevAdd STD_LOGIC_VECTOR 64
set_parameter_property DevAdd DEFAULT_VALUE 64
set_parameter_property DevAdd DISPLAY_NAME DevAdd
set_parameter_property DevAdd TYPE STD_LOGIC_VECTOR
set_parameter_property DevAdd UNITS None
set_parameter_property DevAdd ALLOWED_RANGES 0:255
set_parameter_property DevAdd HDL_PARAMETER true


# 
# display items
# 


# 
# connection point m0
# 
add_interface m0 avalon start
set_interface_property m0 addressUnits SYMBOLS
set_interface_property m0 associatedClock clock_sink
set_interface_property m0 associatedReset reset_sink
set_interface_property m0 bitsPerSymbol 8
set_interface_property m0 burstOnBurstBoundariesOnly false
set_interface_property m0 burstcountUnits WORDS
set_interface_property m0 doStreamReads false
set_interface_property m0 doStreamWrites false
set_interface_property m0 holdTime 0
set_interface_property m0 linewrapBursts false
set_interface_property m0 maximumPendingReadTransactions 0
set_interface_property m0 maximumPendingWriteTransactions 0
set_interface_property m0 readLatency 0
set_interface_property m0 readWaitTime 1
set_interface_property m0 setupTime 0
set_interface_property m0 timingUnits Cycles
set_interface_property m0 writeWaitTime 0
set_interface_property m0 ENABLED true
set_interface_property m0 EXPORT_OF ""
set_interface_property m0 PORT_NAME_MAP ""
set_interface_property m0 CMSIS_SVD_VARIABLES ""
set_interface_property m0 SVD_ADDRESS_GROUP ""

add_interface_port m0 avm_m0_read_n read_n Output 1
add_interface_port m0 avm_m0_write_n write_n Output 1
add_interface_port m0 avm_m0_address address Output 8
add_interface_port m0 avm_m0_readdata readdata Input 8
add_interface_port m0 avm_m0_readdatavalid readdatavalid Input 1
add_interface_port m0 avm_m0_writedata writedata Output 8
add_interface_port m0 avm_m0_waitrequest waitrequest Input 1


# 
# connection point conduit_end
# 
add_interface conduit_end conduit end
set_interface_property conduit_end associatedClock clock_sink
set_interface_property conduit_end associatedReset reset_sink
set_interface_property conduit_end ENABLED true
set_interface_property conduit_end EXPORT_OF ""
set_interface_property conduit_end PORT_NAME_MAP ""
set_interface_property conduit_end CMSIS_SVD_VARIABLES ""
set_interface_property conduit_end SVD_ADDRESS_GROUP ""

add_interface_port conduit_end SDA export Bidir 1


# 
# connection point conduit_end_1
# 
add_interface conduit_end_1 conduit end
set_interface_property conduit_end_1 associatedClock clock_sink
set_interface_property conduit_end_1 associatedReset reset_sink
set_interface_property conduit_end_1 ENABLED true
set_interface_property conduit_end_1 EXPORT_OF ""
set_interface_property conduit_end_1 PORT_NAME_MAP ""
set_interface_property conduit_end_1 CMSIS_SVD_VARIABLES ""
set_interface_property conduit_end_1 SVD_ADDRESS_GROUP ""

add_interface_port conduit_end_1 SCL export Input 1


# 
# connection point clock_sink
# 
add_interface clock_sink clock end
set_interface_property clock_sink clockRate 0
set_interface_property clock_sink ENABLED true
set_interface_property clock_sink EXPORT_OF ""
set_interface_property clock_sink PORT_NAME_MAP ""
set_interface_property clock_sink CMSIS_SVD_VARIABLES ""
set_interface_property clock_sink SVD_ADDRESS_GROUP ""

add_interface_port clock_sink sci_c0_clk clk Input 1


# 
# connection point reset_sink
# 
add_interface reset_sink reset end
set_interface_property reset_sink associatedClock clock_sink
set_interface_property reset_sink synchronousEdges DEASSERT
set_interface_property reset_sink ENABLED true
set_interface_property reset_sink EXPORT_OF ""
set_interface_property reset_sink PORT_NAME_MAP ""
set_interface_property reset_sink CMSIS_SVD_VARIABLES ""
set_interface_property reset_sink SVD_ADDRESS_GROUP ""

add_interface_port reset_sink sci_c0_reset_n reset_n Input 1

