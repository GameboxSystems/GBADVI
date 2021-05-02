--------------------------------------------------------------------------------
-- FILENAME :       TMDS_encoder.vhd
-- DESCRIPTION :	  TMDS encoder
-- @author:         Oleksandr Kiyenko
-- If you find this code useful you know what to do
-- bc1q8pflngx8qhaxtjvyhevdft4r6jvztrcm70fxz9
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
--------------------------------------------------------------------------------
entity tmds_encoder is
generic(
	CHANNEL				    : integer	:= 0
);
port (
	pclk				      : in  STD_LOGIC;
	video_data		  	: in  STD_LOGIC_VECTOR(7 downto 0);
	control_data		  : in  STD_LOGIC_VECTOR(1 downto 0);
	active_video		  : in  STD_LOGIC;
	tmds				      : out STD_LOGIC_VECTOR(9 downto 0)	:= (others => '0')
);
end tmds_encoder;
--------------------------------------------------------------------------------
architecture Behavioral of tmds_encoder is
--------------------------------------------------------------------------------
signal n1d			  : UNSIGNED(3 downto 0); -- number of 1s in din
signal din_q		  : STD_LOGIC_VECTOR(7 downto 0);
signal decision_a	: STD_LOGIC;
signal decision_b	: STD_LOGIC;
signal decision_c	: STD_LOGIC;
signal q_m			  : STD_LOGIC_VECTOR(8 downto 0);
signal n1q_m		  : UNSIGNED(3 downto 0); -- number of 1s and 0s for q_m
signal n0q_m		  : UNSIGNED(3 downto 0);
signal cnt			  : UNSIGNED(4 downto 0)	:= (others => '0');

constant CTRLTOKEN0	: STD_LOGIC_VECTOR(9 downto 0) := b"1101010100";
constant CTRLTOKEN1 : STD_LOGIC_VECTOR(9 downto 0) := b"0010101011";
constant CTRLTOKEN2 : STD_LOGIC_VECTOR(9 downto 0) := b"0101010100";
constant CTRLTOKEN3 : STD_LOGIC_VECTOR(9 downto 0) := b"1010101011";

signal de_reg		  : STD_LOGIC;
signal c_reg		  : STD_LOGIC_VECTOR(1 downto 0);
signal q_m_reg		: STD_LOGIC_VECTOR(8 downto 0);



signal acc			: SIGNED(4 downto 0)	:= (others => '0');
signal q_m_s		: UNSIGNED(8 downto 0)	:= (others => '0');
signal q_out		: UNSIGNED(9 downto 0)	:= (others => '0');
signal N1q_m07	: SIGNED(4 downto 0)	:= (others => '0');
signal N0q_m07	: SIGNED(4 downto 0)	:= (others => '0');
signal acc_add	: SIGNED(4 downto 0)	:= (others => '0');
signal ifds			: integer range 0 to 5	:= 0;
signal q_reg		: STD_LOGIC_VECTOR(9 downto 0)	:= (others => '0');
--------------------------------------------------------------------------------
begin
--------------------------------------------------------------------------------
process(n1q_m)
begin
	case n1q_m is
		when TO_UNSIGNED(0,4) => N1q_m07 <= TO_SIGNED(0,5);
		when TO_UNSIGNED(1,4) => N1q_m07 <= TO_SIGNED(1,5);
		when TO_UNSIGNED(2,4) => N1q_m07 <= TO_SIGNED(2,5);
		when TO_UNSIGNED(3,4) => N1q_m07 <= TO_SIGNED(3,5);
		when TO_UNSIGNED(4,4) => N1q_m07 <= TO_SIGNED(4,5);
		when TO_UNSIGNED(5,4) => N1q_m07 <= TO_SIGNED(5,5);
		when TO_UNSIGNED(6,4) => N1q_m07 <= TO_SIGNED(6,5);
		when TO_UNSIGNED(7,4) => N1q_m07 <= TO_SIGNED(7,5);
		when TO_UNSIGNED(8,4) => N1q_m07 <= TO_SIGNED(8,5);
		when others			  => N1q_m07 <= TO_SIGNED(0,5);
	end case;
end process;

N0q_m07 <= TO_SIGNED(8,5) - N1q_m07;

