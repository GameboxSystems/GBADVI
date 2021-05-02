--------------------------------------------------------------------------------
-- FILENAME :       loader.vhd
-- DESCRIPTION :	  Load video data from SDRAM to Line buffer
-- @author: Oleksandr Kiyenko
-- If you find this code useful you know what to do
-- bc1q8pflngx8qhaxtjvyhevdft4r6jvztrcm70fxz9
--------------------------------------------------------------------------------
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
--------------------------------------------------------------------------------
entity loader is
generic(
	X_RES						: integer	:= 640;
	Y_RES						: integer	:= 240
);
port (	
	aclk						: in  STD_LOGIC;
	
	pclk						: in  STD_LOGIC;
	line_start			: in  STD_LOGIC;
	line_num				: in  STD_LOGIC_VECTOR( 7 downto 0);
	buf_num					: in  STD_LOGIC;
	
	b_axis_tvalid		: out STD_LOGIC;
	b_axis_tready		: in  STD_LOGIC;
	b_axis_tdata		: in  STD_LOGIC_VECTOR(31 downto 0);
	b_axis_tdest		: out STD_LOGIC_VECTOR(22 downto 0);
	
	bram_addr				: out STD_LOGIC_VECTOR( 8 downto 0);
	bram_data				: out STD_LOGIC_VECTOR(31 downto 0);
	bram_we					: out STD_LOGIC_VECTOR( 0 downto 0)
);
end loader;
--------------------------------------------------------------------------------
architecture arch_imp of loader is
--------------------------------------------------------------------------------
type sm_state_t is (ST_IDLE, ST_TRANS);
signal sm_state					: sm_state_t			:= ST_IDLE;

signal line_start_i			: STD_LOGIC;
signal start_pulse_sr		: STD_LOGIC_VECTOR(7 downto 0);
signal start_sr					: STD_LOGIC_VECTOR(2 downto 0);
signal line_num_i				: STD_LOGIC_VECTOR(7 downto 0);
signal transfer_start		: STD_LOGIC;
signal pixel_cnt				: UNSIGNED(7 downto 0);
signal curr_buf					: STD_LOGIC;
--------------------------------------------------------------------------------
begin
--------------------------------------------------------------------------------
process(pclk)
begin
	if rising_edge(pclk) then
		if(line_start = '1')then
			start_pulse_sr				<= (others => '1');
		else			
			start_pulse_sr				<= '0' & start_pulse_sr(7 downto 1);
		end if;
	end if;
end process;

process(aclk)
begin
	if rising_edge(aclk) then
		start_sr						  <= start_sr(1 downto 0) & start_pulse_sr(0);
		line_start_i					<= not start_sr(2) and start_sr(1);
	end if;
end process;

process(aclk)
begin
	if rising_edge(aclk) then
		if(line_start_i = '1')then
			line_num_i					<= line_num;
			if(line_num = x"00")then
				curr_buf				  <= buf_num;
			end if;
			transfer_start			<= '1';
		else			
			transfer_start			<= '0';
		end if;
	end if;
end process;

process(aclk)
begin
	if rising_edge(aclk) then
		case sm_state is
			when ST_IDLE	=> 
				pixel_cnt				<= (others => '0');
				if(transfer_start = '1')then
					sm_state			<= ST_TRANS;
				end if;
			when ST_TRANS	=>
				if(b_axis_tready = '1')then
					if(pixel_cnt = TO_UNSIGNED((X_RES+1),8))then
						pixel_cnt		<= (others => '0');
						sm_state		<= ST_IDLE;
					else
						pixel_cnt		<= pixel_cnt + 1;
					end if;
				end if;
		end case;
	end if;
end process;

bram_data		<= b_axis_tdata;
bram_we(0)		<= b_axis_tready when (sm_state = ST_TRANS) else '0';
bram_addr		<= line_num_i(0) & STD_LOGIC_VECTOR(pixel_cnt);
b_axis_tdest	<= "000000" & curr_buf & line_num_i & STD_LOGIC_VECTOR(pixel_cnt);
b_axis_tvalid	<= '1' when (sm_state = ST_TRANS) else '0';
--------------------------------------------------------------------------------
end arch_imp;
