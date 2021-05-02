--------------------------------------------------------------------------------
-- FILENAME :       serdes5to1.vhd
-- DESCRIPTION :	  SERDES block for Spartan-6
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
entity serdes5to1 is
port ( 
	ioclk			    : in  STD_LOGIC;	-- IO Clock network
	serdesstrobe	: in  STD_LOGIC;	-- Parallel data capture strobe
	reset			    : in  STD_LOGIC;	-- Reset
	gclk			    : in  STD_LOGIC;	-- Global clock
	datain			  : in  STD_LOGIC_VECTOR(4 downto 0);	-- Data for output
	iob_data_out	: out STD_LOGIC	--output data
);
end serdes5to1;
--------------------------------------------------------------------------------
architecture arch_imp of serdes5to1 is
--------------------------------------------------------------------------------
signal cascade_di	: STD_LOGIC;
signal cascade_do	: STD_LOGIC;
signal cascade_ti	: STD_LOGIC;
signal cascade_to	: STD_LOGIC;
signal mdatain		: STD_LOGIC_VECTOR(8 downto 0);
--------------------------------------------------------------------------------
begin
--------------------------------------------------------------------------------
mdatain		<= "0000" & datain;

oserdes_m: OSERDES2 
generic map(
	DATA_WIDTH     	=> 5, 			  -- SERDES word width
	DATA_RATE_OQ    => "SDR", 		-- <SDR>, DDR
	DATA_RATE_OT    => "SDR", 		-- <SDR>, DDR
	SERDES_MODE    	=> "MASTER", 	-- <DEFAULT>, MASTER, SLAVE
	OUTPUT_MODE 	  => "DIFFERENTIAL"
)
port map (
	OQ       		    => iob_data_out,
	OCE     		    => '1',
	CLK0    		    => ioclk,
	CLK1    		    => '0',
	IOCE    		    => serdesstrobe,
	RST     		    => reset,
	CLKDIV  		    => gclk,
	D4  			      => mdatain(7),
	D3  			      => mdatain(6),
	D2  			      => mdatain(5),
	D1  			      => mdatain(4),
	TQ  			      => open,
	T1 				      => '0',
	T2 				      => '0',
	T3 				      => '0',
	T4 				      => '0',
	TRAIN    		    => '0',
	TCE	   			    => '1',
	SHIFTIN1 		    => '1',			    -- Dummy input in Master
	SHIFTIN2 		    => '1',			    -- Dummy input in Master
	SHIFTIN3 		    => cascade_do,	-- Cascade output D data from slave
	SHIFTIN4 		    => cascade_to,	-- Cascade output T data from slave
	SHIFTOUT1 		  => cascade_di,	-- Cascade input D data to slave
	SHIFTOUT2 		  => cascade_ti,	-- Cascade input T data to slave
	SHIFTOUT3 		  => open,		    -- Dummy output in Master
	SHIFTOUT4 		  => open			    -- Dummy output in Master
);

oserdes_s: OSERDES2 
generic map(
	DATA_WIDTH   	  => 5, 			  -- SERDES word width
	DATA_RATE_OQ 	  => "SDR", 		-- <SDR>, DDR
	DATA_RATE_OT 	  => "SDR", 		-- <SDR>, DDR
	SERDES_MODE  	  => "SLAVE", 	-- <DEFAULT>, MASTER, SLAVE
	OUTPUT_MODE 	  => "DIFFERENTIAL"
)
port map (
	OQ       		    => open,
	OCE     		    => '1',
	CLK0    		    => ioclk,
	CLK1    		    => '0',
	IOCE    		    => serdesstrobe,
	RST     		    => reset,
	CLKDIV  		    => gclk,
	D4  			      => mdatain(3),
	D3  			      => mdatain(2),
	D2  			      => mdatain(1),
	D1  			      => mdatain(0),
	TQ  			      => open,
	T1 				      => '0',
	T2 				      => '0',
	T3  			      => '0',
	T4  			      => '0',
	TRAIN 			    => '0',
	TCE	 			      => '1',
	SHIFTIN1 		    => cascade_di,		-- Cascade input D from Master
	SHIFTIN2 		    => cascade_ti,		-- Cascade input T from Master
	SHIFTIN3 		    => '1',				-- Dummy input in Slave
	SHIFTIN4 		    => '1',				-- Dummy input in Slave
	SHIFTOUT1 		  => open,			-- Dummy output in Slave
	SHIFTOUT2 		  => open,			-- Dummy output in Slave
	SHIFTOUT3 		  => cascade_do,   	-- Cascade output D data to Master
	SHIFTOUT4 		  => cascade_to	 	-- Cascade output T data to Master
);
--------------------------------------------------------------------------------
end arch_imp;
