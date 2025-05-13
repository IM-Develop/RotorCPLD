library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.FPGA_DATE.all;
use work.AltInitConstantPKG.all;

entity SystemID is
	port(
		 csi_c0_reset_n			: in std_logic;--avalon #reset
		 csi_c0_clk				: in std_logic;--avalon clock 108MHz
--*********************** Global signals *****************************************
		 avs_s0_read_n			: in std_logic;
		 avs_s0_chipselect_n	: in std_logic;
		 avs_s0_address			: in std_logic;
		 avs_s0_readdata		: buffer std_logic_vector(31 downto 0);
		 avs_s0_readdatavalid	: out std_logic;
		 avs_s0_waitrequest		: out std_logic
--************************* Avalon-MM Slave **************************************
		);
end SystemID;

ARCHITECTURE Arc_SystemID OF SystemID IS

	
BEGIN

	avs_s0_waitrequest <= '0';

	Avalon_Proc : process(csi_c0_reset_n, csi_c0_clk)
		begin	
			if (csi_c0_reset_n = '0')then
				avs_s0_readdatavalid <= '0';
				avs_s0_readdata	<= (others => '0');
			else
				if rising_edge (csi_c0_clk)then
					if (avs_s0_read_n = '0' and avs_s0_chipselect_n = '0') then
						avs_s0_readdatavalid <= '1';
						case avs_s0_address is
							when '0' =>
								avs_s0_readdata	<= RotorVersion;
							when others =>
								avs_s0_readdata	<= FPGA_MONTH & FPGA_DAY & FPGA_YEAR;
						end case;
					else
						avs_s0_readdatavalid <= '0';
						avs_s0_readdata	<= (others => '0');
					end if;
				end if;
			end if;
		end process Avalon_Proc;

END Arc_SystemID;