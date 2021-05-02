--------------------------------------------------------------------------------
-- FILENAME :       sdram_ctrl.vhd
-- DESCRIPTION :	  Simple multiple access controller
-- @author: Oleksandr Kiyenko
-- If you find this code useful you know what to do
-- bc1q8pflngx8qhaxtjvyhevdft4r6jvztrcm70fxz9
--------------------------------------------------------------------------------
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
--------------------------------------------------------------------------------
entity sdram_ctrl is
port (	
	aclk						    : in  STD_LOGIC;
	-- Write Interface
	s0_axis_tvalid			: in  STD_LOGIC;
	s0_axis_tready			: out STD_LOGIC;
	s0_axis_tdata				: in  STD_LOGIC_VECTOR(31 downto 0);
	s0_axis_tdest				: in  STD_LOGIC_VECTOR(22 downto 0);
	-- Read Interface
	s1_axis_tvalid			: in  STD_LOGIC;
	s1_axis_tready			: out STD_LOGIC;
	s1_axis_tdata				: out STD_LOGIC_VECTOR(31 downto 0);
	s1_axis_tdest				: in  STD_LOGIC_VECTOR(22 downto 0);
	-- SDRAM interface
	sdram_addr					: out STD_LOGIC_VECTOR(22 downto 0);
	sdram_rw					  : out STD_LOGIC;						-- 1 = write, 0 = read
	sdram_data_in				: out STD_LOGIC_VECTOR(31 downto 0);
	sdram_data_out			: in  STD_LOGIC_VECTOR(31 downto 0);
	sdram_busy					: in  STD_LOGIC;  -- controller is busy when high
	sdram_in_valid			: out STD_LOGIC;  -- pulse high to initiate a read/write
	sdram_out_valid			: in  STD_LOGIC
);
end sdram_ctrl;
--------------------------------------------------------------------------------
architecture arch_imp of sdram_ctrl is
--------------------------------------------------------------------------------
signal ach			: STD_LOGIC	:= '0';
constant N			: integer	:= 7;
--------------------------------------------------------------------------------
begin
--------------------------------------------------------------------------------
process(s0_axis_tvalid, s1_axis_tvalid)
begin
	if(s1_axis_tvalid = '1')then
		ach			<= '1';
	elsif(s0_axis_tvalid = '1')then
		ach			<= '0';
	end if;
end process;

sdram_addr		<= 
	s0_axis_tdest(21 downto N) & "0" & s0_axis_tdest(N-1 downto 0) 
	when (ach = '0') else 
	s1_axis_tdest(21 downto N) & "0" & s1_axis_tdest(N-1 downto 0);
sdram_rw		<= '1'  when (ach = '0') else '0';
sdram_data_in	<= s0_axis_tdata;
s1_axis_tdata	<= sdram_data_out;
s1_axis_tready	<= sdram_out_valid;
sdram_in_valid	<= (s0_axis_tvalid or s1_axis_tvalid) and (not sdram_busy);
s0_axis_tready	<= '1' when (ach = '0') and (sdram_busy = '0') else '0';
--------------------------------------------------------------------------------
end arch_imp;
