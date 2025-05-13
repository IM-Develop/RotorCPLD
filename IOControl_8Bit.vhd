library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.AltInitConstantPKG.all;

entity IOControl_8Bit is
	port(
		 csi_c0_reset_n			: in std_logic;--avalon #reset
		 csi_c0_clk				: in std_logic;--avalon clock 25MHz
--*********************** Global signals *****************************************
		 avs_s0_read_n			: in std_logic;
		 avs_s0_write_n			: in std_logic;
		 avs_s0_chipselect_n	: in std_logic;
		 avs_s0_address			: in std_logic_vector(3 downto 0);
		 avs_s0_readdata		: out std_logic_vector(7 downto 0);
		 avs_s0_readdatavalid	: out std_logic;
		 avs_s0_writedata		: in std_logic_vector(7 downto 0);
		 avm_s0_waitrequest		: out std_logic;
--************************* Avalon-MM Slave **************************************
		 IOControl				: buffer std_logic_vector(7 downto 0)
--************************* export signals ***************************************
		);
end IOControl_8Bit;

ARCHITECTURE Arc_IOControl_8Bit OF IOControl_8Bit IS

	type 		States is(T1, T2, T3);
	signal 		State		: States;
	
	signal		IOCtrlSig	: std_logic_vector(7 downto 0);
	
	-- constant	HWVersion	: std_logic_vector(7 downto 0) := x"02";
	-- constant	FWVersion	: std_logic_vector(7 downto 0) := x"01";
	
BEGIN

	avm_s0_waitrequest <= '0';
						
	Avalon_Proc : process(csi_c0_reset_n, csi_c0_clk)
		begin	
			if (csi_c0_reset_n = '0')then
				avs_s0_readdatavalid <= '0';
				avs_s0_readdata	<= (others => '0');
				IOCtrlSig <= x"00";
				IOControl <= (others => '0');
			else
				if rising_edge (csi_c0_clk)then
					IOControl <= IOCtrlSig;
					if (avs_s0_read_n = '0' and avs_s0_chipselect_n = '0') then
						avs_s0_readdatavalid <= '1';
						case avs_s0_address is
							when x"0" =>
								avs_s0_readdata	<= RotorVersion(15 downto 8);--HWVersion
							when x"1" =>
								avs_s0_readdata	<= RotorVersion(7 downto 0);--FWVersion;
							when x"2" =>
								avs_s0_readdata	<= IOCtrlSig;
							when others =>
								avs_s0_readdata	<= x"55";
						end case;
					else
						avs_s0_readdatavalid <= '0';
						avs_s0_readdata	<= (others => '0');
					end if;
					if (avs_s0_write_n = '0' and avs_s0_chipselect_n = '0') then
						if (avs_s0_address = x"2") then
							IOCtrlSig <= avs_s0_writedata;
						end if;
					end if;
				end if;
			end if;
		end process Avalon_Proc;

END Arc_IOControl_8Bit;