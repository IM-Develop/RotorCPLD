library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity HeaterCtrl is
	generic	(
			 MaxPower			: std_logic_vector(7 downto 0) := x"64"
			);
	port(
		 csi_c0_reset_n			: in std_logic;--avalon #reset
		 csi_c0_clk				: in std_logic;--avalon clock 25MHz
--*********************** Global signals *****************************************
		 avs_s0_read_n			: in std_logic;
		 avs_s0_write_n			: in std_logic;
		 avs_s0_chipselect_n	: in std_logic;
		 avs_s0_readdata		: out std_logic_vector(31 downto 0);
		 avs_s0_readdatavalid	: out std_logic;
		 avs_s0_writedata		: in std_logic_vector(31 downto 0);
		 avs_s0_waitrequest		: out std_logic;
--************************* Avalon-MM Slave **************************************
		 Heater					: out std_logic
		);
end HeaterCtrl;

ARCHITECTURE Arc_HeaterCtrl OF HeaterCtrl IS

	signal	EchoReg0	: std_logic_vector(31 downto 0);

	signal	PWMCounter	: std_logic_vector(23 downto 0);
	signal	FreqCounter	: std_logic_vector(19 downto 0);
	
BEGIN

	avs_s0_waitrequest <= '0';
	
	Avalon_Proc : process(csi_c0_reset_n, csi_c0_clk)
		begin
			if (csi_c0_reset_n = '0')then
				avs_s0_readdatavalid <= '0';
				avs_s0_readdata	<= (others => '0');
				EchoReg0 <= (others => '0');
			else
				if rising_edge (csi_c0_clk)then
					if (avs_s0_read_n = '0' and avs_s0_chipselect_n = '0') then
						avs_s0_readdatavalid <= '1';
						avs_s0_readdata	<= EchoReg0;
					else
						avs_s0_readdatavalid <= '0';
						avs_s0_readdata	<= (others => '0');
					end if;
					if (avs_s0_write_n = '0' and avs_s0_chipselect_n = '0') then
						if (avs_s0_writedata(7 downto 0) < MaxPower) then
							EchoReg0(7 downto 0) <= avs_s0_writedata(7 downto 0);
						else
							EchoReg0(7 downto 0) <= MaxPower;
						end if;
						EchoReg0(31 downto 8) <= avs_s0_writedata(31 downto 8);
					end if;
				end if;
			end if;
		end process Avalon_Proc;

	Heater_Proc : process(csi_c0_reset_n, csi_c0_clk)
		begin
			if (csi_c0_reset_n = '0')then
				Heater <= '0';
				FreqCounter <= (others => '0');
				PWMCounter <= (others => '0');
			else
				if rising_edge (csi_c0_clk)then
					if (PWMCounter(23 downto 16) <= EchoReg0(7 downto 0) and EchoReg0(7 downto 0) /= x"00") then
						Heater <= '1';
					else
						Heater <= '0';
					end if;
					if (FreqCounter >= x"1869F") then--250Hz
						FreqCounter <= (others => '0');
						PWMCounter <= (others => '0');
					else
						FreqCounter <= FreqCounter + 1;
						if (PWMCounter(15 downto 0) >= x"03E7") then--250Hz/100
							PWMCounter(15 downto 0) <= x"0000";
							PWMCounter(23 downto 16) <= PWMCounter(23 downto 16) + 1;
						else
							PWMCounter(15 downto 0) <= PWMCounter(15 downto 0) + 1;
							PWMCounter(23 downto 16) <= PWMCounter(23 downto 16);
						end if;
					end if;
				end if;
			end if;
		end process Heater_Proc;

END Arc_HeaterCtrl;