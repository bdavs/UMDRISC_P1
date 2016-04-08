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
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PCstack is
	generic(	width:	integer:=16;
			depth:	integer:=4);
    Port ( input : in  STD_LOGIC_VECTOR (15 downto 0);
           output : out  STD_LOGIC_VECTOR (15 downto 0);
           push : in  STD_LOGIC;
           pop : in  STD_LOGIC;
			  clk : in std_logic);
end PCstack;

architecture Behavioral of PCstack is
signal stack_pointer : std_logic_vector(4 downto 0) := (others => '0');
signal write_en : std_logic_vector(0 downto 0);

type ram_type is array (0 to depth-1) of
	std_logic_vector(width-1 downto 0);
signal tmp_ram: ram_type :=  (others => (others => '0'));

begin

	process(clk)
	begin
	if(clk'event and clk = '1')then
		if(push = '1')then
			stack_pointer <= stack_pointer + '1';
		elsif(pop = '1')then
			stack_pointer <= stack_pointer - '1';
		else
			stack_pointer <= stack_pointer;
		end if; 
	end if;
	
	if(clk'event and clk = '0')then
		if(push = '1')then
			tmp_ram(conv_integer(stack_pointer)) <= input;
		elsif(pop = '1')then
			output <= tmp_ram(conv_integer(stack_pointer));
		else
			output <= (others => 'Z');
		end if;
	end if;
	end process;

end Behavioral;

