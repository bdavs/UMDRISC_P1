--------------------------------------------------------------
-- A simple 8*8 RAM module with dual read and single write
-- operates on opposing edges
-- 
-- by Dr Fortier
-- 
-- KEYWORD: array, concurrent processes, generic, conv_integer 
--------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--------------------------------------------------------------

entity RegRAM is
generic(	width:	integer:=16;
			depth:	integer:=16;
			addr:	integer:=4);
port(	Clock:		in std_logic;	
		Enable:		in std_logic;
		Read:		in std_logic;
		Write:		in std_logic;
		Read_AddrA:	in std_logic_vector(addr-1 downto 0);
		Read_AddrB:	in std_logic_vector(addr-1 downto 0);
		Write_AddrA: 	in std_logic_vector(addr-1 downto 0); 
		Data_inA: 	in std_logic_vector(width-1 downto 0);
		Data_outA: 	out std_logic_vector(width-1 downto 0);
		Data_outB: 	out std_logic_vector(width-1 downto 0)
);
end RegRAM;

--------------------------------------------------------------

architecture behavioral of RegRAM is

-- use an array to define internal temporary signals

type ram_type is array (0 to depth-1) of 
	std_logic_vector(width-1 downto 0);
signal tmp_ram: ram_type;

begin	
			   
    -- Read Functional Section operates on rising edge
    process(Clock, Read)
    begin
	if (Clock'event and Clock='1') then
	   if (Enable='1') then
		if (Read='1') then
		    -- built in function conv_integer change the type
		    -- from std_logic_vector to integer
		    Data_outA <= tmp_ram(conv_integer(Read_AddrA)); 
		    Data_outB <= tmp_ram(conv_integer(Read_AddrB)); 
		else
		    Data_outA <= (Data_outA'range => 'Z');
	       Data_outB <= (Data_outB'range => 'Z');
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
		    tmp_ram(conv_integer(Write_AddrA)) <= Data_inA;
		end if;
	    end if;
	end if;
    end process;

end behavioral;
----------------------------------------------------------------
