---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: Daniel Noyes
-- 
-- Create Date:    SPRING 2015
-- Module Name:    ALU_Logic_Unit
-- Project Name:   ALU
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description: Load/Store Unit
--  Operations - Load/Store to a register
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Load_Store_Unit is
    Port ( CLK    : in  STD_LOGIC;
           A      : in  STD_LOGIC_VECTOR (15 downto 0);
           IMMED  : in  STD_LOGIC_VECTOR (15 downto 0);
           OP     : in  STD_LOGIC_VECTOR (3 downto 0);
           RESULT : out STD_LOGIC_VECTOR  (15 downto 0);
			  result2:out STD_LOGIC_VECTOR  (15 downto 0));

end Load_Store_Unit;

architecture Behavioral of Load_Store_Unit is

    signal reg : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
    signal w_en : std_logic := '0';-- '1' = write, '0' = read
	 signal reg2 : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');

begin

	 result2 <=  IMMED; 
    RESULT <=  A;

end Behavioral;

