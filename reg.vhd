----------------------------------------------------------------------------------
-- Company: University of Massachusetts Dartmouth
-- Department: Electrical and Computer Engineering
-- Engineer: Stephen Shannon extended by Daniel Garcia
-- 
-- Description: Generic Register on Rising Edge with Enable
---------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity reg is
	generic (n: natural := 16);
	port (clk 		: in STD_LOGIC;
			input 	: in STD_LOGIC_VECTOR (n-1 downto 0);
			en 		: in STD_LOGIC;
			output 	: out STD_LOGIC_VECTOR (n-1 downto 0)
			);
end reg;

architecture Behavioral of reg is
	begin
	process (clk)
		begin
			if (en = '1') then
				if (clk'event and clk='1') then
					output <= input;
				end if;
			end if;
	end process;
end Behavioral;

