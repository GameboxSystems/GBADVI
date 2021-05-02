--------------------------------------------------------------------------------
-- GameBoy Advance screen interface to HDMI adapter
-- Copyright (C) 2021 Oleksandr Kiyenko o.kiyenko@gmail.com

-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.

-- FILENAME :       top.vhd
-- DESCRIPTION :	  System top level
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
entity top is
port (	
	pclk_in						: in  STD_LOGIC;
	--led							: out STD_LOGIC;
	-- GBA
	gba_clk						: in  STD_LOGIC;
	gba_hs						: in  STD_LOGIC;
	gba_vs						: in  STD_LOGIC;
	gba_r						  : in  STD_LOGIC_VECTOR( 4 downto 0);
	gba_g						  : in  STD_LOGIC_VECTOR( 4 downto 0);
	gba_b						  : in  STD_LOGIC_VECTOR( 4 downto 0);
	-- SDRAM	
	sdram_clk					: out STD_LOGIC;
	sdram_cle					: out STD_LOGIC;
	sdram_dqm					: out STD_LOGIC;
	sdram_cs					: out STD_LOGIC;
	sdram_we					: out STD_LOGIC;
	sdram_cas					: out STD_LOGIC;
	sdram_ras					: out STD_LOGIC;
	sdram_ba					: out STD_LOGIC_VECTOR( 1 downto 0);
	sdram_a						: out STD_LOGIC_VECTOR(12 downto 0);
	sdram_dq					: inout STD_LOGIC_VECTOR( 7 downto 0);
	-- HDMI Interface		
	hdmi1_d_p 				: out STD_LOGIC_VECTOR( 2 downto 0);
	hdmi1_d_n 				: out STD_LOGIC_VECTOR( 2 downto 0);
	hdmi1_c_p 				: out STD_LOGIC;
	hdmi1_c_n	 				: out STD_LOGIC;
	-- Controller
	DATA_NES					: in  STD_LOGIC;
	CLK_NES						: out STD_LOGIC;
	LATCH_NES					: out STD_LOGIC;
	L_BUTTON					: out STD_LOGIC;
	UP_BUTTON					: out STD_LOGIC;
	LEFT_BUTTON				: out STD_LOGIC;
	DOWN_BUTTON				: out STD_LOGIC;
	RIGHT_BUTTON			: out STD_LOGIC;
	SELECT_BUTTON			: out STD_LOGIC;
	START_BUTTON			: out STD_LOGIC;
	R_BUTTON					: out STD_LOGIC;
	A_BUTTON					: out STD_LOGIC;
	B_BUTTON					: out STD_LOGIC
);
end top;
--------------------------------------------------------------------------------
architecture arch_imp of top is
--------------------------------------------------------------------------------
component clk_sys is
port (
	clk_in						: in  STD_LOGIC;	-- Input 74.25MHz
	pclk						  : out STD_LOGIC;	-- pixel clock 74.25 MHz
	pclk2x						: out STD_LOGIC;	-- pclk*2 
	pclk10x						: out STD_LOGIC;	-- pclk*10
	sclk						  : out STD_LOGIC;	-- system clock ~106 MHz
	dclk						  : out STD_LOGIC;	-- slow clock 25 MHz
	serdesstrobe			: out STD_LOGIC;
	serdesrst					: out STD_LOGIC;
	pll_lock					: out STD_LOGIC;
	buf_lock					: out STD_LOGIC
);
end component;

component gba_axis is
generic (
	X_RES						  : integer	:= 240;
	Y_RES						  : integer	:= 160
);		
port (		
	aclk						  : in  STD_LOGIC;
	gba_clk						: in  STD_LOGIC;
	gba_hs						: in  STD_LOGIC;
	gba_vs						: in  STD_LOGIC;
	gba_r						  : in  STD_LOGIC_VECTOR(4 downto 0)	:= (others => '0');
	gba_g						  : in  STD_LOGIC_VECTOR(4 downto 0)	:= (others => '0');
	gba_b						  : in  STD_LOGIC_VECTOR(4 downto 0)	:= (others => '0');
	m_axis_tvalid			: out STD_LOGIC;
	m_axis_tuser			: out STD_LOGIC_VECTOR( 0 downto 0)	:= (others => '0');
	m_axis_tdata			: out STD_LOGIC_VECTOR(31 downto 0)	:= (others => '0');
	m_axis_tlast			: out STD_LOGIC
);
end component;

