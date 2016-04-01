----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:06:39 03/30/2016 
-- Design Name: 
-- Module Name:    fetch_toplevel - Behavioral 
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

entity fetch_toplevel is
port( clk: in std_logic;
		addr: in std_logic_vector(4 downto 0);
		en_fetch: in std_logic := '1';
		writeEnable: in std_logic;
		pipelineoutput: out std_logic_vector(15 downto 0);
		output: out std_logic_vector(15 downto 0));
end fetch_toplevel;

architecture Behavioral of fetch_toplevel is
signal count: std_logic_vector(4 downto 0);
signal inst: std_logic_vector(15 downto 0);
begin

ProgramCounter: entity work.ProgramCounter
port map(
			clk => clk,
			addr => addr,
			writeEnable => writeEnable,
			count => count
);
  
ROM: entity work.ROM
port map(
			ADDRA => count,
			CLKA => clk,
			DOUTA => inst
);
pipelineoutput <= inst;
fetch_latch: entity work.reg
port map(
			clk => clk,
			input => inst,
			en => en_fetch,
			output => output
			);

end Behavioral;