--------------------------------------------------------------------------------
-- FILENAME :       DVI_video_720p.vhd
-- DESCRIPTION :	  DVI video system
-- @author:         Oleksandr Kiyenko
-- If you find this code useful you know what to do
-- bc1q8pflngx8qhaxtjvyhevdft4r6jvztrcm70fxz9
--------------------------------------------------------------------------------
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
Library UNISIM;
use UNISIM.vcomponents.all;
--------------------------------------------------------------------------------
entity dvi_video_720p is
generic(
	BIT_WIDTH 					: integer	:= 11;
	BIT_HEIGHT					: integer	:= 10
);
port ( 
	-- Clocks
	pclk						    : in  STD_LOGIC;
	pclkx2						  : in  STD_LOGIC;
	pclkx10						  : in  STD_LOGIC;
	serdesstrobe				: in  STD_LOGIC;
	aresetn   					: in  STD_LOGIC;
	-- Position
	position_x					: out STD_LOGIC_VECTOR(BIT_WIDTH -1 downto 0);
	position_y					: out STD_LOGIC_VECTOR(BIT_HEIGHT-1 downto 0);
	frame_width					: out STD_LOGIC_VECTOR(BIT_WIDTH -1 downto 0);
	frame_height				: out STD_LOGIC_VECTOR(BIT_HEIGHT-1 downto 0);
	screen_width				: out STD_LOGIC_VECTOR(BIT_WIDTH -1 downto 0);
	screen_height				: out STD_LOGIC_VECTOR(BIT_HEIGHT-1 downto 0);
	screen_start_x			: out STD_LOGIC_VECTOR(BIT_WIDTH -1 downto 0);
	screen_start_y			: out STD_LOGIC_VECTOR(BIT_HEIGHT-1 downto 0);
	-- Video
	video_data					: in  STD_LOGIC_VECTOR(23 downto 0);
	-- HDMI Interface		
	hdmi_data_p 				: out STD_LOGIC_VECTOR( 2 downto 0);
	hdmi_data_n 				: out STD_LOGIC_VECTOR( 2 downto 0);
	hdmi_clk_p 					: out STD_LOGIC;
	hdmi_clk_n 					: out STD_LOGIC
);
end dvi_video_720p;
--------------------------------------------------------------------------------
architecture arch_imp of dvi_video_720p is
--------------------------------------------------------------------------------
component tmds_encoder is
generic(
	CHANNEL						: integer	:= 0
);		
port (		
	pclk						  : in  STD_LOGIC;
	video_data				: in  STD_LOGIC_VECTOR(7 downto 0);
	control_data			: in  STD_LOGIC_VECTOR(1 downto 0);
	active_video		  : in  STD_LOGIC;
	tmds						  : out STD_LOGIC_VECTOR(9 downto 0)	:= (others => '0')
);
end component;

component hdmi_phy is
port ( 
	serdes_rst				: in STD_LOGIC;
	-- Clocks		
	pclk						  : in STD_LOGIC;
	pclkx2						: in STD_LOGIC;
	pclkx10						: in STD_LOGIC;
	serdesstrobe			: in STD_LOGIC;
	-- Input interface		
	tmds_in						: in  STD_LOGIC_VECTOR(29 downto 0);
	-- HDMI Interface		
	hdmi_data_p 			: out STD_LOGIC_VECTOR( 2 downto 0);
	hdmi_data_n 			: out STD_LOGIC_VECTOR( 2 downto 0);
	hdmi_clk_p 				: out STD_LOGIC;
	hdmi_clk_n 				: out STD_LOGIC
);
end component;
--------------------------------------------------------------------------------
signal TMDS_data		: STD_LOGIC_VECTOR(29 downto 0);
signal control_data	: STD_LOGIC_VECTOR( 5 downto 0);
signal DrawArea			: STD_LOGIC;
signal CounterX			: UNSIGNED(BIT_WIDTH-1 downto 0)	:= (others => '0');
signal CounterY			: UNSIGNED(BIT_HEIGHT-1 downto 0)	:= (others => '0');
signal vSync 				: STD_LOGIC;
signal hSync				: STD_LOGIC;
signal serdes_rst   : STD_LOGIC;
--------------------------------------------------------------------------------
begin
--------------------------------------------------------------------------------
serdes_rst    <= not aresetn;

process(pclk)
begin
	if rising_edge(pclk) then
		if(CounterX = (1650-1))then
			CounterX		<= (others => '0');
			if(CounterY = (750-1))then
				CounterY	<= (others => '0');
			else
				CounterY	<= CounterY + 1;
			end if;
		else
			CounterX		<= CounterX + 1;
		end if;

		if((CounterX > 1650-1280) and (CounterY > 750-720))then
			DrawArea		<= '1';
		else
			DrawArea		<= '0';
		end if;
		
		if((CounterX >= 110) and (CounterX < 110+40))then
			hSync			<= '1';
		else
			hSync			<= '0';
		end if;

		if((CounterY >= 5) and (CounterY < 5+5))then
			vSync			<= '1';
		else
			vSync			<= '0';
		end if;
	end if;
end process;

position_x					<= STD_LOGIC_VECTOR(CounterX);
position_y					<= STD_LOGIC_VECTOR(CounterY);

frame_width					<= STD_LOGIC_VECTOR(TO_UNSIGNED(1650,BIT_WIDTH));
frame_height				<= STD_LOGIC_VECTOR(TO_UNSIGNED(750,BIT_HEIGHT));
screen_width				<= STD_LOGIC_VECTOR(TO_UNSIGNED(1280,BIT_WIDTH));
screen_height				<= STD_LOGIC_VECTOR(TO_UNSIGNED(720,BIT_HEIGHT));
screen_start_x			<= STD_LOGIC_VECTOR(TO_UNSIGNED((1650-1280),BIT_WIDTH));
screen_start_y			<= STD_LOGIC_VECTOR(TO_UNSIGNED((750-720),BIT_HEIGHT));

control_data				<= "0000" & vSync & hSync;

lane_gen: for i in 0 to 2 generate
	encoder_inst: tmds_encoder
	generic map(
		CHANNEL				    => i
	)
	port map(
		pclk				      => pclk,
		video_data		  	=> video_data(i*8+7 downto i*8), 
		control_data	  	=> control_data(i*2+1 downto i*2), 
    active_video      => DrawArea,
		tmds				      => TMDS_data(i*10+9 downto i*10)
	);
	
end generate;

hdmi_phy_inst: hdmi_phy
port map(
	pclk					    => pclk,
	pclkx2					  => pclkx2,
	pclkx10					  => pclkx10,
	serdesstrobe			=> serdesstrobe,
	serdes_rst				=> serdes_rst,
	tmds_in					  => TMDS_data,
	hdmi_data_p				=> hdmi_data_p,
	hdmi_data_n				=> hdmi_data_n,
	hdmi_clk_p 				=> hdmi_clk_p,
	hdmi_clk_n 				=> hdmi_clk_n
);
--------------------------------------------------------------------------------
end arch_imp;