component dvi_video_720p is
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
end component;

component packer_fifo is
port(
	m_aclk						: in  STD_LOGIC;
	s_aclk						: in  STD_LOGIC;
	s_aresetn					: in  STD_LOGIC;
	s_axis_tvalid			: in  STD_LOGIC;
	s_axis_tready			: out STD_LOGIC;
	s_axis_tdata			: in  STD_LOGIC_VECTOR(31 downto 0);
	s_axis_tlast			: in  STD_LOGIC;
	s_axis_tuser			: in  STD_LOGIC_VECTOR( 0 downto 0);
	m_axis_tvalid			: out STD_LOGIC;
	m_axis_tready			: in  STD_LOGIC;
	m_axis_tdata			: out STD_LOGIC_VECTOR(31 downto 0);
	m_axis_tlast			: out STD_LOGIC;
	m_axis_tuser			: out STD_LOGIC_VECTOR( 0 downto 0)
);
end component;

component sdram_ctrl is
port(
	aclk						  : in  STD_LOGIC;
	-- Write Interface
	s0_axis_tvalid		: in  STD_LOGIC;
	s0_axis_tready		: out STD_LOGIC;
	s0_axis_tdata			: in  STD_LOGIC_VECTOR(31 downto 0);
	s0_axis_tdest			: in  STD_LOGIC_VECTOR(22 downto 0);
	-- Read Interface
	s1_axis_tvalid		: in  STD_LOGIC;
	s1_axis_tready		: out STD_LOGIC;
	s1_axis_tdata			: out STD_LOGIC_VECTOR(31 downto 0);
	s1_axis_tdest			: in  STD_LOGIC_VECTOR(22 downto 0);
	-- SDRAM interface
	sdram_addr				: out STD_LOGIC_VECTOR(22 downto 0);	-- address
	sdram_rw					: out STD_LOGIC;					-- 1 = write, 0 = read
	sdram_data_in			: out STD_LOGIC_VECTOR(31 downto 0);	-- data from a read
	sdram_data_out		: in  STD_LOGIC_VECTOR(31 downto 0); 	-- data for a write
	sdram_busy				: in  STD_LOGIC;  -- controller is busy when high
	sdram_in_valid		: out STD_LOGIC;  -- pulse high to initiate a read/write
	sdram_out_valid		: in  STD_LOGIC -- pulses high when data from read is valid
);
end component;

component sdram is
port(
	clk							  : in  STD_LOGIC;
	rst							  : in  STD_LOGIC;
	-- these signals go directly to the IO pins
	sdram_clk					: out STD_LOGIC;
	sdram_cle					: out STD_LOGIC;
	sdram_cs					: out STD_LOGIC;
	sdram_cas					: out STD_LOGIC;
	sdram_ras					: out STD_LOGIC;
	sdram_we					: out STD_LOGIC;
	sdram_dqm					: out STD_LOGIC;
	sdram_ba					: out STD_LOGIC_VECTOR( 1 downto 0);
	sdram_a						: out STD_LOGIC_VECTOR(12 downto 0);
	sdram_dq					: out STD_LOGIC_VECTOR( 7 downto 0);
	-- User interface
	addr						  : in  STD_LOGIC_VECTOR(22 downto 0);	-- address
	rw							  : in  STD_LOGIC;  -- 1 = write, 0 = read
	data_in						: in  STD_LOGIC_VECTOR(31 downto 0);	-- data from a read
	data_out					: out STD_LOGIC_VECTOR(31 downto 0); 	-- data for a write
	busy						  : out STD_LOGIC; -- controller is busy when high
	in_valid					: in  STD_LOGIC; -- pulse high to initiate a read/write
	out_valid					: out STD_LOGIC	-- pulses high when data from read is valid
);
end component;

