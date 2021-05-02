--------------------------------------------------------------------------------
-- FILENAME :       nes_controller.vhd
-- DESCRIPTION :	  NES controller interface
-- @author: Oleksandr Kiyenko
-- If you find this code useful you know what to do
-- bc1q8pflngx8qhaxtjvyhevdft4r6jvztrcm70fxz9
--------------------------------------------------------------------------------
library ieee;
use ieee.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
--------------------------------------------------------------------------------
entity nes_controller is
generic (
	C_CLK_DIV			: integer	:= 74
);
port (
	clk					  : in  STD_LOGIC;
	data_out			: out STD_LOGIC_VECTOR(15 downto 0);
	nes_clock			: out STD_LOGIC;
	nes_latch			: out STD_LOGIC;
	nes_data			: in  STD_LOGIC	:= '0'
);
end nes_controller;
--------------------------------------------------------------------------------
architecture arch_imp of nes_controller is
--------------------------------------------------------------------------------
signal shifter			: STD_LOGIC_VECTOR(15 downto 0)	:= (others => '0');
signal clk_cnt			: integer range 0 to C_CLK_DIV/2-1	:= 0;
signal half				  : STD_LOGIC	:= '0';
signal bits_cnt			: integer range 0 to 14 := 0;
type sm_state_type is (ST_START, ST_WAIT, ST_LOW, ST_HIGH);
signal sm_state			: sm_state_type	:= ST_START;
--------------------------------------------------------------------------------
begin
--------------------------------------------------------------------------------
process(clk)
begin
	if rising_edge(clk) then
		if(clk_cnt = (C_CLK_DIV/2-1))then
			clk_cnt		<= 0;
			half		<= '1';
		else
			clk_cnt		<= clk_cnt + 1;
			half		<= '0';
		end if;
	end if;
end process;

process(clk)
begin
	if rising_edge(clk) then
		if(half = '1')then
			case sm_state is
				when ST_START		=>
					nes_latch		<= '1';
					nes_clock		<= '0';
					shifter			<= nes_data & shifter(15 downto 1);
					bits_cnt		<= 0;
					sm_state		<= ST_WAIT;
				when ST_WAIT		=>
					nes_latch		<= '0';
					nes_clock		<= '0';
					--bits_cnt		<= 0;
					sm_state		<= ST_LOW;
				when ST_LOW			=>
					if(bits_cnt = 0)then
						data_out	<= not shifter;
					end if;
					shifter			<= nes_data & shifter(15 downto 1);
					nes_clock		<= '1';
					sm_state		<= ST_HIGH;
				when ST_HIGH		=>
					nes_clock		<= '0';
					if(bits_cnt = 14)then
						sm_state	<= ST_START;
						--bits_cnt		<= 0;
					else
						bits_cnt	<= bits_cnt + 1;
						sm_state	<= ST_LOW;
					end if;
			end case;
		end if;
	end if;
end process;
--------------------------------------------------------------------------------
end arch_imp;
