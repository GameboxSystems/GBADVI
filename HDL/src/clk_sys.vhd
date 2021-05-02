--------------------------------------------------------------------------------
-- FILENAME :       clk_sys.vhd
-- DESCRIPTION :	  Clocking system
-- @author: Oleksandr Kiyenko
-- If you find this code useful you know what to do
-- bc1q8pflngx8qhaxtjvyhevdft4r6jvztrcm70fxz9
--------------------------------------------------------------------------------
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
Library UNISIM;
use UNISIM.vcomponents.all;
--------------------------------------------------------------------------------
entity clk_sys is
port (
	clk_in				: in  STD_LOGIC;	-- Input 74.25MHz
	pclk				  : out STD_LOGIC;	-- pixel clock 74.25 MHz
	pclk2x				: out STD_LOGIC;	-- pclk*2 
	pclk10x				: out STD_LOGIC;	-- pclk*10
	sclk				  : out STD_LOGIC;	-- system clock 106 MHz
	dclk				  : out STD_LOGIC;	-- slow clock 25 MHz
	serdesstrobe	: out STD_LOGIC;
	serdesrst			: out STD_LOGIC;
	pll_lock			: out STD_LOGIC;
	buf_lock			: out STD_LOGIC
);
end clk_sys;
--------------------------------------------------------------------------------
architecture arch_imp of clk_sys is
--------------------------------------------------------------------------------
signal clkfbout         : STD_LOGIC;
signal clkfbout_buf     : STD_LOGIC;
signal pll_clk10x		    : STD_LOGIC;
signal pll_clk2x		    : STD_LOGIC;
signal pll_clk1x		    : STD_LOGIC;
signal pll_sclk			    : STD_LOGIC;
signal pll_dclk			    : STD_LOGIC;
signal pll_locked		    : STD_LOGIC;
signal bufpll_lock		  : STD_LOGIC;
signal pll_clk2x_buf	  : STD_LOGIC;
--------------------------------------------------------------------------------
begin
--------------------------------------------------------------------------------
pll_base_inst : PLL_BASE
generic map(
	BANDWIDTH            => "OPTIMIZED",
	CLK_FEEDBACK         => "CLKFBOUT",
	COMPENSATION         => "SYSTEM_SYNCHRONOUS",
	DIVCLK_DIVIDE        => 1,
	CLKFBOUT_MULT        => 10,
	CLKFBOUT_PHASE       => 0.000,
	CLKOUT0_DIVIDE       => 1,
	CLKOUT0_PHASE        => 0.000,
	CLKOUT0_DUTY_CYCLE   => 0.500,
	CLKOUT1_DIVIDE       => 5,
	CLKOUT1_PHASE        => 0.000,
	CLKOUT1_DUTY_CYCLE   => 0.500,
	CLKOUT2_DIVIDE       => 10,
	CLKOUT2_PHASE        => 0.000,
	CLKOUT2_DUTY_CYCLE   => 0.500,
	CLKOUT3_DIVIDE       => 7,
	CLKOUT3_PHASE        => 0.000,
	CLKOUT3_DUTY_CYCLE   => 0.500,
	CLKOUT4_DIVIDE       => 30,
	CLKOUT4_PHASE        => 0.000,
	CLKOUT4_DUTY_CYCLE   => 0.500,
	CLKIN_PERIOD         => 13.468,
	REF_JITTER           => 0.010
)
port map(
	CLKFBOUT            => clkfbout,
	CLKOUT0             => pll_clk10x,
	CLKOUT1             => pll_clk2x,
	CLKOUT2             => pll_clk1x,
	CLKOUT3             => pll_sclk,
	CLKOUT4             => pll_dclk,
	-- Status and control signals
	LOCKED              => pll_locked,
	RST                 => '0',--pll_reset,
	-- Input clock control
	CLKFBIN             => clkfbout_buf,
	CLKIN				        => clk_in
);

clkf_buf : BUFG
port map(
	O 					  => clkfbout_buf,
    I 					=> clkfbout
);

sclk_buf : BUFG
port map(
	O 					  => sclk,
    I 					=> pll_sclk
);

dclk_buf : BUFG
port map(
	O 					  => dclk,
    I 					=> pll_dclk
);

pll_lock				<= pll_locked;

pll1_buf1x_inst: BUFG
port map(
	I					    => pll_clk1x,
	O					    => pclk
);

pll1_buf2x_inst: BUFG
port map(
	I					    => pll_clk2x,
	O					    => pll_clk2x_buf
);
pclk2x					<= pll_clk2x_buf;

BUFPLL_inst : BUFPLL
generic map (
	DIVIDE 				=> 5 -- Set the PLLIN divider divide-by value for SERDESSTROBE.
)
port map (
	IOCLK 				=> pclk10x,		-- 1-bit Output PLL clock
	LOCK 				  => bufpll_lock,	-- 1-bit Synchronized LOCK output
	SERDESSTROBE 	=> serdesstrobe,		-- 1-bit Output SERDES strobe (clock enable)
	GCLK 				  => pll_clk2x_buf,		-- 1-bit GCLK clock input
	LOCKED				=> pll_locked,	-- 1-bit LOCKED sign from PLL input
	PLLIN				  => pll_clk10x		-- 1-bit PLL clock input
);

buf_lock				<= bufpll_lock;
serdesrst				<= not bufpll_lock;
--------------------------------------------------------------------------------
end arch_imp;
