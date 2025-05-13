library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity AGG_CPLD_Top is
	port(
		 CPLD_nReset		: in std_logic;
		 FPGA_CLK0			: in std_logic;--25MHz
		 FPGA_CLK1			: in std_logic;
		 ALTLED0			: out std_logic;
		 ALTLED1			: out std_logic;
--*********************** Global signals *****************************************
		 -- GPS_SPI_MISO		: out std_logic;
		 -- GPS_SPI_MOSI		: in std_logic;
		 -- GPS_SPI_NCS		: in std_logic;
		 -- GPS_SPI_SCLK		: in std_logic;
		 P2_I2C_SCL			: in std_logic;--Dart I2C
		 P2_I2C_SDA			: inout std_logic;
--*********************** Dart signals *******************************************
		 -- MDC_CPU
		 -- MDIO_CPU
		 ETH_RESETN			: out std_logic;
		 PB					: in std_logic;
		 ON_nOFF			: buffer std_logic;
		 PROG_E				: in std_logic;
		 DEBUG_E			: in std_logic;
		 P3_DIO1			: in std_logic;
		 P3_DIO2			: in std_logic;
		 P3_DIO3			: in std_logic;
		 PEN				: in std_logic;
--*********************** Global IO **********************************************
		 PHY_0P8V_EN_0		: buffer std_logic;
		 PHY_0P8V_EN_1		: buffer std_logic;
		 PHY_0P8V_EN_2		: buffer std_logic;
		 PHY_1P5V_EN		: buffer std_logic;
		 PHY_2P0V_EN		: buffer std_logic;
		 PHY_2P5V_EN		: buffer std_logic;
		 TEC_SCLK			: out std_logic;
		 TEC_MOSI			: out std_logic;
		 TEC_MISO			: in std_logic;
		 TEC_NCS			: out std_logic;
		 TEC_EN				: out std_logic;
		 TEC_SWEN			: out std_logic;
--*********************** Global signals *****************************************
		 PHY0_MDC			: buffer std_logic;
		 PHY0_MDIO			: inout std_logic;
		 PHY0_NINT			: in std_logic;
		 PHY0_NRST			: buffer std_logic;
		 PHY0_RX_LOS		: in std_logic;
		 PHY0_SCL			: inout std_logic;--optic I2C
		 PHY0_SDA			: inout std_logic;
		 PHY0_TX_DISABLE	: buffer std_logic;
		 PHY0_TX_FAULT		: in std_logic;
--*********************** Global signals *****************************************
		 PHY1_MDC			: buffer std_logic;
		 PHY1_MDIO			: inout std_logic;
		 PHY1_NINT			: in std_logic;
		 PHY1_NRST			: buffer std_logic;
		 PHY1_RX_LOS		: in std_logic;
		 PHY1_SCL			: inout std_logic;--optic I2C
		 PHY1_SDA			: inout std_logic;
		 PHY1_TX_DISABLE	: buffer std_logic;
		 PHY1_TX_FAULT		: in std_logic;
--*********************** Global signals *****************************************
		 PHY2_MDC			: buffer std_logic;
		 PHY2_MDIO			: inout std_logic;
		 PHY2_NINT			: in std_logic;
		 PHY2_NRST			: buffer std_logic;
		 PHY2_RX_LOS		: in std_logic;
		 PHY2_SCL			: inout std_logic;--optic I2C
		 PHY2_SDA			: inout std_logic;
		 PHY2_TX_DISABLE	: buffer std_logic;
		 PHY2_TX_FAULT		: in std_logic;
--*********************** Global signals *****************************************
		 SPI1_MISO			: out std_logic;
		 SPI1_MOSI			: in std_logic;
		 SPI1_NSS			: in std_logic;
		 SPI1_SCK			: in std_logic;
		 -- CPLD_MCU_SP0
		 -- CPLD_MCU_SP1
		 -- CPLD_MCU_SP2
		 -- I2C1_SCL			: in std_logic;--MCU I2C
		 -- I2C1_SDA
--*********************** STM32 signals ******************************************
		 LSR_TX_EN			: out std_logic--;
		 -- WSB_12P0_EN		: buffer std_logic
		);
end AGG_CPLD_Top;

