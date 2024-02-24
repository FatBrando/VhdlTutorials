library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LED_Blink_TB is
end LED_Blink_TB;

architecture behave of LED_Blink_TB is

	constant c_CLK_PERIOD : time := 1 ns;
	signal r_Clock : std_logic := '0';
	
begin

	r_Clock <= not r_Clock after c_CLK_PERIOD/2;
	
	--Instantiate Debounce Filter
	LED_Blink_Inst : entity work.LED_Blink
		generic map (
		g_COUNT_10HZ => 5,
		g_COUNT_5HZ  => 10,
		g_COUNT_2HZ  => 25,
		g_COUNT_1HZ  => 50)
		port map (
			i_Clk => r_Clock,
			o_LED_1 => open,
			o_LED_2 => open,
			o_LED_3 => open,
			o_LED_4 => open
			);
			
	process is
	begin
	report "Starting Testbench...";
	wait for 0.2 us;
	assert false report "Test Complete" severity failure;
	end process;

end behave;