component packer is
generic(
	X_RES						  : integer	:= 240;
	Y_RES						  : integer	:= 160
);
port (
	aclk						  : in  STD_LOGIC;
	s_axis_tvalid			: in  STD_LOGIC;
	s_axis_tready			: out STD_LOGIC;
	s_axis_tdata			: in  STD_LOGIC_VECTOR(31 downto 0);
	s_axis_tlast			: in  STD_LOGIC;
	s_axis_tuser			: in  STD_LOGIC_VECTOR( 0 downto 0);
	m_axis_tvalid			: out STD_LOGIC;
	m_axis_tready			: in  STD_LOGIC;
	m_axis_tdata			: out STD_LOGIC_VECTOR(31 downto 0);
	m_axis_tdest			: out STD_LOGIC_VECTOR(22 downto 0);
  buf_num           : out STD_LOGIC
);
end component;

component loader is
generic(
	X_RES						  : integer	:= 240;
	Y_RES						  : integer	:= 160
);
port (	
	aclk						  : in  STD_LOGIC;
	
	pclk						  : in  STD_LOGIC;
	line_start				: in  STD_LOGIC;
	line_num					: in  STD_LOGIC_VECTOR( 7 downto 0);
	buf_num						: in  STD_LOGIC;
	
	b_axis_tvalid			: out STD_LOGIC;
	b_axis_tready			: in  STD_LOGIC;
	b_axis_tdata			: in  STD_LOGIC_VECTOR(31 downto 0);
	b_axis_tdest			: out STD_LOGIC_VECTOR(22 downto 0);
	
	bram_addr					: out STD_LOGIC_VECTOR( 8 downto 0);
	bram_data					: out STD_LOGIC_VECTOR(31 downto 0);
	bram_we						: out STD_LOGIC_VECTOR( 0 downto 0)
);
end component;

component line_buffer is
port (
    clka						: in  STD_LOGIC;
    wea							: in  STD_LOGIC_VECTOR( 0 downto 0);
    addra						: in  STD_LOGIC_VECTOR( 8 downto 0);
    dina						: in  STD_LOGIC_VECTOR(31 downto 0);
    clkb						: in  STD_LOGIC;
    addrb						: in  STD_LOGIC_VECTOR( 8 downto 0);
    doutb						: out STD_LOGIC_VECTOR(31 downto 0)
);
end component;

component nes_controller is
generic (
	C_CLK_DIV					: integer	:= 74
);
port (
	clk							  : in  STD_LOGIC;
	-- R,L,X,A,Right,Left,Down,Up,Start,Select,Y,B - SNES
	-- -,-,-,-,Right,Left,Down,Up,Start,Select,B,A - NES
	data_out					: out STD_LOGIC_VECTOR(15 downto 0);
	nes_clock					: out STD_LOGIC;
	nes_latch					: out STD_LOGIC;
	nes_data					: in  STD_LOGIC	:= '0'
);
end component;
--------------------------------------------------------------------------------
constant BIT_WIDTH 				: integer	:= 11;
constant BIT_HEIGHT				: integer	:= 10;
constant BORDER_COLOR     : STD_LOGIC_VECTOR(23 downto 0) := x"6545B2";
--------------------------------------------------------------------------------
constant X_SCALE				  : integer	:= 4;
constant Y_SCALE				  : integer	:= 4;
constant DIS_X_RES				: INTEGER	:= 1280;
constant DIS_Y_RES				: INTEGER	:= 720;
constant GBA_X_RES				: INTEGER	:= 240;
constant GBA_Y_RES				: INTEGER	:= 160;
constant X_OFFSET				  : integer	:= (DIS_X_RES - GBA_X_RES*X_SCALE)/2;
constant Y_OFFSET				  : integer	:= (DIS_Y_RES - GBA_Y_RES*Y_SCALE)/2;
-- Knk
-- constant Y_CORR					  : INTEGER	:= 24;
-- constant Y_START          : INTEGER	:= 5;
-- constant X_CORR           : INTEGER	:= 10;
-- Postman
constant Y_CORR					  : INTEGER	:= 10;
constant Y_START          : INTEGER	:= 5;
constant X_CORR           : INTEGER	:= 6;
--------------------------------------------------------------------------------
signal pclk						    : STD_LOGIC;
signal pclk2x					    : STD_LOGIC;
signal pclk10x					  : STD_LOGIC;
signal serdesstrobe				: STD_LOGIC;
signal serdesrst				  : STD_LOGIC;
signal lock						    : STD_LOGIC;
signal resetn					    : STD_LOGIC;

