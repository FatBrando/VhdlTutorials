library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LED_Blink_Top is
	port(
		-- Main Clock (25 MHz)
		i_Clk    : in std_logic;		
		o_LED_1   : out std_logic;
		o_LED_2   : out std_logic;
		o_LED_3   : out std_logic;
		o_LED_4   : out std_logic
		);
end LED_Blink_Top;

architecture RTL of LED_Blink_Top is

begin
	
	--Instantiate Debounce Filter
	LED_Blink_Inst : entity work.LED_Blink
		generic map (
		g_COUNT_10HZ => 125000,
		g_COUNT_5HZ  => 250000,
		g_COUNT_2HZ  => 625000,
		g_COUNT_1HZ  => 1250000)
		port map (
			i_Clk => i_Clk,
			o_LED_1 => open,
			o_LED_2 => o_LED_2,
			o_LED_3 => o_LED_3,
			o_LED_4 => o_LED_4
			);
	
end  RTL;