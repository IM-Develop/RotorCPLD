LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
package FPGA_DATE is 
constant FPGA_YEAR	: std_logic_vector(15 downto 0) :=x"2025"; 
constant FPGA_MONTH	: std_logic_vector(7 downto 0)  :=x"04"; 
constant FPGA_DAY		: std_logic_vector(7 downto 0)  :=x"29";  
constant FPGA_HOUR	: std_logic_vector(7 downto 0)  :=x"11";  
constant FPGA_MINUTE	: std_logic_vector(7 downto 0)  :=x"39";  
end FPGA_DATE;