signal sclk						    : STD_LOGIC;	-- System clock 125 MHz
signal nclk						    : STD_LOGIC;	-- N64 clock 50 MHz
signal hclk						    : STD_LOGIC;	-- HDMI clocck 74.25 MHz
signal dclk						    : STD_LOGIC;	-- Slow clock 25 MHz
	
signal led_cnt					  : UNSIGNED(31 downto 0);
signal video_data				  : STD_LOGIC_VECTOR(23 downto 0);
  
signal x_abs_pos				  : STD_LOGIC_VECTOR(BIT_WIDTH-1 downto 0);
signal y_abs_pos				  : STD_LOGIC_VECTOR(BIT_HEIGHT-1 downto 0);
signal x_rel_pos				  : UNSIGNED(BIT_WIDTH-1 downto 0);
signal y_rel_pos				  : UNSIGNED(BIT_HEIGHT-1 downto 0);
      
signal lb_wr_en					  : STD_LOGIC_VECTOR( 0 downto 0);
signal lb_wr_addr				  : STD_LOGIC_VECTOR( 8 downto 0);
signal lb_wr_data				  : STD_LOGIC_VECTOR(31 downto 0);
signal lb_rd_addr				  : STD_LOGIC_VECTOR( 8 downto 0);
signal lb_rd_data				  : STD_LOGIC_VECTOR(31 downto 0);

signal hdmi_line_start		: STD_LOGIC						:= '0';
signal hdmi_line_cnt			: UNSIGNED( 7 downto 0)	:= (others => '0');
signal hdmi_line_num			: STD_LOGIC_VECTOR( 7 downto 0)	:= (others => '0');
--------------------------------------------------------------------------------
-- SDRAM
signal sdram_addr				  : STD_LOGIC_VECTOR(22 downto 0);
signal sdram_rw					  : STD_LOGIC;
signal sdram_data_in		  : STD_LOGIC_VECTOR(31 downto 0);
signal sdram_data_out		  : STD_LOGIC_VECTOR(31 downto 0);
signal sdram_busy				  : STD_LOGIC;
signal sdram_in_valid		  : STD_LOGIC;
signal sdram_out_valid	  : STD_LOGIC;
-- -----------------------------------------------------------------------------
signal raw_video_tvalid		: STD_LOGIC;
signal raw_video_tready		: STD_LOGIC;
signal raw_video_tdata		: STD_LOGIC_VECTOR(31 downto 0)	:= (others => '0');
signal raw_video_tuser		: STD_LOGIC_VECTOR( 0 downto 0)	:= (others => '0');
signal raw_video_tlast		: STD_LOGIC;
 
signal packer_in_tvalid		: STD_LOGIC;
signal packer_in_tready		: STD_LOGIC;
signal packer_in_tdata		: STD_LOGIC_VECTOR(31 downto 0)	:= (others => '0');
signal packer_in_tuser		: STD_LOGIC_VECTOR( 0 downto 0)	:= (others => '0');
signal packer_in_tlast		: STD_LOGIC;
 
signal packer_out_tvalid	: STD_LOGIC						:= '0';
signal packer_out_tready	: STD_LOGIC						:= '0';
signal packer_out_tdata		: STD_LOGIC_VECTOR(31 downto 0)	:= (others => '0');
signal packer_out_tdest		: STD_LOGIC_VECTOR(22 downto 0)	:= (others => '0');
 
signal loader_in_tdata		: STD_LOGIC_VECTOR(31 downto 0)	:= (others => '0');
signal loader_in_tdest		: STD_LOGIC_VECTOR(22 downto 0)	:= (others => '0');
signal loader_in_tvalid		: STD_LOGIC						:= '0';
signal loader_in_tready		: STD_LOGIC						:= '0';

signal rd_addr_cnt				: UNSIGNED( 8 downto 0)		:= (others => '0');
  
signal frame_width				: STD_LOGIC_VECTOR(BIT_WIDTH -1 downto 0);
signal frame_height				: STD_LOGIC_VECTOR(BIT_HEIGHT-1 downto 0);
signal screen_width				: STD_LOGIC_VECTOR(BIT_WIDTH -1 downto 0);
signal screen_height			: STD_LOGIC_VECTOR(BIT_HEIGHT-1 downto 0);
signal screen_start_x			: STD_LOGIC_VECTOR(BIT_WIDTH -1 downto 0);
signal screen_start_y			: STD_LOGIC_VECTOR(BIT_HEIGHT-1 downto 0);
  