ARCHITECTURE Arc_AGG_CPLD_Top OF AGG_CPLD_Top IS
	
    component AGG_CPLD_QSys is
        port(
             clk_clk           		: in    std_logic                     := 'X';             -- clk
             input_export      		: in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
             mdc0_export       		: out   std_logic;                                        -- export
             mdio0_export      		: inout std_logic                     := 'X';             -- export
             output_export     		: out   std_logic_vector(31 downto 0);                    -- export
             phy0_i2c_SDA      		: inout std_logic                     := 'X';             -- SDA
             phy0_i2c_SCL      		: out   std_logic;                                        -- SCL
             phy1_i2c_SDA      		: inout std_logic                     := 'X';             -- SDA
             phy1_i2c_SCL      		: out   std_logic;                                        -- SCL
             phy2_i2c_SDA      		: inout std_logic                     := 'X';             -- SDA
             phy2_i2c_SCL      		: out   std_logic;                                        -- SCL
             pll_lock_export   		: out   std_logic;                                        -- export
             reset_reset_n     		: in    std_logic                     := 'X';             -- reset_n
             spi_miso_export   		: out   std_logic;                                        -- export
             spi_mosi_export   		: in    std_logic                     := 'X';             -- export
             spi_ncs_export    		: in    std_logic                     := 'X';             -- export
             spi_sclk_export   		: in    std_logic                     := 'X';             -- export
             sysclock_clk      		: out   std_logic;                                        -- clk
             winner_scl_export 		: in    std_logic                     := 'X';             -- export
             winner_sda_export 		: inout std_logic                     := 'X';             -- export
             mdc1_export       		: out   std_logic;                                        -- export
             mdio1_export      		: inout std_logic                     := 'X';             -- export
             mdc2_export       		: out   std_logic;                                        -- export
             mdio2_export      		: inout std_logic                     := 'X';             -- export
			 en_mdio_start_export	: in    std_logic                     := 'X';             -- export
			 iocontrol_8bit_export 	: out   std_logic_vector(7 downto 0)                      -- export
			);
    end component AGG_CPLD_QSys;
	
	component CPLDLedCTRL
		port(
			 nReset    		: in std_logic;
			 Clk       		: in std_logic;
	--*********************** Global signals *****************************************
			 CPLDLed		: buffer std_logic_vector(1 downto 0)
			);
	end component;
	
	component LSR_Enable
		port(
			 csi_c0_reset_n			: in std_logic;--avalon #reset
			 csi_c0_clk				: in std_logic;--avalon clock 25MHz
	--*********************** Global signals *****************************************
			 DIO3					: in std_logic;
			 LSREN					: buffer std_logic
	--************************* export signals ***************************************
			);
	end component;

	signal	IOCtrl		: std_logic_vector(31 downto 0);
	signal	InputIO		: std_logic_vector(31 downto 0);
	signal	Leds		: std_logic_vector(1 downto 0);
	
	signal	PHYxPowerEN	: std_logic;

	signal	Puls100uSec	: std_logic;
	signal	TimeCounter	: std_logic_vector(15 downto 0);
	signal	TVPResetCo	: std_logic_vector(15 downto 0);
	
	signal	ResetFlags	: std_logic_vector(7 downto 0);
	
	signal	SysClock	: std_logic;
	signal	SysnRST		: std_logic;
	
	signal	EnableMDIO	: std_logic;
	
	signal	IO_8Bit		: std_logic_vector(7 downto 0);
	
	signal	LSREN		: std_logic;
	
