--------------------------------------------------------------------------------
-- FILENAME :       hdmi_phy.vhd
-- DESCRIPTION :	  HDMI PHY system for Spartan-6
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
entity hdmi_phy is
port ( 
	serdes_rst			: in STD_LOGIC;
	-- Clocks
	pclk				    : in STD_LOGIC;
	pclkx2				  : in STD_LOGIC;
	pclkx10				  : in STD_LOGIC;
	serdesstrobe		: in STD_LOGIC;
	-- Input interface
	tmds_in				  : in  STD_LOGIC_VECTOR(29 downto 0);
	-- HDMI Interface
	hdmi_data_p 		: out STD_LOGIC_VECTOR( 2 downto 0);
	hdmi_data_n 		: out STD_LOGIC_VECTOR( 2 downto 0);
	hdmi_clk_p 			: out STD_LOGIC;
	hdmi_clk_n 			: out STD_LOGIC
);
end hdmi_phy;
--------------------------------------------------------------------------------
architecture arch_imp of hdmi_phy is
--------------------------------------------------------------------------------
component serdes5to1 is
port ( 
	ioclk					: in  STD_LOGIC;	-- IO Clock network
	serdesstrobe	: in  STD_LOGIC;	-- Parallel data capture strobe
	reset					: in  STD_LOGIC;	-- Reset
	gclk					: in  STD_LOGIC;	-- Global clock
	datain				: in  STD_LOGIC_VECTOR(4 downto 0);	-- Data for output
	iob_data_out	: out STD_LOGIC	--output data
);
end component;

component bram30to15 is
port (
	rst						: in  STD_LOGIC;   -- reset
	clk						: in  STD_LOGIC;   -- clock input
	clkx2					: in  STD_LOGIC; -- 2x clock input
	datain				: in  STD_LOGIC_VECTOR(29 downto 0);
	dataout				: out STD_LOGIC_VECTOR(14 downto 0)
);		
end component;

signal tmds_red				: STD_LOGIC_VECTOR( 9 downto 0);
signal tmds_green			: STD_LOGIC_VECTOR( 9 downto 0);
signal tmds_blue			: STD_LOGIC_VECTOR( 9 downto 0);

signal s_data_in			: STD_LOGIC_VECTOR(29 downto 0);
signal s_data_out			: STD_LOGIC_VECTOR(14 downto 0);

signal tmdsint				: STD_LOGIC_VECTOR( 3 downto 0);
type tmds_data_type is array (3 downto 0) of STD_LOGIC_VECTOR( 4 downto 0);
signal tmds_data			: tmds_data_type	:= (others => (others => '1'));
--------------------------------------------------------------------------------
type s_data_type is array (3 downto 0) of STD_LOGIC_VECTOR(9 downto 0);
signal data_p			    : s_data_type			:= (others => (others => '0'));
signal tmds_shift		  : s_data_type			:= (others => (others => '0'));
signal ddr_cycle_cnt 	: integer range 0 to 4	:= 0;
signal sdr_cycle_cnt 	: integer range 0 to 9	:= 0;
signal pclkx5n			  : STD_LOGIC				:= '0';
--------------------------------------------------------------------------------
begin
--------------------------------------------------------------------------------
tmds_red				<= tmds_in(29 downto 20);
tmds_green			<= tmds_in(19 downto 10);
tmds_blue				<= tmds_in( 9 downto  0);

s_data_in <= 
	tmds_red(9 downto 5) & tmds_green(9 downto 5) & 
	tmds_blue(9 downto 5) & tmds_red(4 downto 0) & 
	tmds_green(4 downto 0) & tmds_blue(4 downto 0);
	
pixel2x: bram30to15
port map(
	rst    				=> serdes_rst,
	clk					  => pclk,
	clkx2    			=> pclkx2,
	datain				=> s_data_in,
	dataout				=> s_data_out
);

tmds_data(0)			<= s_data_out( 4 downto  0);
tmds_data(1)			<= s_data_out( 9 downto  5);
tmds_data(2)			<= s_data_out(14 downto 10);

process(pclkx2)
begin
	if rising_edge(pclkx2) then
		tmds_data(3)	<= not tmds_data(3);
	end if;
end process;

serdes_gen: for i in 0 to 3 generate
	serdes_inst: serdes5to1
	port map(
		ioclk			    => pclkx10,			  -- IO Clock network
		serdesstrobe	=> serdesstrobe,	-- Parallel data capture strobe
		reset			    => serdes_rst,		-- Reset
		gclk			    => pclkx2,			  -- Global clock
		datain			  => tmds_data(i),  -- Data for output
		iob_data_out	=> tmdsint(i)		  -- output data
	);
end generate;

TMDS0: OBUFDS 
port map(
	I					=> tmdsint(0),
	O					=> hdmi_data_p(0),
	OB				=> hdmi_data_n(0)
);
TMDS1: OBUFDS 
port map(
	I					=> tmdsint(1), 
	O					=> hdmi_data_p(1),
	OB				=> hdmi_data_n(1)
);
TMDS2: OBUFDS 
port map(
	I					=> tmdsint(2),
	O					=> hdmi_data_p(2),
	OB				=> hdmi_data_n(2)
);
TMDS3P: OBUFDS 
port map(
	I					=> tmdsint(3),
	O					=> hdmi_clk_p,
	OB				=> hdmi_clk_n
);
--------------------------------------------------------------------------------
end arch_imp;