signal h_scale_cnt				: integer range 0 to X_SCALE-1	:= 0;
signal v_scale_cnt				: integer range 0 to Y_SCALE-1	:= 0;
signal line_scale_cnt			: integer range 0 to Y_SCALE-1	:= 0;
signal h_line_cnt				  : UNSIGNED(7 downto 0)			:= (others => '0');
signal buf_num					  : STD_LOGIC;
signal keys_data				  : STD_LOGIC_VECTOR(15 downto 0);

signal raw_audio_tvalid		: STD_LOGIC;
signal raw_audio_tdata		: STD_LOGIC_VECTOR(31 downto 0);
signal audio_tvalid				: STD_LOGIC;
signal audio_tdata				: STD_LOGIC_VECTOR(31 downto 0);
signal tmds						    : STD_LOGIC_VECTOR(29 downto 0);
--------------------------------------------------------------------------------
begin
--------------------------------------------------------------------------------
clk_sys_inst: clk_sys
port map(
	clk_in						=> pclk_in,	-- Input 74.25MHz
	pclk						  => pclk,	-- pixel clock 74.25 MHz
	pclk2x						=> pclk2x,	-- pclk*2 
	pclk10x						=> pclk10x,	-- pclk*10
	sclk						  => sclk,	-- system clock 106 MHz
	dclk						  => dclk,	-- slow clock 25 MHz
	serdesstrobe			=> serdesstrobe,
	serdesrst					=> serdesrst,
	pll_lock					=> lock,
	buf_lock					=> open
);

resetn	            <= lock;

hdmi_inst: dvi_video_720p
generic map(
	BIT_WIDTH 				=> BIT_WIDTH,
	BIT_HEIGHT				=> BIT_HEIGHT
)
port map( 	
	aresetn						=> resetn,
	-- Clocks
	pclk						  => pclk,
	pclkx2						=> pclk2x,
	pclkx10						=> pclk10x,
	serdesstrobe			=> serdesstrobe,
	-- Video Interface	
	video_data				=> video_data,
	-- Controls	
	position_x				=> x_abs_pos,
	position_y				=> y_abs_pos,
	frame_width				=> frame_width,
	frame_height			=> frame_height,	
	screen_width			=> screen_width,
	screen_height			=> screen_height,
	screen_start_x		=> screen_start_x,
	screen_start_y		=> screen_start_y,
	-- HDMI Interface
	hdmi_data_p 			=> hdmi1_d_p,
	hdmi_data_n 			=> hdmi1_d_n,
	hdmi_clk_p 				=> hdmi1_c_p,
	hdmi_clk_n 				=> hdmi1_c_n
);
--------------------------------------------------------------------------------
-- HDMI Video
--------------------------------------------------------------------------------
x_rel_pos	<= UNSIGNED(x_abs_pos) - UNSIGNED(screen_start_x);
y_rel_pos	<= UNSIGNED(y_abs_pos) - UNSIGNED(screen_start_y) 
              - TO_UNSIGNED(Y_OFFSET,BIT_HEIGHT);
--------------------------------------------------------------------------------
-- GBA Interface
gba_if_inst: gba_axis
generic map(
	X_RES						  => GBA_X_RES,
	Y_RES						  => GBA_Y_RES
)
port map(
	aclk						  => sclk,
	gba_clk						=> gba_clk,
	gba_hs						=> gba_hs,
	gba_vs						=> gba_vs,	
	gba_r						  => gba_r,	
	gba_g						  => gba_g,	
	gba_b						  => gba_b,	
	m_axis_tvalid			=> raw_video_tvalid,
	m_axis_tuser			=> raw_video_tuser,
	m_axis_tdata			=> raw_video_tdata,
	m_axis_tlast			=> raw_video_tlast
);

gba_to_ram_fifo: packer_fifo
port map(
	s_aclk						=> sclk,
	s_aresetn					=> '1',
	s_axis_tvalid			=> raw_video_tvalid,
	s_axis_tready			=> raw_video_tready,
	s_axis_tdata			=> raw_video_tdata,
	s_axis_tuser			=> raw_video_tuser,
	s_axis_tlast			=> raw_video_tlast,
	m_aclk						=> sclk,
	m_axis_tvalid			=> packer_in_tvalid,
	m_axis_tready			=> packer_in_tready,
	m_axis_tdata			=> packer_in_tdata,
	m_axis_tlast			=> packer_in_tlast,
	m_axis_tuser			=> packer_in_tuser
);