BEGIN

	ALTLED0 		<= Leds(0);
	ALTLED1 		<= not(DEBUG_E or P3_DIO1 or P3_DIO2 or P3_DIO3 or PROG_E);-- Leds(1);
	
	PHY_1P5V_EN 	<= ResetFlags(0) and IOCtrl(0);
	PHY_2P0V_EN 	<= ResetFlags(0) and IOCtrl(0);
	PHY_2P5V_EN 	<= ResetFlags(0) and IOCtrl(0);
	PHY_0P8V_EN_0 	<= ResetFlags(1) and IOCtrl(1);
	PHY_0P8V_EN_1 	<= ResetFlags(2) and IOCtrl(2);
	PHY_0P8V_EN_2 	<= ResetFlags(3) and IOCtrl(3);
	PHY0_NRST		<= ResetFlags(4) and IOCtrl(4);
	PHY1_NRST		<= ResetFlags(4) and IOCtrl(5);
	PHY2_NRST		<= ResetFlags(4) and IOCtrl(6);
	-- PHY_1P5V_EN 	<= '0';
	-- PHY_2P0V_EN 	<= '0';
	-- PHY_2P5V_EN 	<= '0';
	-- PHY_0P8V_EN_0 	<= '0';
	-- PHY_0P8V_EN_1 	<= '0';
	-- PHY_0P8V_EN_2 	<= '0';
	-- PHY0_NRST		<= '0';
	-- PHY1_NRST		<= '0';
	-- PHY2_NRST		<= '0';
	
	-- WSB_12P0_EN		<= ResetFlags(4) and IOCtrl(11);
	ON_nOFF 		<= ResetFlags(5) and IOCtrl(12);
	PHY0_TX_DISABLE <= ResetFlags(6) or IOCtrl(8);
	PHY1_TX_DISABLE <= ResetFlags(6) or IOCtrl(9);
	PHY2_TX_DISABLE <= ResetFlags(6) or IOCtrl(10);
	EnableMDIO 		<= ResetFlags(7) and PB and IOCtrl(31);
	
	LSR_TX_EN <= IO_8Bit(0) or LSREN;
				
	InputIO(10 downto 0) <= PHY2_TX_FAULT&PHY2_RX_LOS&PHY2_NINT&PHY1_TX_FAULT&PHY1_RX_LOS&PHY1_NINT&PHY0_TX_FAULT&PHY0_RX_LOS&PHY0_NINT&PEN&PB;
	InputIO(31 downto 11) <= (others => '0');
	
	TEC_SCLK <= '1';
	TEC_MOSI <= '1';
	TEC_NCS <= '1';
	TEC_EN <= '0';
	TEC_SWEN <= '0';
		 
    U0 : component AGG_CPLD_QSys
        port map(
				 reset_reset_n  		=> CPLD_nReset,     --      reset.reset_n
				 clk_clk           		=> FPGA_CLK0,           --        clk.clk
				 pll_lock_export   		=> SysnRST,   --   pll_lock.export
				 sysclock_clk      		=> SysClock,      --   sysclock.clk
				 input_export      		=> InputIO,      --      input.export
				 output_export     		=> IOCtrl,     --     output.export
				 phy0_i2c_SDA    		=> PHY0_SDA,    -- phy0_i2c.SDA
				 phy0_i2c_SCL    		=> PHY0_SCL,    --         .SCL
				 phy1_i2c_SDA    		=> PHY1_SDA,    -- phy1_i2c.SDA
				 phy1_i2c_SCL    		=> PHY1_SCL,    --         .SCL
				 phy2_i2c_SDA    		=> PHY2_SDA,    -- phy2_i2c.SDA
				 phy2_i2c_SCL    		=> PHY2_SCL,    --         .SCL
				 spi_miso_export   		=> SPI1_MISO,   --   spi_miso.export
				 spi_mosi_export   		=> SPI1_MOSI,   --   spi_mosi.export
				 spi_ncs_export    		=> SPI1_NSS,    --    spi_ncs.export
				 spi_sclk_export   		=> SPI1_SCK,   --   spi_sclk.export
				 winner_sda_export 		=> P2_I2C_SDA,
				 winner_scl_export 		=> P2_I2C_SCL,
				 mdc0_export       		=> PHY0_MDC,       --       mdc0.export
				 mdio0_export      		=> PHY0_MDIO,      --      mdio0.export
				 mdc1_export       		=> PHY1_MDC,       --       mdc1.export
				 mdio1_export      		=> PHY1_MDIO,      --      mdio1.export
				 mdc2_export       		=> PHY2_MDC,       --       mdc2.export
				 mdio2_export      		=> PHY2_MDIO,      --      mdio2.export
				 en_mdio_start_export	=> EnableMDIO,
				 iocontrol_8bit_export	=> IO_8Bit
				);
				
	U1 : CPLDLedCTRL
		port map(
				 nReset    		 => SysnRST,
				 Clk       		 => SysClock,
				 CPLDLed		 => Leds
				);
				
	U2 : LSR_Enable
		port map(
				 csi_c0_reset_n			=> SysnRST,
				 csi_c0_clk				=> SysClock,
				 DIO3					=> DEBUG_E,
				 LSREN					=> LSREN
				);
		
	Clock100uSec_Proc : process(SysnRST, SysClock)
		begin
			if (SysnRST = '0')then
				TimeCounter <= x"0000";
				Puls100uSec <= '1';
			else
				if rising_edge (SysClock)then
					if (TimeCounter = x"09C4") then
						TimeCounter <= x"0000";
						Puls100uSec <= '1';
					else
						TimeCounter <= TimeCounter + 1;
						Puls100uSec <= '0';
					end if;
				end if;
			end if;
		end process Clock100uSec_Proc;

	Reset_Proc : process(SysnRST, SysClock)--setenv bootcmd run Platform Authenticate rdboot
		begin	
			if (SysnRST = '0')then
				ResetFlags <= x"60";--PHYx_TX_DISABLE, DART OFF
				TVPResetCo <= x"0000";
				ETH_RESETN <= '0';
			else
				if rising_edge (SysClock)then
					-- ETH_RESETN <= '0';
					if (Puls100uSec = '1') then
						if (TVPResetCo(7 downto 0) >= x"F0") then
							case TVPResetCo(15 downto 8) is
								when x"00" =>--switch on common phy power
									ResetFlags <= x"61";
									TVPResetCo(7 downto 0) <= x"00";
									TVPResetCo(15 downto 8) <= TVPResetCo(15 downto 8) + 1;
									ETH_RESETN <= '1';
								when x"01" =>--switch on phy 0 core
									ResetFlags <= x"63";
									TVPResetCo(7 downto 0) <= x"00";
									TVPResetCo(15 downto 8) <= TVPResetCo(15 downto 8) + 1;
								when x"02" =>--switch on phy 1 core
									ResetFlags <= x"67";
									TVPResetCo(7 downto 0) <= x"00";
									TVPResetCo(15 downto 8) <= TVPResetCo(15 downto 8) + 1;
								when x"03" =>--switch on phy 2 core
									ResetFlags <= x"6F";
									TVPResetCo(7 downto 0) <= x"00";
									TVPResetCo(15 downto 8) <= TVPResetCo(15 downto 8) + 1;
								when x"04" =>--switch on 12V / out of phy reset
									ResetFlags <= x"7F";
									TVPResetCo(7 downto 0) <= x"00";
									TVPResetCo(15 downto 8) <= TVPResetCo(15 downto 8) + 1;
								when x"05" =>--switch on Dart
									ResetFlags <= x"5F";
									TVPResetCo(7 downto 0) <= x"00";
									TVPResetCo(15 downto 8) <= TVPResetCo(15 downto 8) + 1;
								when x"06" =>--switch on optic trancievers
									ResetFlags <= x"1F";
									TVPResetCo(7 downto 0) <= x"00";
									TVPResetCo(15 downto 8) <= TVPResetCo(15 downto 8) + 1;
								when x"80" =>--switch on optic trancievers
									ResetFlags <= x"9F";
									TVPResetCo(7 downto 0) <= x"00";
									TVPResetCo(15 downto 8) <= TVPResetCo(15 downto 8) + 1;
								when others =>--hold state and wait for power reset
									if (IOCtrl(15) = '1') then
										ResetFlags <= x"60";
										TVPResetCo <= x"0000";
									else
										ResetFlags <= ResetFlags;
										TVPResetCo(7 downto 0) <= x"00";
										if (TVPResetCo(15 downto 8) = x"FF") then
											TVPResetCo(15 downto 8) <= x"FF";
										else
											TVPResetCo(15 downto 8) <= TVPResetCo(15 downto 8) + 1;
										end if;
									end if;
							end case;
						else
							TVPResetCo(7 downto 0) <= TVPResetCo(7 downto 0) + 1;
							TVPResetCo(15 downto 8) <= TVPResetCo(15 downto 8);
							ResetFlags <= ResetFlags;
						end if;
					end if;
				end if;
			end if;
		end process Reset_Proc;

