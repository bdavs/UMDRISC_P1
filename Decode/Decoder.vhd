----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:09:13 03/29/2016 
-- Design Name: 
-- Module Name:    Decoder - Behavioral 
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

entity Decoder is
    Port ( inst : in  STD_LOGIC_VECTOR (15 downto 0);
			  clk : in  STD_LOGIC;
           op : out  STD_LOGIC_VECTOR (3 downto 0);
           RA : out  STD_LOGIC_VECTOR (3 downto 0);
           RB : out  STD_LOGIC_VECTOR (3 downto 0);
           Imm : out  STD_LOGIC_VECTOR (3 downto 0)
			  );
end Decoder;

architecture Behavioral of Decoder is

begin
process (clk)
	begin
		if (clk'event and clk='0') then
			op <= inst(15 downto 12);
			RA <= inst(11 downto 8);
			Imm <= inst(3 downto 0);
			RB <= inst(7 downto 4);
		
		end if;
	end process;


end Behavioral;

