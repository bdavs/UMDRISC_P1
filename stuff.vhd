----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:06:31 04/14/2016 
-- Design Name: 
-- Module Name:    stuff - Behavioral 
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

entity stuff is
    Port ( clk : in  STD_LOGIC;
           move : out  STD_LOGIC_VECTOR (15 downto 0);
           execute_alu_out : in  STD_LOGIC_VECTOR (15 downto 0);
           --br_stall : out  STD_LOGIC;
			  t5 : in  STD_LOGIC_VECTOR (15 downto 0);
           t4 : in  STD_LOGIC_VECTOR (15 downto 0);
           t3 : in  STD_LOGIC_VECTOR (15 downto 0);
           branch : out  STD_LOGIC;
           A : out  STD_LOGIC_VECTOR (15 downto 0);
           B : out  STD_LOGIC_VECTOR (15 downto 0);
           RA_Data : in  STD_LOGIC_VECTOR (15 downto 0);
           RB_Data : in  STD_LOGIC_VECTOR (15 downto 0);
           op : in  STD_LOGIC_VECTOR (3 downto 0);
			  ccr : in STD_LOGIC_VECTOR (3 downto 0));
end stuff;

architecture Behavioral of stuff is
signal tempA :std_logic_vector(15 downto 0);
signal tempB :std_logic_vector(15 downto 0);
begin



-- move signal ...super gross, right?
move <= t4(15 downto 12) & execute_alu_out(11 downto 0);


with execute_alu_out(15) select
branch <= '1' when  '1',
		    '0' when others;

	
	
	with op select
		A <=
			RA_data when "0000" | "0001" |"0010" |"0011" |"0100" |"0101" |"0110" |"0111" |"1000" |"1001" |"1010" |"1011" | "1100",
			--t3(11 downto 8) & ccr & x"00" when "1101" | "1110" |"1111",
			RA_data when others;
			
			--A <= 	execute_alu_out when t5(11 downto 8) = t3(7 downto 4) or t5(7 downto 4) = t3(7 downto 4) or t5(7 downto 4) = t3(11 downto 8) else
				--	tempA ;
			
	with t3(15 downto 12) select
		B <=
			RB_data when "0000" | "0001" |"0010" |"0011" |"0100" |"0101" |"0110" |"0111" |"1000" |"1001" |"1010" |"1011" | "1100",
			x"0" & t3(11 downto 0)   when "1101" | "1110" |"1111",
			RB_data when others;
			
			--B <= 	execute_alu_out when t5(11 downto 8) = t3(7 downto 4) or t5(7 downto 4) = t3(7 downto 4) or t5(7 downto 4) = t3(11 downto 8) else
				--	tempB ;

end Behavioral;

