----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/12/2021 03:30:49 AM
-- Design Name: 
-- Module Name: pulse_gen - rtl
-- Project Name: pulse generation block
-- Target Devices: 
-- Tool Versions: 1.0
-- Description: Pulse generation block for auto-calibration. 
--					 The block generates a series of pulse,where frequency is close to sysmtem clock.
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
library UNISIM;
use UNISIM.vcomponents.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pulse_gen is
 port ( 
 	i_clk 	 : in std_logic;
 	i_reset   : in std_logic;
 	i_en 		 : in std_logic;
 	o_pulse 	 : out std_logic;
 	o_stop : out std_logic
 );
end pulse_gen;

architecture rtl of pulse_gen is

 signal enable : std_logic;
 signal pulse_tmp : std_logic;
 signal control_tmp : std_logic;
 signal control_tmp1 : std_logic_vector (3 downto 0);
 signal control_tmp2 : std_logic_vector (3 downto 0);
 signal control_tmp3 : std_logic_vector (3 downto 0);
 signal control_tmp4 : std_logic_vector (3 downto 0);
 signal control_tmp5 : std_logic_vector (3 downto 0);
 signal control_tmp6 : std_logic_vector (3 downto 0);
 signal control_tmp7 : std_logic_vector (3 downto 0);
 signal control_tmp8 : std_logic_vector (3 downto 0);
 signal control_tmp9 : std_logic_vector (3 downto 0);
 signal control_tmp10 : std_logic_vector (3 downto 0);
 signal pulse_tmp1 : std_logic_vector (3 downto 0);
 signal pulse_tmp2 : std_logic_vector (3 downto 0);
 signal pulse_tmp3 : std_logic_vector (3 downto 0);
 signal pulse_tmp4 : std_logic_vector (3 downto 0);
 signal pulse_tmp5 : std_logic_vector (3 downto 0);
 signal pulse_tmp6 : std_logic_vector (3 downto 0);
 signal pulse_tmp7 : std_logic_vector (3 downto 0);
 signal pulse_tmp8 : std_logic_vector (3 downto 0);
 signal pulse_tmp9 : std_logic_vector (3 downto 0);
 signal pulse_tmp10 : std_logic_vector (3 downto 0);
 signal pulse_tmp11 : std_logic_vector (3 downto 0);
 signal pulse_tmp12 : std_logic_vector (3 downto 0);
 
 signal count : unsigned (3 downto 0);
 constant MAXCOUNT : integer := 2;
begin
	
counter : process (i_clk, i_reset)
begin
	if (i_reset = '1') then
		count <= (others => '0');
	elsif (rising_edge(i_clk)) then
		if (i_en = '1') then
			if (count = (MAXCOUNT - 1)) then
				count <= (others => '0');
			else
				count <= count + 1;
			end if;
		else
			count <= (others => '0');
		end if;
	end if;
end process counter;
	

proc_en : process (i_clk, i_reset)
begin
	if (i_reset = '1') then
		enable <= '0';
	elsif (rising_edge(i_clk)) then
		if (count = (MAXCOUNT - 1)) then
			enable <= '1';
		else
			enable <= '0';
		end if;
	end if;
end process proc_en;


proc_tmp : process (i_clk, i_reset)
begin
	if (i_reset = '1') then
		pulse_tmp <= '0';
	elsif (rising_edge(i_clk)) then
		if (count = (MAXCOUNT - 1)) then
			pulse_tmp <= not pulse_tmp;
		else
			pulse_tmp <= pulse_tmp;
		end if;
	end if;
end process proc_tmp;


--------------------------------------------------------------------
-- signal assign
--------------------------------------------------------------------
-- Insert the delay module so that the pulse is aligned with the 172MHz system clock.
CARRY4_inst0 : CARRY4
port map (
	CO => control_tmp1,
	CI => '0',
	CYINIT => control_tmp,
	DI => "0000",
	S => "1111"
);

CARRY4_inst1 : CARRY4
port map (
	CO => control_tmp2,
	CI => control_tmp1(3),
	CYINIT => '0',
	DI => "0000",
	S => "1111"
);

CARRY4_inst2 : CARRY4
port map (
	CO => control_tmp3,
	CI => control_tmp2(3),
	CYINIT => '0',
	DI => "0000",
	S => "1111"
);

