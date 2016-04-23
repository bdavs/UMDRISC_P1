----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:48:59 04/17/2016 
-- Design Name: 
-- Module Name:    TheDebugUnit - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TheDebugUnit is
Port (	CLK : in  STD_LOGIC; -- 50 MHz input
			SW  : in  STD_LOGIC_VECTOR (7 downto 0);
			BTN : in  STD_LOGIC_VECTOR (3 downto 0);
			SEG : out STD_LOGIC_VECTOR (6 downto 0);
			DP  : out STD_LOGIC;
			AN  : out STD_LOGIC_VECTOR (3 downto 0);
			LED : out STD_LOGIC_VECTOR (7 downto 0);
			PS2_CLK  : inout STD_LOGIC;
         PS2_DATA : inout STD_LOGIC
	 );
end TheDebugUnit;

architecture Behavioral of TheDebugUnit is
signal Debug_data: std_logic_vector(15 downto 0);
signal RISC_data: std_logic_vector(15 downto 0);
signal DataDMP:  std_logic;
signal CoreDMP:  std_logic;
signal instrDMP: std_logic;
signal Data: std_logic_vector (15 downto 0);
signal Addr: std_logic_vector (11 downto 0);
signal dpc : std_logic_vector(3 downto 0);
signal enl: std_logic := '1';
signal buttons: STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal ascii : std_logic_vector(7 downto 0);
signal ascii_ready: std_logic;
signal ascii_writeEnable: std_logic;
signal run: std_logic:= '0';
signal address_en: std_logic;
signal sw_latch: std_logic_vector(7 downto 0);
signal enter_data: std_logic:= '0';
signal selector: std_logic_vector(1 downto 0);
signal write_data: std_logic:= '0';
signal write_data_flag: std_logic:= '0';
begin

Keyboard: entity work.Keyboard_controller
Port map ( CLK      => clk,
           RST      => '0',
           PS2_CLK  => PS2_CLK,
           PS2_DATA => PS2_DATA,
           ASCII_OUT => ascii, -- Include Basic Ascii (no extension codes)
           ASCII_RD => ascii_ready, -- Indicate Ascii value is available to read
           ASCII_WE => ascii_writeEnable); -- Can the Character write(none special character)
			  
			  
SSeg: entity work.SSegDriver
	port map(  CLK     => CLK,
              RST     => '0',
              EN      => enl,
              SEG_0   => Debug_data(15 downto 12),
              SEG_1   => Debug_data(11 downto 8),
              SEG_2   => Debug_data(7 downto 4),
              SEG_3   => Debug_data(3 downto 0),
              DP_CTRL => dpc,
              COL_EN  => '1',
              SEG_OUT => SEG,
              DP_OUT  => DP,
              AN_OUT  => AN
				  );
				  
	button_control: entity work.buttoncontrol
	port map ( CLK     => CLK,
           BTN 	 	 => BTN,
			  SW			 => '1',
           LED		 	 => buttons
			  );
			  
	address_latch: entity work.reg
	generic map (n => 8)
	port map(
			clk => CLK,
			input => SW,
			en => address_en,
			output => sw_latch);
			
	Data <= "00" & SW;
	Addr <= "00" & sw_latch;
	UMDRISC: entity work.TopLevel
	port map(	clk => CLK,
		rst => '0',
		int => buttons,
		wdata => write_data,
		run => run,
		dataDMP => dataDMP,
		coreDMP => coreDMP,
		instrDMP => instrDMP,
		data => Data,
		address => Addr,
		Debug_data => RISC_data
);	
			
process(ascii_ready)
begin
	if(ascii_ready = '1') then
		if(ascii = x"74") then
			--key r (run the processor)
			run <= '1';
			--reset the signals
			enter_data <= '0';
			address_en <= '1';
		end if;
		
		if(run <= '1') then --run operations
			if(ascii = x"73")then
				--key s (stop the processor)
				run <= '0';
			end if;
		end if;
		
		if(run <= '0') then --stopped
			if(ascii = x"0d") then
				--key enter 
				if(enter_data = '0') then
					enter_data <= '1';
					--save value on register
					address_en <= '0';
					
				end if;
				
				if(enter_data = '1') then
					enter_data <= '0';
					--write data and release latch
					address_en <= '1';
					write_data <= '1';
					write_data_flag <= '1';
				end if;                 
			end if;
			
			if(ascii = x"63") then
				--key c 
				DataDMP <= '0'  ;
				CoreDMP <= '1' ;
				instrDMP <= '0';
			end if;
			if(ascii = x"64") then
				--key d 
				DataDMP <= '1'  ;
				CoreDMP <= '0' ;
				instrDMP <= '0';
			end if;
			if(ascii = x"69") then
				--key i 
				DataDMP <= '0'  ;
				CoreDMP <= '0' ;
				instrDMP <= '1';
			end if;
		end if;
		
	end if;
end process;

process(CLK)
begin 
	if(CLK'event and CLK = '1' and write_data_flag = '1') then
		write_data <= '0';
		write_data_flag <= '0';
	end if;
end process;

selector <= run & enter_data;
with selector select 
	Debug_data <= 
		x"00" & SW when "01",
		RISC_data when "00",
		x"badd" when "10" | "11",
		x"0000" when others;

--with OP select
--        ALU_OUT <=
--            ARITH     when "0000",     -- ADD
--            ARITH     when "0001",     -- SUB
end Behavioral;

