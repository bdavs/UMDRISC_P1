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
signal DataDMP:  std_logic;
signal CoreDMP:  std_logic;
signal Data: std_logic_vector (15 downto 0);
signal Addr: std_logic_vector (11 downto 0);
signal dpc : std_logic_vector(3 downto 0);
signal enl: std_logic := '1';
signal buttons: STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal ascii : std_logic_vector(7 downto 0);
signal ascii_ready: std_logic;
signal ascii_writeEnable: std_logic;
signal run: std_logic:= '0';
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
			  
process(CLK, ascii_ready)
begin
	if(ascii_ready = '1') then
		if(ascii = x"74") then
			--key r (run the processor)
			run <= '1';
		end if;
		if(ascii = x"73" and run <= '1')then
			--key s (stop the processor)
			run <= '0';
		end if;
	end if;
end process;


with run select 
	Debug_data <= 
		x"11" & SW when '1',
		x"ab" & ascii when '0',
		x"0000" when others;

--with OP select
--        ALU_OUT <=
--            ARITH     when "0000",     -- ADD
--            ARITH     when "0001",     -- SUB
end Behavioral;

