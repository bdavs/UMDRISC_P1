----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:40:21 04/12/2016 
-- Design Name: 
-- Module Name:    Shadow_Register - Behavioral 
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

entity Shadow_Register is
generic(	width:	integer:=16;
			depth:	integer:=4;
			addr:	integer:=2);
Port(	clock : in std_logic;
           Data_in  : in STD_LOGIC_VECTOR (15 downto 0);
           Read_addrA : in STD_LOGIC_VECTOR (1 downto 0);
			  write_addrA : in STD_LOGIC_VECTOR (1 downto 0);
			  S_en  : in std_logic;
			  S_write:		in std_logic;
			    S_Read:		in std_logic;
			  S_out :out STD_LOGIC_VECTOR (15 downto 0) 
			  ); 
end Shadow_Register;

architecture Behavioral of Shadow_Register is
type ram_type is array (0 to depth-1) of
	std_logic_vector(width-1 downto 0);
signal tmp_ram: ram_type;

begin	

    -- Read Functional Section operates on rising edge
    process(Clock, S_Read)
    begin
	if (Clock'event and Clock='1') then
	   if (S_en='1') then
		if (S_Read='1') then
		    -- built in function conv_integer change the type
		    -- from std_logic_vector to integer
		    S_out <= tmp_ram(conv_integer(Read_addrA)); 
		    
		else
		    S_out <= (S_out'range => 'Z');
	       
		end if;
	   end if;
	end if;
    end process;
	
    -- Write Functional Section operate on falling edge
    process(Clock, S_Write)
    begin
	if (Clock'event and Clock='0') then
	    if S_en='1' then
		if S_write='1' then
		    tmp_ram(conv_integer(Write_addrA)) <= Data_in;
		end if;
	    end if;
	end if;
    end process;

end Behavioral;