packer_inst: packer
generic map(
	X_RES						  => GBA_X_RES,
	Y_RES						  => GBA_Y_RES
)
port map(	
	aclk						  => sclk,
	
	s_axis_tvalid			=> packer_in_tvalid,
	s_axis_tready			=> packer_in_tready,
	s_axis_tdata			=> packer_in_tdata,
	s_axis_tuser			=> packer_in_tuser,
	s_axis_tlast			=> packer_in_tlast,

	m_axis_tvalid			=> packer_out_tvalid,
	m_axis_tready			=> packer_out_tready,
	m_axis_tdata			=> packer_out_tdata,
	m_axis_tdest			=> packer_out_tdest,
	
	buf_num						=> buf_num
);

sdram_inst: sdram
port map(
	clk							  => sclk,
	rst							  => '0',
	-- these signals go directly to the IO pins
	sdram_clk					=> sdram_clk,
	sdram_cle					=> sdram_cle,	
	sdram_cs					=> sdram_cs,
	sdram_cas					=> sdram_cas,	
	sdram_ras					=> sdram_ras,	
	sdram_we					=> sdram_we,
	sdram_dqm					=> sdram_dqm,	
	sdram_ba					=> sdram_ba,
	sdram_a						=> sdram_a,	
	sdram_dq					=> sdram_dq,	
	-- User interface
	addr						  => sdram_addr,
	rw							  => sdram_rw,
	data_in						=> sdram_data_in,
	data_out					=> sdram_data_out,
	busy						  => sdram_busy,
	in_valid					=> sdram_in_valid,
	out_valid					=> sdram_out_valid
);

sdram_ctrl_inst: sdram_ctrl
port map(
	aclk						  => sclk,
	-- Write Interface
	s0_axis_tvalid		=> packer_out_tvalid,
	s0_axis_tready		=> packer_out_tready,
	s0_axis_tdata			=> packer_out_tdata,
	s0_axis_tdest			=> packer_out_tdest,
	-- Read Interface
	s1_axis_tvalid		=> loader_in_tvalid,
	s1_axis_tready		=> loader_in_tready,
	s1_axis_tdata			=> loader_in_tdata,
	s1_axis_tdest			=> loader_in_tdest,
	-- SDRAM interface
	sdram_addr				=> sdram_addr,
	sdram_rw					=> sdram_rw,
	sdram_data_in			=> sdram_data_in,
	sdram_data_out		=> sdram_data_out,
	sdram_busy				=> sdram_busy,
	sdram_in_valid		=> sdram_in_valid,
	sdram_out_valid		=> sdram_out_valid
);

loader_inst: loader
generic map(
	X_RES						  => (GBA_X_RES + 10),
	Y_RES						  => (GBA_Y_RES + 10)
)
port map(	
	aclk						  => sclk,
	
	pclk						  => pclk,
	line_start				=> hdmi_line_start,
	line_num					=> hdmi_line_num,
	buf_num						=> buf_num,
	
	b_axis_tvalid			=> loader_in_tvalid,
	b_axis_tready			=> loader_in_tready,
	b_axis_tdata			=> loader_in_tdata,
	b_axis_tdest			=> loader_in_tdest,
	
	bram_addr					=> lb_wr_addr,
	bram_data					=> lb_wr_data,
	bram_we						=> lb_wr_en
);

line_buf: line_buffer
port map(
    clka						=> sclk,
    wea							=> lb_wr_en,
    addra						=> lb_wr_addr,
    dina						=> lb_wr_data,
    clkb						=> pclk,
    addrb						=> lb_rd_addr,
    doutb						=> lb_rd_data
);

