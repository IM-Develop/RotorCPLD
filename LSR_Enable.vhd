library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity LSR_Enable is
	port(
		 csi_c0_reset_n			: in std_logic;--avalon #reset
		 csi_c0_clk				: in std_logic;--avalon clock 25MHz
--*********************** Global signals *****************************************
		 DIO3					: in std_logic;
		 LSREN					: buffer std_logic
--************************* export signals ***************************************
		);
end LSR_Enable;

ARCHITECTURE Arc_LSR_Enable OF LSR_Enable IS

	type 	States is(T1, T2, T3);
	signal 	State		: States;
	
	signal	DebouncerS	: std_logic_vector(2 downto 0);
	signal	Debouncer	: std_logic_vector(3 downto 0);
	signal	CountIO		: std_logic_vector(3 downto 0);
	
BEGIN

	Debouncer_Proc : process(csi_c0_reset_n, csi_c0_clk)
		begin	
			if (csi_c0_reset_n = '0')then
				Debouncer <= (others => '0');
				DebouncerS <= "111";
			else
				if rising_edge (csi_c0_clk)then
					DebouncerS(0) <= DIO3;
					DebouncerS(1) <= DebouncerS(0);
					if (DebouncerS(0) = DebouncerS(1)) then
						if (Debouncer = x"F") then
							DebouncerS(2) <= DebouncerS(1);
							Debouncer <= x"F";
						else
							DebouncerS(2) <= DebouncerS(2);
							Debouncer <= Debouncer + 1;
						end if;
					else
						DebouncerS(2) <= DebouncerS(2);
						Debouncer <= (others => '0');
					end if;
				end if;
			end if;
		end process Debouncer_Proc;

	Clocked_Proc : process(csi_c0_reset_n, csi_c0_clk)
		begin	
			if (csi_c0_reset_n = '0')then
				LSREN <= '0';
				CountIO <= x"0";
			else
				if rising_edge (csi_c0_clk)then
					if (DebouncerS(0) = DebouncerS(1) and DebouncerS(2) /= DebouncerS(1) and Debouncer = x"F") then--change of state
						if (CountIO >= x"3") then
							CountIO <= x"3";
							LSREN <= '1';
						else
							CountIO <= CountIO + 1;
							LSREN <= '0';
						end if;
					else
						CountIO <= CountIO;
						LSREN <= LSREN;
					end if;
				end if;
			end if;
		end process Clocked_Proc;

END Arc_LSR_Enable;