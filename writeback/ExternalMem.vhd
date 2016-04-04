----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:36:00 04/01/2016 
-- Design Name: 
-- Module Name:    ExternalMem - Behavioral 
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ExternalMem is
generic(	width:	integer:=16;
			depth:	integer:=16;
			addr:	integer:=4);
port(	Clock:		in std_logic;	
		Enable:		in std_logic;
		Read:		in std_logic;
		Write:		in std_logic;
		AddrA:	in std_logic_vector(width-1 downto 0); 
		Data_inA: 	in std_logic_vector(width-1 downto 0);
		Data_outA: 	out std_logic_vector(width-1 downto 0)
		
);
end ExternalMem;

architecture Behavioral of ExternalMem is
type ram_type is array (0 to depth-1) of 
	std_logic_vector(width-1 downto 0);
signal tmp_ram: ram_type;
begin
process(Clock, Read)
    begin
	if (Clock'event and Clock='1') then
	   if (Enable='1') then
		if (Read='1') then
		    -- built in function conv_integer change the type
		    -- from std_logic_vector to integer
		    Data_outA <= tmp_ram(conv_integer(AddrA)); 
		    
		else
		    Data_outA <= (Data_outA'range => 'Z');
	       
		end if;
	   end if;
	end if;
    end process;
	
    -- Write Functional Section operate on falling edge
    process(Clock, Write)
    begin
	if (Clock'event and Clock='0') then
	    if Enable='1' then
		if Write='1' then
		    tmp_ram(conv_integer(AddrA)) <= Data_inA;
		end if;
	    end if;
	end if;
    end process;


end Behavioral;

