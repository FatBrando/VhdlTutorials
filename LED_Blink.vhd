library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LED_Blink is
	generic (
		g_COUNT_10HZ : integer;
		g_COUNT_5HZ  : integer;
		g_COUNT_2HZ  : integer;
		g_COUNT_1HZ  : integer
	);
	port (
		i_Clk   : in  std_logic;
		o_LED_1 : out std_logic; 
		o_LED_2 : out std_logic; 
		o_LED_3 : out std_logic; 
		o_LED_4 : out std_logic
	);
end LED_Blink;

architecture RTL of LED_Blink is


	-- These signals will be the counters
	signal r_Count_10Hz : integer range 0 to g_COUNT_10HZ;
	signal r_Count_5Hz : integer range 0 to g_COUNT_5HZ;
	signal r_Count_2Hz : integer range 0 to g_COUNT_2HZ;
	signal r_Count_1Hz : integer range 0 to g_COUNT_1HZ;
	
	-- These signals will toggle at the frequencies needed
	signal r_Toggle_10Hz : std_logic := '0';
	signal r_Toggle_5Hz  : std_logic := '0';
	signal r_Toggle_2Hz  : std_logic := '0';
	signal r_Toggle_1Hz  : std_logic := '0';
	
begin		

	o_LED_1 <= r_Toggle_10Hz;
	o_LED_2 <= r_Toggle_5Hz;
	o_LED_3 <= r_Toggle_2Hz;
	o_LED_4 <= r_Toggle_1Hz;
	
	p_10_Hz : process(i_Clk) is
	begin
		if rising_edge(i_Clk) then
			if r_Count_10Hz = g_COUNT_10HZ then 
				r_Toggle_10Hz <= not r_Toggle_10Hz;
				r_Count_10Hz <= 0;
			else
				r_Count_10Hz <= r_Count_10Hz + 1;
			end if;
		end if;
	end process p_10_Hz;
	
	p_5_Hz : process(i_Clk) is
	begin
		if rising_edge(i_Clk) then
			if r_Count_5Hz = g_COUNT_5Hz then 
				r_Toggle_5Hz <= not r_Toggle_5Hz;
				r_Count_5Hz <= 0;
			else
				r_Count_5Hz <= r_Count_5Hz + 1;
			end if;
		end if;
	end process p_5_Hz;
	
	p_2_Hz : process(i_Clk) is
	begin
		if rising_edge(i_Clk) then
			if r_Count_2Hz = g_COUNT_2Hz then 
				r_Toggle_2Hz <= not r_Toggle_2Hz;
				r_Count_2Hz <= 0;
			else
				r_Count_2Hz <= r_Count_2Hz + 1;
			end if;
		end if;
	end process p_2_Hz;
	
		
	p_1_Hz : process(i_Clk) is
	begin
		if rising_edge(i_Clk) then
			if r_Count_1Hz = g_COUNT_1Hz then 
				r_Toggle_1Hz <= not r_Toggle_1Hz;
				r_Count_1Hz <= 0;
			else
				r_Count_1Hz <= r_Count_1Hz + 1;
			end if;
		end if;
	end process p_1_Hz;
	
end  RTL;