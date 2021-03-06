# (C) 1992-2014 Altera Corporation. All rights reserved.                         
# Your use of Altera Corporation's design tools, logic functions and other       
# software and tools, and its AMPP partner logic functions, and any output       
# files any of the foregoing (including device programming or simulation         
# files), and any associated documentation or information are expressly subject  
# to the terms and conditions of the Altera Program License Subscription         
# Agreement, Altera MegaCore Function License Agreement, or other applicable     
# license agreement, including, without limitation, that your use is for the     
# sole purpose of programming logic devices manufactured by Altera and sold by   
# Altera or its authorized distributors.  Please refer to the applicable         
# agreement for further details.                                                 
    


# TCL File Generated by Component Editor 14.0
# Mon Mar 10 16:29:24 EDT 2014
# DO NOT MODIFY


# 
# cra_ring_node_fifo "cra_ring_node_fifo" v1.0
# John Freeman 2014.03.10.16:29:24
# OpenCL CRA Address Decode Ring Node
# 

# 
# request TCL package from ACDS 14.0
# 
package require -exact qsys 14.0


# 
# module cra_ring_node_fifo
# 
set_module_property DESCRIPTION "OpenCL CRA Address Decode Ring Node"
set_module_property NAME cra_ring_node_fifo
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP OpenCL
set_module_property AUTHOR "John Freeman"
set_module_property DISPLAY_NAME cra_ring_node_fifo
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL cra_ring_node_fifo
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file cra_ring_node_fifo.sv SYSTEM_VERILOG PATH cra_ring_node_fifo.sv TOP_LEVEL_FILE

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL cra_ring_node_fifo
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file cra_ring_node_fifo.sv SYSTEM_VERILOG PATH cra_ring_node_fifo.sv

add_fileset SIM_VHDL SIM_VHDL "" ""
set_fileset_property SIM_VHDL TOP_LEVEL cra_ring_node_fifo
set_fileset_property SIM_VHDL ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VHDL ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file cra_ring_node_fifo.sv SYSTEM_VERILOG PATH cra_ring_node_fifo.sv


# 
# parameters
# 
add_parameter CRA_ADDR_W INTEGER 32
set_parameter_property CRA_ADDR_W DEFAULT_VALUE 32
set_parameter_property CRA_ADDR_W DISPLAY_NAME CRA_ADDR_W
set_parameter_property CRA_ADDR_W TYPE INTEGER
set_parameter_property CRA_ADDR_W UNITS None
set_parameter_property CRA_ADDR_W HDL_PARAMETER true
add_parameter DATA_W INTEGER 32
set_parameter_property DATA_W DEFAULT_VALUE 32
set_parameter_property DATA_W DISPLAY_NAME DATA_W
set_parameter_property DATA_W TYPE INTEGER
set_parameter_property DATA_W UNITS None
set_parameter_property DATA_W HDL_PARAMETER true
add_parameter STALL_TO_VALID_LATENCY INTEGER 64
set_parameter_property STALL_TO_VALID_LATENCY DEFAULT_VALUE 3
set_parameter_property STALL_TO_VALID_LATENCY DISPLAY_NAME STALL_TO_VALID_LATENCY
set_parameter_property STALL_TO_VALID_LATENCY TYPE INTEGER
set_parameter_property STALL_TO_VALID_LATENCY UNITS None
set_parameter_property STALL_TO_VALID_LATENCY HDL_PARAMETER true


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset rst_n reset_n Input 1


# 
# connection point cra_master
# 
add_interface cra_master avalon start
set_interface_property cra_master addressUnits WORDS
set_interface_property cra_master associatedClock clock
set_interface_property cra_master associatedReset reset
set_interface_property cra_master bitsPerSymbol 8
set_interface_property cra_master burstOnBurstBoundariesOnly false
set_interface_property cra_master burstcountUnits WORDS
set_interface_property cra_master doStreamReads false
set_interface_property cra_master doStreamWrites false
set_interface_property cra_master holdTime 0
set_interface_property cra_master linewrapBursts false
set_interface_property cra_master maximumPendingReadTransactions 1
set_interface_property cra_master maximumPendingWriteTransactions 0
set_interface_property cra_master readLatency 0
set_interface_property cra_master readWaitTime 1
set_interface_property cra_master setupTime 0
set_interface_property cra_master timingUnits Cycles
set_interface_property cra_master writeWaitTime 0
set_interface_property cra_master ENABLED true
set_interface_property cra_master EXPORT_OF ""
set_interface_property cra_master PORT_NAME_MAP ""
set_interface_property cra_master CMSIS_SVD_VARIABLES ""
set_interface_property cra_master SVD_ADDRESS_GROUP ""

add_interface_port cra_master avm_read read Output 1
add_interface_port cra_master avm_write write Output 1
add_interface_port cra_master avm_addr address Output CRA_ADDR_W
add_interface_port cra_master avm_byteena byteenable Output DATA_W/8
add_interface_port cra_master avm_writedata writedata Output DATA_W
add_interface_port cra_master avm_readdata readdata Input DATA_W
add_interface_port cra_master avm_readdatavalid readdatavalid Input 1
add_interface_port cra_master avm_waitrequest waitrequest Input 1

# 
# connection point cra_slave
# 
add_interface cra_slave avalon end
set_interface_property cra_slave addressUnits WORDS
set_interface_property cra_slave associatedClock clock
set_interface_property cra_slave associatedReset reset
set_interface_property cra_slave bitsPerSymbol 8
set_interface_property cra_slave burstOnBurstBoundariesOnly false
set_interface_property cra_slave burstcountUnits WORDS
set_interface_property cra_slave explicitAddressSpan 0
set_interface_property cra_slave holdTime 0
set_interface_property cra_slave linewrapBursts false
set_interface_property cra_slave maximumPendingReadTransactions 64
set_interface_property cra_slave maximumPendingWriteTransactions 0
set_interface_property cra_slave readLatency 0
set_interface_property cra_slave readWaitTime 1
set_interface_property cra_slave setupTime 0
set_interface_property cra_slave timingUnits Cycles
set_interface_property cra_slave writeWaitTime 0
set_interface_property cra_slave ENABLED true
set_interface_property cra_slave EXPORT_OF ""
set_interface_property cra_slave PORT_NAME_MAP ""
set_interface_property cra_slave CMSIS_SVD_VARIABLES ""
set_interface_property cra_slave SVD_ADDRESS_GROUP ""

add_interface_port cra_slave avs_write write Input 1
add_interface_port cra_slave avs_addr address Input CRA_ADDR_W
add_interface_port cra_slave avs_byteena byteenable Input DATA_W/8
add_interface_port cra_slave avs_writedata writedata Input DATA_W
add_interface_port cra_slave avs_readdata readdata Output DATA_W
add_interface_port cra_slave avs_readdatavalid readdatavalid Output 1
add_interface_port cra_slave avs_waitrequest waitrequest Output 1
add_interface_port cra_slave avs_read read Input 1
set_interface_assignment cra_slave embeddedsw.configuration.isFlash 0
set_interface_assignment cra_slave embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment cra_slave embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment cra_slave embeddedsw.configuration.isPrintableDevice 0

