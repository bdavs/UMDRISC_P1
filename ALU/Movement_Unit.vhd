----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:15:16 04/08/2016 
-- Design Name: 
-- Module Name:    Movement_Unit - Behavioral 
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
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Movement_Unit is
    Port ( CLK      : in  STD_LOGIC;
			  OP : in  STD_LOGIC_VECTOR (3 downto 0);
           Ra : in  STD_LOGIC_VECTOR (15 downto 0);
           Rb : in  STD_LOGIC_VECTOR (15 downto 0);
			  ccr_move : out std_logic_vector(3 downto 0);
           result : out  STD_LOGIC_VECTOR (15 downto 0));
end Movement_Unit;

architecture Behavioral of Movement_Unit is

signal tmp : std_logic_vector(15 downto 0) := (others => '0');
signal tmp2 : std_logic_vector(3 downto 0) := (others => '0');
signal tmp3 : std_logic_vector(3 downto 0) := (others => '0');

begin
tmp2<= Ra(15 downto 12);
tmp3<= Ra(3 downto 0);


process(clk)
begin
	if (tmp2 = tmp3)then
		tmp <= Rb;
		ccr_move <= x"1";
	else
		ccr_move <= x"0";
	end if;
end process;
	
	with OP select
        RESULT <=
            Rb + x"1000"  when "1101", -- jump
            x"0000" when "1110", -- return
            Rb + x"1000"  when "1111", -- branch
            x"0000" when OTHERS;-- ANDI REG A, IMMED

	
end Behavioral;

