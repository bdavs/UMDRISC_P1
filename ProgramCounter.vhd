----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:30:57 03/25/2016 
-- Design Name: 
-- Module Name:    ProgramCounter - Structural 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ProgramCounter is
	port( clk: in std_logic;
			addr: in std_logic_vector(4 downto 0);
			writeEnable: in std_logic;
			count: buffer std_logic_vector(4 downto 0) := (others => '0'));

end ProgramCounter;

architecture Structural of ProgramCounter is
 --signal tmpcnt :in std_logic_vector( 4 downto 0);
begin
process(clk)
begin
		if (writeEnable ='1') then
			count <= addr;
		else
			if (clk'event and clk = '1') then
				count <= count + 1;
			end if;
		end if;
end process;
end Structural;

