#set year [clock format [clock seconds] -format {%Y %m %d %H %M %S}]
set FPGA_YEAR  [clock format [clock seconds] -format {%Y}]
set FPGA_MONTH  [clock format [clock seconds] -format {%m}] 
set FPGA_DAY   [clock format [clock seconds] -format {%d}] 
set FPGA_HOUR  [clock format [clock seconds] -format {%H}] 
set FPGA_MINUTE [clock format [clock seconds] -format {%M}]

#post_message -type info "${year} ${month} ${day} ${hour} ${minutes}"


if { [catch {
	set fh [open "FPGA_DATE.vhd" w ]
	puts $fh "LIBRARY ieee;"
	puts $fh "USE ieee.std_logic_1164.ALL;"
	puts $fh "package FPGA_DATE is "	
	puts $fh "constant FPGA_YEAR	: std_logic_vector(15 downto 0) :=x\"${FPGA_YEAR}\"; "
	puts $fh "constant FPGA_MONTH	: std_logic_vector(7 downto 0)  :=x\"${FPGA_MONTH}\"; " 
	puts $fh "constant FPGA_DAY		: std_logic_vector(7 downto 0)  :=x\"${FPGA_DAY}\";  "
	puts $fh "constant FPGA_HOUR	: std_logic_vector(7 downto 0)  :=x\"${FPGA_HOUR}\";  "
	puts $fh "constant FPGA_MINUTE	: std_logic_vector(7 downto 0)  :=x\"${FPGA_MINUTE}\";  "
	puts $fh "end FPGA_DATE;"
	close $fh
    } res ] } 	{		
		post_message -type error $res   
    } else {	
		post_message -type info "FPGA Time stamp FPGA_DATE file was generated successfully."   
    }
	
#	if { [catch {
#	set fh [open "FPGA_DATE.h" w ]
#	puts $fh "#define FPGA_YEAR	(0x${FPGA_YEAR})"
#	puts $fh "#define FPGA_MONTH	(0x${FPGA_MONTH})" 
#	puts $fh "#define FPGA_DAY	(0x${FPGA_DAY})"
#	puts $fh "#define FPGA_HOUR	(0x${FPGA_HOUR})"
#	puts $fh "#define FPGA_MINUTE	(0x${FPGA_MINUTE})"
#	close $fh
#    } res ] } 	{		
#		post_message -type error $res   
#    } else {	
#		post_message -type info "FPGA Time stamp FPGA_DATE.h file was generated successfully."   
#    }