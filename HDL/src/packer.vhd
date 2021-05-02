--------------------------------------------------------------------------------
-- FILENAME :       packer.vhd
-- DESCRIPTION :	  Pack video to SDRAM
-- @author: Oleksandr Kiyenko
-- If you find this code useful you know what to do
-- bc1q8pflngx8qhaxtjvyhevdft4r6jvztrcm70fxz9
--------------------------------------------------------------------------------
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
--------------------------------------------------------------------------------
entity packer is
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
end packer;
--------------------------------------------------------------------------------
architecture arch_imp of packer is
--------------------------------------------------------------------------------
type sm_state_t is (ST_INIT, ST_SYNC, ST_WR, ST_TRANS);
signal sm_state			: sm_state_t			      := ST_INIT;
signal pixel_cnt		: UNSIGNED(7 downto 0)	:= (others => '0');
signal line_cnt			: UNSIGNED(7 downto 0)	:= (others => '0');
signal curr_buf			: STD_LOGIC				      := '0';
--------------------------------------------------------------------------------
begin
--------------------------------------------------------------------------------
process(aclk)
begin
	if rising_edge(aclk) then
		if(s_axis_tvalid = '1')then
			if(s_axis_tuser(0) = '1')then
				pixel_cnt			<= (others => '0');
				line_cnt			<= (others => '0');
				curr_buf			<= not curr_buf;
			elsif(s_axis_tlast = '1')then
				pixel_cnt			<= (others => '0');
				line_cnt			<= line_cnt + 1;
			elsif(m_axis_tready = '1')then
				pixel_cnt			<= pixel_cnt + 1;
			end if;
		end if;
	end if;
end process;

buf_num					<= curr_buf;

m_axis_tdest		<= "000000" & curr_buf & 
  STD_LOGIC_VECTOR(line_cnt) & 
  STD_LOGIC_VECTOR(pixel_cnt);

s_axis_tready		<= s_axis_tvalid and 
  (s_axis_tuser(0) or s_axis_tlast or m_axis_tready);
m_axis_tvalid		<= s_axis_tvalid and not (s_axis_tuser(0) or s_axis_tlast);
m_axis_tdata		<= s_axis_tdata;
--------------------------------------------------------------------------------
end arch_imp;
