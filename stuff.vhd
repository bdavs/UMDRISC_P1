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
           t2 : in  STD_LOGIC_VECTOR (15 downto 0);
           --inst : in  STD_LOGIC_VECTOR (15 downto 0);
           A : out  STD_LOGIC_VECTOR (15 downto 0);
           B : out  STD_LOGIC_VECTOR (15 downto 0);
           RA_Data : in  STD_LOGIC_VECTOR (15 downto 0);
           RB_Data : in  STD_LOGIC_VECTOR (15 downto 0);
           op : in  STD_LOGIC_VECTOR (3 downto 0);
			  ccr : in STD_LOGIC_VECTOR (3 downto 0));
end stuff;

architecture Behavioral of stuff is

begin

--process(clk)
--begin
--if (clk'event and clk = '1')then
--	if (inst(15 downto 12) = "1111" or inst(15 downto 12) = "1101" or inst(15 downto 12) = "1110" )then
--		br_stall <= '1';
--	else
--		br_stall <= '0';
--	end if;
--end if;
--end process;

-- move signal ...super gross, right?
move <= (t5(15 downto 12) and execute_alu_out(15)&"111") & execute_alu_out(11 downto 0);


	
	
	with op select
		A <=
			RA_data when "0000" | "0001" |"0010" |"0011" |"0100" |"0101" |"0110" |"0111" |"1000" |"1001" |"1010" |"1011" | "1100",
			t2(11 downto 8) & ccr & x"00" when "1101" | "1110" |"1111",
			RA_data when others;
	with t2(15 downto 12) select
		B <=
			RB_data when "0000" | "0001" |"0010" |"0011" |"0100" |"0101" |"0110" |"0111" |"1000" |"1001" |"1010" |"1011" | "1100",
			t2(11 downto 0)  & x"0" when "1101" | "1110" |"1111",
			RB_data when others;

end Behavioral;