END Arc_AGG_CPLD_Top;

    -- component AGG_CPLD_QSys is
        -- port (
            -- clk_clk               : in    std_logic                     := 'X';             -- clk
            -- en_mdio_start_export  : in    std_logic                     := 'X';             -- export
            -- heater_export         : out   std_logic;                                        -- export
            -- input_export          : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
            -- mdc0_export           : out   std_logic;                                        -- export
            -- mdc1_export           : out   std_logic;                                        -- export
            -- mdc2_export           : out   std_logic;                                        -- export
            -- mdio0_export          : inout std_logic                     := 'X';             -- export
            -- mdio1_export          : inout std_logic                     := 'X';             -- export
            -- mdio2_export          : inout std_logic                     := 'X';             -- export
            -- output_export         : out   std_logic_vector(31 downto 0);                    -- export
            -- phy0_i2c_SDA          : inout std_logic                     := 'X';             -- SDA
            -- phy0_i2c_SCL          : out   std_logic;                                        -- SCL
            -- phy1_i2c_SDA          : inout std_logic                     := 'X';             -- SDA
            -- phy1_i2c_SCL          : out   std_logic;                                        -- SCL
            -- phy2_i2c_SDA          : inout std_logic                     := 'X';             -- SDA
            -- phy2_i2c_SCL          : out   std_logic;                                        -- SCL
            -- pll_lock_export       : out   std_logic;                                        -- export
            -- reset_reset_n         : in    std_logic                     := 'X';             -- reset_n
            -- spi_miso_export       : out   std_logic;                                        -- export
            -- spi_mosi_export       : in    std_logic                     := 'X';             -- export
            -- spi_ncs_export        : in    std_logic                     := 'X';             -- export
            -- spi_sclk_export       : in    std_logic                     := 'X';             -- export
            -- sysclock_clk          : out   std_logic;                                        -- clk
            -- winner_scl_export     : in    std_logic                     := 'X';             -- export
            -- winner_sda_export     : inout std_logic                     := 'X';             -- export
            -- iocontrol_8bit_export : out   std_logic_vector(7 downto 0)                      -- export
        -- );
    -- end component AGG_CPLD_QSys;

    -- u0 : component AGG_CPLD_QSys
        -- port map (
            -- clk_clk               => CONNECTED_TO_clk_clk,               --            clk.clk
            -- en_mdio_start_export  => CONNECTED_TO_en_mdio_start_export,  --  en_mdio_start.export
            -- heater_export         => CONNECTED_TO_heater_export,         --         heater.export
            -- input_export          => CONNECTED_TO_input_export,          --          input.export
            -- mdc0_export           => CONNECTED_TO_mdc0_export,           --           mdc0.export
            -- mdc1_export           => CONNECTED_TO_mdc1_export,           --           mdc1.export
            -- mdc2_export           => CONNECTED_TO_mdc2_export,           --           mdc2.export
            -- mdio0_export          => CONNECTED_TO_mdio0_export,          --          mdio0.export
            -- mdio1_export          => CONNECTED_TO_mdio1_export,          --          mdio1.export
            -- mdio2_export          => CONNECTED_TO_mdio2_export,          --          mdio2.export
            -- output_export         => CONNECTED_TO_output_export,         --         output.export
            -- phy0_i2c_SDA          => CONNECTED_TO_phy0_i2c_SDA,          --       phy0_i2c.SDA
            -- phy0_i2c_SCL          => CONNECTED_TO_phy0_i2c_SCL,          --               .SCL
            -- phy1_i2c_SDA          => CONNECTED_TO_phy1_i2c_SDA,          --       phy1_i2c.SDA
            -- phy1_i2c_SCL          => CONNECTED_TO_phy1_i2c_SCL,          --               .SCL
            -- phy2_i2c_SDA          => CONNECTED_TO_phy2_i2c_SDA,          --       phy2_i2c.SDA
            -- phy2_i2c_SCL          => CONNECTED_TO_phy2_i2c_SCL,          --               .SCL
            -- pll_lock_export       => CONNECTED_TO_pll_lock_export,       --       pll_lock.export
            -- reset_reset_n         => CONNECTED_TO_reset_reset_n,         --          reset.reset_n
            -- spi_miso_export       => CONNECTED_TO_spi_miso_export,       --       spi_miso.export
            -- spi_mosi_export       => CONNECTED_TO_spi_mosi_export,       --       spi_mosi.export
            -- spi_ncs_export        => CONNECTED_TO_spi_ncs_export,        --        spi_ncs.export
            -- spi_sclk_export       => CONNECTED_TO_spi_sclk_export,       --       spi_sclk.export
            -- sysclock_clk          => CONNECTED_TO_sysclock_clk,          --       sysclock.clk
            -- winner_scl_export     => CONNECTED_TO_winner_scl_export,     --     winner_scl.export
            -- winner_sda_export     => CONNECTED_TO_winner_sda_export,     --     winner_sda.export
            -- iocontrol_8bit_export => CONNECTED_TO_iocontrol_8bit_export  -- iocontrol_8bit.export
        -- );
