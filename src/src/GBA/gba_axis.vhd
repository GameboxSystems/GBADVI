--------------------------------------------------------------------------------
-- FILENAME :       GBA_axis.vhd
-- DESCRIPTION :	  Receive video data from GBA display interface
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
entity gba_axis is
generic (
	X_RES						  : integer	:= 240;
	Y_RES						  : integer	:= 160
);		
port (		
	aclk						  : in  STD_LOGIC;
	------------------------------------------------------------------------------
	gba_clk						: in  STD_LOGIC;
	gba_hs						: in  STD_LOGIC;
	gba_vs						: in  STD_LOGIC;
	gba_r						  : in  STD_LOGIC_VECTOR(4 downto 0)	:= (others => '0');
	gba_g						  : in  STD_LOGIC_VECTOR(4 downto 0)	:= (others => '0');
	gba_b						  : in  STD_LOGIC_VECTOR(4 downto 0)	:= (others => '0');
	------------------------------------------------------------------------------
	m_axis_tvalid			: out STD_LOGIC;
	m_axis_tuser			: out STD_LOGIC_VECTOR( 0 downto 0)	:= (others => '0');
	m_axis_tdata			: out STD_LOGIC_VECTOR(31 downto 0)	:= (others => '0');
	m_axis_tlast			: out STD_LOGIC
);
end gba_axis;
--------------------------------------------------------------------------------
architecture arch_imp of gba_axis is
--------------------------------------------------------------------------------
constant X_OFFSET		: integer	:= 1;
constant Y_OFFSET		: integer	:= 5;
signal clk_sr			  : STD_LOGIC_VECTOR( 2 downto 0);
signal hs_sr			  : STD_LOGIC_VECTOR( 2 downto 0);
signal vs_sr			  : STD_LOGIC_VECTOR( 2 downto 0);
signal vdata			  : STD_LOGIC_VECTOR(31 downto 0);
signal x_cnt			  : UNSIGNED( 7 downto 0);
signal y_cnt			  : UNSIGNED( 7 downto 0);
signal valid_drv		: STD_LOGIC;
signal user_drv			: STD_LOGIC;
signal last_drv			: STD_LOGIC;
signal nl				    : STD_LOGIC	:= '0';
--------------------------------------------------------------------------------
begin
--------------------------------------------------------------------------------
process(aclk)
begin
	if rising_edge(aclk) then
		clk_sr	<= clk_sr(1 downto 0) & gba_clk;
		hs_sr		<= hs_sr(1 downto 0) & gba_hs;
		vs_sr		<= vs_sr(1 downto 0) & gba_vs;
		vdata		<= x"00" & gba_r & "000" & gba_g & "000" & gba_b & "000";
	end if;
end process;

process(aclk)
begin
	if rising_edge(aclk) then
		if(vs_sr(2 downto 1) = "01")then
			user_drv				<= '1';
			last_drv				<= '0';
			m_axis_tdata			<= x"00" & "0" & 
        vdata(23 downto 17) & x"FF" & "0" & vdata(7 downto 1);
			valid_drv				<= '1';
			x_cnt					  <= (others => '0');
			y_cnt					  <= (others => '0');
		elsif(hs_sr(2 downto 1) = "10")then
			user_drv				<= '0';
			last_drv				<= '1';
			m_axis_tdata			<= x"00" & "0" & vdata(23 downto 17) 
        & x"FF" & "0" & vdata(7 downto 1);
			valid_drv				<= '1';
			x_cnt					  <= (others => '0');
			y_cnt					  <= y_cnt + 1;
			nl						  <= not nl;
		elsif(clk_sr(2 downto 1) = "01")then
			user_drv				<= '0';
			last_drv				<= '0';
			valid_drv				<= '1';
			m_axis_tdata		<= vdata;
		else
			valid_drv				<= '0';
		end if;
	end if;
end process;

m_axis_tvalid		      <= valid_drv;
m_axis_tuser(0)		    <= user_drv;
m_axis_tlast		      <= last_drv;
--------------------------------------------------------------------------------
end arch_imp;