--------------------------------------------------------------------------------
process(lb_rd_data, x_abs_pos, screen_start_x, y_abs_pos)
begin
	if(
		(UNSIGNED(x_abs_pos) >= UNSIGNED(screen_start_x) + 
      TO_UNSIGNED(X_OFFSET,BIT_WIDTH)) and 
		(UNSIGNED(x_abs_pos) < UNSIGNED(screen_start_x) + 
      TO_UNSIGNED((X_OFFSET + GBA_X_RES*X_SCALE),BIT_WIDTH)) and 
		(UNSIGNED(y_abs_pos) >= UNSIGNED(screen_start_y) + 
      TO_UNSIGNED((Y_OFFSET),BIT_HEIGHT)) and 
		(UNSIGNED(y_abs_pos) < UNSIGNED(screen_start_y) + 
      TO_UNSIGNED((Y_OFFSET + GBA_Y_RES*Y_SCALE),BIT_HEIGHT))
	)then			-- Draw area
		video_data					<= lb_rd_data(23 downto 0);
	else
		video_data				  <= BORDER_COLOR;	-- Border color
	end if;
end process;

process(pclk)
begin
	if rising_edge(pclk) then	
		if(UNSIGNED(x_abs_pos) = TO_UNSIGNED(600,BIT_WIDTH))then
			if(UNSIGNED(y_abs_pos) >= UNSIGNED(screen_start_y) + 
        TO_UNSIGNED((Y_OFFSET - Y_CORR),BIT_HEIGHT))then
				if(v_scale_cnt = Y_SCALE-1)then
					hdmi_line_num	  <= STD_LOGIC_VECTOR(hdmi_line_cnt);
					hdmi_line_cnt	  <= hdmi_line_cnt + 1;
					hdmi_line_start	<= '1';
					v_scale_cnt		  <= 0;
				else
					hdmi_line_start	<= '0';
					v_scale_cnt		  <= v_scale_cnt + 1;
				end if;
			else
				hdmi_line_cnt		  <= (others => '0');
				v_scale_cnt			  <= 0;
				hdmi_line_start		<= '0';
			end if;
		else
			hdmi_line_start			<= '0';
		end if;
	end if;
end process;

process(pclk)
begin
	if rising_edge(pclk) then	
		if(UNSIGNED(x_abs_pos) = UNSIGNED(screen_start_x) + 
        TO_UNSIGNED((X_OFFSET - X_CORR),BIT_WIDTH))then
			if(UNSIGNED(y_abs_pos) <= (UNSIGNED(screen_start_y) + 
        TO_UNSIGNED((Y_OFFSET - Y_START),BIT_HEIGHT)
        ))then
				h_line_cnt			  <= (others => '0');
				line_scale_cnt		<= 0;
			else
				if(line_scale_cnt = Y_SCALE-1)then
					line_scale_cnt  <= 0;
					h_line_cnt		  <= h_line_cnt + 1;
				else
					line_scale_cnt	<= line_scale_cnt + 1;
				end if;
			end if;
			if(h_line_cnt(0) = '0')then
				rd_addr_cnt			  <= TO_UNSIGNED(0,9);
			else
				rd_addr_cnt			  <= TO_UNSIGNED(256,9);
			end if;
			h_scale_cnt				  <= 0;
		elsif(h_scale_cnt = X_SCALE-1)then
			h_scale_cnt				  <= 0;
			rd_addr_cnt				  <= rd_addr_cnt + 1;
		else	
			h_scale_cnt				  <= h_scale_cnt + 1;
		end if;
	end if;
end process;
lb_rd_addr							  <= STD_LOGIC_VECTOR(rd_addr_cnt);

--------------------------------------------------------------------------------
-- Controller
ctrl_inst: nes_controller
generic map(
	C_CLK_DIV						=> 106
)
port map(
	clk								  => sclk,
	-- R,L,X,A,Right,Left,Down,Up,Start,Select,Y,B - SNES
	-- -,-,-,-,Right,Left,Down,Up,Start,Select,B,A - NES
	data_out						=> keys_data,
	nes_clock						=> CLK_NES,
	nes_latch						=> LATCH_NES,
	nes_data						=> DATA_NES
);			
-- SNES mapping			
R_BUTTON							<= not keys_data(11);
L_BUTTON							<= not keys_data(10);
A_BUTTON							<= not keys_data(8);
RIGHT_BUTTON					<= not keys_data(7);
LEFT_BUTTON						<= not keys_data(6);
DOWN_BUTTON						<= not keys_data(5);
UP_BUTTON							<= not keys_data(4);
START_BUTTON					<= not keys_data(3);
SELECT_BUTTON					<= not keys_data(2);
B_BUTTON							<= not keys_data(0);
--------------------------------------------------------------------------------
end arch_imp;
