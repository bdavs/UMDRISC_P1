----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:50:23 04/01/2016 
-- Design Name: 
-- Module Name:    PCstack - Behavioral 
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

entity PCstack is
    Port ( input : in  STD_LOGIC_VECTOR (15 downto 0);
           output : out  STD_LOGIC_VECTOR (15 downto 0);
           push : in  STD_LOGIC;
           pop : in  STD_LOGIC);
end PCstack;

architecture Behavioral of PCstack is
signal stack_pointer : std_logic_vector(4 downto 0);
begin

stack_RAM: entity work.stack_RAM
port map(
			ADDRA => input,
			CLKA => clk,
			DOUTA => output
);


end Behavioral;

