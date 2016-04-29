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
	generic(	width:	integer:=12;
			depth:	integer:=4);
    Port ( input : in  STD_LOGIC_VECTOR (width-1  downto 0);
           output : out  STD_LOGIC_VECTOR (width-1  downto 0);
           push : in  STD_LOGIC;
           pop : in  STD_LOGIC;
			  clk : in std_logic);
end PCstack;

architecture Behavioral of PCstack is
signal stack_pointer : std_logic_vector(1 downto 0) := (others => '0');
--signal temp1 : std_logic_vector(1 downto 0):= (others => '1');
--signal temp2 : std_logic_vector(1 downto 0):= (others => '1');
--signal temp : std_logic_vector(1 downto 0):= (others => '1');
--signal SEL : std_logic_vector(1 downto 0) := (others => '0');


type ram_type is array (0 to depth-1) of
	std_logic_vector(width-1 downto 0);
signal tmp_ram: ram_type :=  (others => (others => '0'));

begin

--whatamidoing <= push & pop;
--
--PCstackMux: entity work.mux_4to1
--generic map( width => 2)
--port map(
--	SEL  => SEL,
--	IN_1 => temp1,
--	IN_2 => temp2,
--	IN_3 => temp,
--	IN_4 => "00",
--	MOUT => stack_pointer
--	);
--
--	SEL <= "00" when push = '1';
--
--	process(push,pop)
--	begin
--	
--	if(push = '1' and pop = '0')then
--		SEL <= "00";
--	elsif(pop = '1' and push = '0')then
--		SEL <= "01";
--	else
--		SEL <= "10";
--	end if;
--	end process;
	
	
	process(clk)
	begin
	if(falling_edge(clk))then
	--temp <= stack_pointer;
		if(push = '1' and stack_pointer /= "11")then
			stack_pointer<= stack_pointer + '1';
			tmp_ram(conv_integer(stack_pointer)) <= input + 1;
		elsif(pop = '1'  and stack_pointer /= "00")then
			output <= tmp_ram(conv_integer(stack_pointer - 1 ));
			stack_pointer <= stack_pointer - '1';
		else
			output <= (others => 'Z');
		end if;
	end if;
	end process;

end Behavioral;