-- process(pclk)
process(acc, video_data, q_m_s, N1q_m07, N0q_m07)
begin
	-- if rising_edge(pclk) then
		if ((n1d > TO_UNSIGNED(4,4)) or ((n1d = TO_UNSIGNED(4,4)) and 
        (video_data(0) = '0')))then
			q_m_s(0) <= video_data(0);
			for i in 0 to 6 loop
				q_m_s(i + 1) <= q_m_s(i) xnor video_data(i + 1);
			end loop;
			q_m_s(8) 		<= '0';
		else
			q_m_s(0) 		<= video_data(0);
			for i in 0 to 6 loop
				q_m_s(i + 1) <= q_m_s(i) xor video_data(i + 1);
			end loop;
			q_m_s(8) 		<= '1';
		end if;
		if((acc = TO_SIGNED(0,5)) or (N1q_m07 = N0q_m07))then
			if(q_m_s(8) = '1')then
				acc_add		<= N1q_m07 - N0q_m07;
				ifds		<= 0;
				q_out		<= (not q_m_s(8)) & q_m_s(8) & q_m_s(7 downto 0);
			else
				acc_add 	<= N0q_m07 - N1q_m07;
				ifds		<= 1;
				q_out 		<= (not q_m_s(8)) & q_m_s(8) & (not q_m_s(7 downto 0));
			end if;
		else
			if(((acc > TO_SIGNED(0,5)) and (N1q_m07 > N0q_m07)) or 
        ((acc < TO_SIGNED(0,5)) and (N1q_m07 < N0q_m07)))then
				q_out 		<= '1' & q_m_s(8) & (not q_m_s(7 downto 0));
				if(q_m_s(8) = '1')then
					acc_add 	<= (N0q_m07 - N1q_m07) + TO_SIGNED(2,5);
					ifds		<= 2;
				else
					acc_add 	<= (N0q_m07 - N1q_m07) + TO_SIGNED(0,5);
					ifds		<= 3;
				end if;
			else
				q_out 			<= '0' & q_m_s(8) & q_m_s(7 downto 0);
				if(q_m_s(8) = '1')then
					acc_add 	<= (N1q_m07 - N0q_m07) - TO_SIGNED(0,5);
					ifds		<= 4;
				else
					acc_add 	<= (N1q_m07 - N0q_m07) - TO_SIGNED(2,5);
					ifds		<= 5;
				end if;
			end if;
		end if;
	-- end if;
end process;

process(pclk)
begin
	if rising_edge(pclk) then
    if(active_video = '0')then
			acc		<= TO_SIGNED(0,5);
		else
			acc		<= acc + acc_add;
		end if;
	end if;
end process;

--------------------------------------------------------------------------------
n1d		<= 
	resize(UNSIGNED(video_data(0 downto 0)),4) + 
	resize(UNSIGNED(video_data(1 downto 1)),4) + 
	resize(UNSIGNED(video_data(2 downto 2)),4) + 
	resize(UNSIGNED(video_data(3 downto 3)),4) + 
	resize(UNSIGNED(video_data(4 downto 4)),4) + 
	resize(UNSIGNED(video_data(5 downto 5)),4) + 
	resize(UNSIGNED(video_data(6 downto 6)),4) + 
	resize(UNSIGNED(video_data(7 downto 7)),4);
din_q	<= video_data;

decision_a	<= '1' when ((n1d > to_unsigned(4,4)) or ((n1d = to_unsigned(4,4)) 
  and (din_q(0) = '0'))) else '0';

q_m(0) <= din_q(0);
q_m(1) <= (q_m(0) xnor din_q(1)) when (decision_a = '1') 
  else (q_m(0) xor din_q(1));
q_m(2) <= (q_m(1) xnor din_q(2)) when (decision_a = '1') 
  else (q_m(1) xor din_q(2));
q_m(3) <= (q_m(2) xnor din_q(3)) when (decision_a = '1') 
  else (q_m(2) xor din_q(3));
q_m(4) <= (q_m(3) xnor din_q(4)) when (decision_a = '1') 
  else (q_m(3) xor din_q(4));
q_m(5) <= (q_m(4) xnor din_q(5)) when (decision_a = '1') 
  else (q_m(4) xor din_q(5));
q_m(6) <= (q_m(5) xnor din_q(6)) when (decision_a = '1') 
  else (q_m(5) xor din_q(6));
q_m(7) <= (q_m(6) xnor din_q(7)) when (decision_a = '1') 
  else (q_m(6) xor din_q(7));
