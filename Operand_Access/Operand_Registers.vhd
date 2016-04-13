----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:36:12 04/13/2016 
-- Design Name: 
-- Module Name:    Operand_Registers - Behavioral 
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

entity Operand_Registers is
generic(	width:	integer:=16;
			depth:	integer:=16;
			addr:	integer:=4);
port(	Clock:		in std_logic;	
		Enable:		in std_logic;
		Read:			in std_logic;
		Write:		in std_logic;
		int_mode:	in std_logic;
		Read_AddrA:	in std_logic_vector(addr-1 downto 0);
		Read_AddrB:	in std_logic_vector(addr-1 downto 0);
		Write_AddrA:in std_logic_vector(addr-1 downto 0); 
		Data_inA: 	in std_logic_vector(width-1 downto 0);
		Data_outA: 	out std_logic_vector(width-1 downto 0);
		Data_outB: 	out std_logic_vector(width-1 downto 0)
);
end Operand_Registers;

architecture Behavioral of Operand_Registers is
signal Data_outA_regular: std_logic_vector(width-1 downto 0);
signal Data_outB_regular: std_logic_vector(width-1 downto 0);
signal Data_outA_int: std_logic_vector(width-1 downto 0);
signal Data_outB_int: std_logic_vector(width-1 downto 0);

signal int_mode_not: std_logic;
begin

int_mode_not <= not int_mode;
regular_register: entity work.RegRAM
port map(
			Clock => Clock,
			Enable => int_mode_not,
			Read => Read,
			Write => Read,
			Read_AddrA => Read_AddrA,
			Read_AddrB => Read_AddrB,
			Write_AddrA => Write_AddrA,
			Data_inA => Data_inA,
			Data_outA => Data_outA_regular,
			Data_outB => Data_outB_regular
);

interrupt_register: entity work.RegRAM
port map(
			Clock => Clock,
			Enable => int_mode,
			Read => Read,
			Write => Read,
			Read_AddrA => Read_AddrA,
			Read_AddrB => Read_AddrB,
			Write_AddrA => Write_AddrA,
			Data_inA => Data_inA,
			Data_outA => Data_outA_int,
			Data_outB => Data_outB_int
);

operand_Data_outA_mux: entity work.mux_2to1
generic map(width => 16)
port map(
			SEL => int_mode,
			IN_1 => Data_outA_regular,
			IN_2 => Data_outA_int,
			MOUT => Data_outA
);

operand_Data_outB_mux: entity work.mux_2to1
generic map(width => 16)
port map(
			SEL => int_mode,
			IN_1 => Data_outB_regular,
			IN_2 => Data_outB_int,
			MOUT => Data_outB
);

end Behavioral;

