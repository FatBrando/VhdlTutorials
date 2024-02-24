library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity UART_TB_TEST is
end UART_TB_TEST;

architecture behave of UART_TB_TEST is

	-- Test Bench  uses a 25 MHz Clock
	constant c_CLK_PERIOD : time := 40 ns;
	
	--want to interface to 115200 baud UART_RX
	-- 25000000 / 115200 = 217 Clocks Per Bit
	constant c_CLKS_PER_BIT : integer := 217;
	
	-- 1 /115200
	constant c_BIT_PERIOD : time := 8680 ns;	
	
	signal r_Clock : std_logic := '0';
	signal w_RX_Byte : std_logic_vector(7 downto 0);
	signal r_RX_Serial : std_logic := '1';
    
    signal r_TX_DV : std_logic := '0';
	signal r_TX_Byte : std_logic_vector(7 downto 0) := (others => '0');
	signal w_TX_Serial : std_logic;
	signal w_TX_Done : std_logic;
	signal w_TX_Active : std_logic;
	
	-- Low-level byte-write
	procedure UART_WRITE_BYTE (
		i_Data_In        : std_logic_vector(7 downto 0);
		signal o_Serial : out std_logic) is
	begin
	
		-- Send Start Bit
		o_Serial <= '0';
		wait for c_BIT_PERIOD;
		
		-- Send Data Byte
		for ii in 0 to 7 loop
			o_Serial <= i_Data_In(ii);
			wait for c_BIT_PERIOD;
		end loop; -- ii
	
		-- Send Stop Bit
		o_Serial <= '1';
		wait for c_BIT_PERIOD;
	
	end UART_WRITE_BYTE;
begin
	
	--Instantiate UART Receiver
	UART_RX_Inst : entity work.UART_RX
		generic map (
			g_CLKS_PER_BIT => c_CLKS_PER_BIT
			)
		port map (
			i_Clk => r_Clock,
			i_RX_Serial => r_RX_Serial,
			o_RX_DV => open,
			o_RX_Byte => w_RX_Byte
			);
			
		r_Clock <= not r_Clock after c_CLK_PERIOD/2;
	
    --Instantiate UART transmitter
	UART_TX_Inst : entity work.UART_TX_TEST
		generic map (
			g_CLKS_PER_BIT => c_CLKS_PER_BIT
			)
		port map (
			i_Clk       => r_Clock,
			i_TX_DV     => r_TX_DV,
			i_TX_Byte   => r_TX_Byte,			
			o_TX_Active => w_TX_Active,
			o_TX_Serial => w_TX_Serial,
			o_TX_Done   => w_TX_Done
			);
	
    
	process
	begin
		-- Send a command to the UART
		wait until rising_edge(r_Clock);
		UART_WRITE_BYTE(X"37", r_RX_Serial);
		wait until rising_edge(r_Clock);
		
		-- Check that the correct command was received
		if w_RX_Byte = X"37" then
			report "Test Passed - Correct Byte Received" severity note;
		else
			report "Test - Incorrect Byte Received" severity note;
		end if;
		
		assert false report "Tests Complete" severity failure;
	end process;
end behave;