q_m(8) <= '0' when (decision_a = '1') else '1';
--------------------------------------------------------------------------------
-- Stage 2: 9 bit -> 10 bit
-- Refer to DVI 1.0 Specification, page 29, Figure 3-5
--------------------------------------------------------------------------------
n1q_m  <=
	resize(UNSIGNED(q_m(0 downto 0)),4) + 
	resize(UNSIGNED(q_m(1 downto 1)),4) + 
	resize(UNSIGNED(q_m(2 downto 2)),4) + 
	resize(UNSIGNED(q_m(3 downto 3)),4) + 
	resize(UNSIGNED(q_m(4 downto 4)),4) + 
	resize(UNSIGNED(q_m(5 downto 5)),4) + 
	resize(UNSIGNED(q_m(6 downto 6)),4) + 
	resize(UNSIGNED(q_m(7 downto 7)),4);
n0q_m  <=
	to_unsigned(8,4) - (
	resize(UNSIGNED(q_m(0 downto 0)),4) + 
	resize(UNSIGNED(q_m(1 downto 1)),4) + 
	resize(UNSIGNED(q_m(2 downto 2)),4) + 
	resize(UNSIGNED(q_m(3 downto 3)),4) + 
	resize(UNSIGNED(q_m(4 downto 4)),4) + 
	resize(UNSIGNED(q_m(5 downto 5)),4) + 
	resize(UNSIGNED(q_m(6 downto 6)),4) + 
	resize(UNSIGNED(q_m(7 downto 7)),4));

decision_b <= '1' when ((cnt = to_unsigned(0,5)) or (n1q_m = n0q_m)) else '0';
decision_c <= '1' when ((cnt(4) = '0') and (n1q_m > n0q_m)) or ((cnt(4) = '1') 
  and (n0q_m > n1q_m)) else '0';
--------------------------------------------------------------------------------
-- pipe line alignment
--------------------------------------------------------------------------------
process(pclk)
begin
	if(pclk = '1' and pclk'event)then
    de_reg    <= active_video;
		q_reg	    <= STD_LOGIC_VECTOR(q_out);
		q_m_reg	  <= q_m;
		c_reg	    <= control_data;
	end if;
end process;
--------------------------------------------------------------------------------
-- 10-bit out
-- disparity counter
--------------------------------------------------------------------------------
process(pclk)
begin
	if(pclk = '1' and pclk'event)then
		if(de_reg = '1')then
			-- tmds	<= q_reg;
			if(decision_b = '1')then
				tmds(9)					<= not q_m_reg(8); 
				tmds(8)					<= q_m_reg(8);
				if(q_m_reg(8) = '1')then
					tmds(7 downto 0)	<= q_m_reg(7 downto 0);
				else
					tmds(7 downto 0)	<= not q_m_reg(7 downto 0);
				end if;
				if(q_m_reg(8) = '0')then
					cnt		<= cnt + resize(n0q_m,5) - resize(n1q_m,5);
				else
					cnt		<= cnt + resize(n1q_m,5) - resize(n0q_m,5); 
				end if;
			else
				if(decision_c = '1')then
					tmds(9)				<= '1';
					tmds(8)				<= q_m_reg(8);
					tmds(7 downto 0)	<= not q_m_reg(7 downto 0);
					if(q_m_reg(8) = '1')then
						cnt					<= cnt + to_unsigned(2,5) + 
              (resize(n0q_m,5) - resize(n1q_m,5));
					else
						cnt					<= cnt + (resize(n0q_m,5) - resize(n1q_m,5));
					end if;
				else
					tmds(9)				<= '0';
					tmds(8)				<= q_m_reg(8);
					tmds(7 downto 0)	<= q_m_reg(7 downto 0);
					if(q_m_reg(8) = '0')then
						cnt					<= cnt - to_unsigned(2,5) + 
              (resize(n1q_m,5) - resize(n0q_m,5));
					else
						cnt					<= cnt + (resize(n1q_m,5) - resize(n0q_m,5));
					end if;
				end if;
			end if;
		else
			case(c_reg)is
				when "00"	=> tmds <= CTRLTOKEN0;
				when "01"	=> tmds <= CTRLTOKEN1;
				when "10"	=> tmds <= CTRLTOKEN2;
				when others	=> tmds <= CTRLTOKEN3;
			end case;
			cnt <= (others => '0');
		end if;
	end if;
end process;
--------------------------------------------------------------------------------
end Behavioral;