CARRY4_inst3 : CARRY4
port map (
	CO => control_tmp4,
	CI => control_tmp3(3),
	CYINIT => '0',
	DI => "0000",
	S => "1111"
);

CARRY4_inst4 : CARRY4
port map (
	CO => control_tmp5,
	CI => control_tmp4(3),
	CYINIT => '0',
	DI => "0000",
	S => "1111"
);

CARRY4_inst5 : CARRY4
port map (
	CO => control_tmp6,
	CI => control_tmp5(3),
	CYINIT => '0',
	DI => "0000",
	S => "1111"
);

CARRY4_inst6 : CARRY4
port map (
	CO => control_tmp7,
	CI => control_tmp6(3),
	CYINIT => '0',
	DI => "0000",
	S => "1111"
);

CARRY4_inst7 : CARRY4
port map (
	CO => control_tmp8,
	CI => control_tmp7(3),
	CYINIT => '0',
	DI => "0000",
	S => "1111"
);

CARRY4_inst8 : CARRY4
port map (
	CO => control_tmp9,
	CI => control_tmp8(3),
	CYINIT => '0',
	DI => "0000",
	S => "1111"
);

CARRY4_inst9 : CARRY4
port map (
	CO => control_tmp10,
	CI => control_tmp9(3),
	CYINIT => '0',
	DI => "0000",
	S => "1111"
);

--------------------------------------------------------------------
-- signal assign
--------------------------------------------------------------------
-- Insert the delay module so that the pulse is aligned with the 172MHz system clock.
CARRY4_inst10 : CARRY4
port map (
	CO => pulse_tmp1,
	CI => '0',
	CYINIT => pulse_tmp,
	DI => "0000",
	S => "1111"
);

CARRY4_inst11 : CARRY4
port map (
	CO => pulse_tmp2,
	CI => pulse_tmp1(3),
	CYINIT => '0',
	DI => "0000",
	S => "1111"
);

CARRY4_inst12 : CARRY4
port map (
	CO => pulse_tmp3,
	CI => pulse_tmp2(3),
	CYINIT => '0',
	DI => "0000",
	S => "1111"
);

CARRY4_inst13 : CARRY4
port map (
	CO => pulse_tmp4,
	CI => pulse_tmp3(3),
	CYINIT => '0',
	DI => "0000",
	S => "1111"
);

CARRY4_inst14 : CARRY4
port map (
	CO => pulse_tmp5,
	CI => pulse_tmp4(3),
	CYINIT => '0',
	DI => "0000",
	S => "1111"
);

CARRY4_inst15 : CARRY4
port map (
	CO => pulse_tmp6,
	CI => pulse_tmp5(3),
	CYINIT => '0',
	DI => "0000",
	S => "1111"
);

CARRY4_inst16 : CARRY4
port map (
	CO => pulse_tmp7,
	CI => pulse_tmp6(3),
	CYINIT => '0',
	DI => "0000",
	S => "1111"
);

CARRY4_inst17 : CARRY4
port map (
	CO => pulse_tmp8,
	CI => pulse_tmp7(3),
	CYINIT => '0',
	DI => "0000",
	S => "1111"
);

CARRY4_inst18 : CARRY4
port map (
	CO => pulse_tmp9,
	CI => pulse_tmp8(3),
	CYINIT => '0',
	DI => "0000",
	S => "1111"
);

CARRY4_inst19 : CARRY4
port map (
	CO => pulse_tmp10,
	CI => pulse_tmp9(3),
	CYINIT => '0',
	DI => "0000",
	S => "1111"
);

CARRY4_inst20 : CARRY4
port map (
	CO => pulse_tmp11,
	CI => pulse_tmp10(3),
	CYINIT => '0',
	DI => "0000",
	S => "1111"
);

CARRY4_inst21 : CARRY4
port map (
	CO => pulse_tmp12,
	CI => pulse_tmp11(3),
	CYINIT => '0',
	DI => "0000",
	S => "1111"
);

BUFG_STOP_inst : BUFG
port map (
 	O => o_stop,
	I => control_tmp
);

--BUFG_PULSE_inst : BUFG
--port map (
-- 	O => o_pulse,
--	I => control_tmp4(3)
--);

control_tmp <= enable and pulse_tmp;
o_pulse <= pulse_tmp;
--o_stop <= control_tmp1(3);

end rtl;
