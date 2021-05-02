--------------------------------------------------------------------------------
-- FILENAME :       bram30to15.vhd
-- DESCRIPTION :	  Data 2:1 serilisation
-- @author: Oleksandr Kiyenko
-- If you find this code useful you know what to do
-- bc1q8pflngx8qhaxtjvyhevdft4r6jvztrcm70fxz9
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
library UNISIM; 
use UNISIM.VCOMPONENTS.ALL; 
--------------------------------------------------------------------------------
entity bram30to15 is
port (
	rst			        : in  STD_LOGIC;   -- reset
	clk			        : in  STD_LOGIC;   -- clock input
	clkx2		        : in  STD_LOGIC;  -- 2x clock input
	datain		      : in  STD_LOGIC_VECTOR(29 downto 0);
	dataout		      : out STD_LOGIC_VECTOR(14 downto 0)
);		
end bram30to15;
--------------------------------------------------------------------------------
architecture Behavioral of bram30to15 is
--------------------------------------------------------------------------------
signal wa_d			  : UNSIGNED( 3 downto 0);  -- RAM read address
signal ra_d			  : UNSIGNED( 3 downto 0);  -- RAM read address
signal dataint		: STD_LOGIC_VECTOR(29 downto 0);  -- RAM output

signal rstsync		: STD_LOGIC;
signal rstsync_q	: STD_LOGIC;
signal rstp			  : STD_LOGIC;
signal sync			  : STD_LOGIC;
signal db			    : STD_LOGIC_VECTOR(29 downto 0);
signal mux			  : STD_LOGIC_VECTOR(14 downto 0);
--------------------------------------------------------------------------------
attribute ASYNC_REG				      : string;
attribute ASYNC_REG of rstsync	: signal is "true";
--------------------------------------------------------------------------------
begin
--------------------------------------------------------------------------------
process(clk, rst)
begin
	if(rst = '1')then
		wa_d	<= (others => '0');
	elsif rising_edge(clk) then
		wa_d	<= wa_d + 1;
	end if;
end process;

bram_gen:for i in 0 to 29 generate
	bram_inst: RAM16X1D
	port map(  
		D			=> datain(i),		  -- insert input signal
		WE			=> '1',				  -- insert Write Enable signal
		WCLK		=> clk,				  -- insert Write Clock signal
		A0			=> wa_d(0),			-- insert Address 0 signal port SPO
		A1			=> wa_d(1),			-- insert Address 1 signal port SPO
		A2			=> wa_d(2),			-- insert Address 2 signal port SPO
		A3			=> wa_d(3),			-- insert Address 3 signal port SPO
		DPRA0		=> ra_d(0),			-- insert Address 0 signal dual port DPO
		DPRA1		=> ra_d(1),			-- insert Address 1 signal dual port DPO
		DPRA2		=> ra_d(2),			-- insert Address 2 signal dual port DPO
		DPRA3		=> ra_d(3),			-- insert Address 3 signal dual port DPO
		SPO			=> open,  			-- insert output signal SPO
		DPO			=> dataint(i)		-- insert output signal DPO
	);
end generate;

process(clkx2)
begin
	if(rst = '1')then
		rstsync		<= '1';
	elsif rising_edge(clkx2) then
		rstsync		<= rst;
		rstsync_q	<= rstsync;
		rstp		<= rstsync_q;
	end if;
end process;

mux 	<= db(14 downto 0) when (sync = '0') else db(29 downto 15);

process(clkx2, rstp)
begin
	if(rstp = '1')then
		sync		<= '0';
		ra_d		<= (others => '0');
	elsif(clkx2 = '1' and clkx2'event)then
		sync		<= not sync;
		if(sync = '1')then
			ra_d	<= ra_d + 1;
			db		<= dataint;
		end if;
		dataout		<= mux;
	end if;
end process;
--------------------------------------------------------------------------------
end Behavioral;
