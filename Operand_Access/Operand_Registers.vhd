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
		jmp_mode: 	in std_logic;
		Read_AddrA:	in std_logic_vector(addr-1 downto 0):= (others => '0');
		Read_AddrB:	in std_logic_vector(addr-1 downto 0):= (others => '0');
		Write_AddrA:in std_logic_vector(addr-1 downto 0):= (others => '0'); 
		Data_inA: 	in std_logic_vector(width-1 downto 0):= (others => '0');
		Data_outA: 	out std_logic_vector(width-1 downto 0):= (others => '0');
		Data_outB: 	out std_logic_vector(width-1 downto 0):= (others => '0')
);
end Operand_Registers;

architecture Behavioral of Operand_Registers is
signal Data_outA_regular: std_logic_vector(width-1 downto 0):= (others => '0');
signal Data_outB_regular: std_logic_vector(width-1 downto 0):= (others => '0');
signal Data_outA_int: std_logic_vector(width-1 downto 0):= (others => '0');
signal Data_outB_int: std_logic_vector(width-1 downto 0):= (others => '0');
signal Data_outA_jmp: std_logic_vector(width-1 downto 0):= (others => '0');
signal Data_outB_jmp: std_logic_vector(width-1 downto 0):= (others => '0');

signal reg_reg_en: std_logic:= '1';
signal int_reg_en:std_logic:= '1';
signal jmp_reg_en:std_logic:= '1';
signal sel: std_logic_vector(1 downto 0):= "00";
begin


regular_register: entity work.RegRAM
port map(
			Clock => Clock,
			Enable => reg_reg_en,
			Read => Read,
			Write => Write,
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
			Enable => int_reg_en,
			Read => Read,
			Write => Write,
			Read_AddrA => Read_AddrA,
			Read_AddrB => Read_AddrB,
			Write_AddrA => Write_AddrA,
			Data_inA => Data_inA,
			Data_outA => Data_outA_int,
			Data_outB => Data_outB_int
);

jump_register: entity work.RegRAM
port map(
			Clock => Clock,
			Enable => jmp_reg_en,
			Read => Read,
			Write => Write,
			Read_AddrA => Read_AddrA,
			Read_AddrB => Read_AddrB,
			Write_AddrA => Write_AddrA,
			Data_inA => Data_inA,
			Data_outA => Data_outA_jmp,
			Data_outB => Data_outB_jmp
);

sel <= int_mode & jmp_mode;

process(Clock)
begin
if(Clock'event and Clock = '1') then

	if(sel = "00")then
		reg_reg_en <= '1';
		int_reg_en <= '1';
		jmp_reg_en <= '1';
	else
		reg_reg_en <= '0';
		int_reg_en <= '0';
		jmp_reg_en <= '0';
	end if;


	if(sel = "00") then
		Data_outA <= Data_outA_regular;
		Data_outB <= Data_outB_regular;
	elsif(sel = "11" or sel = "10") then
		Data_outA <= Data_outA_int;
		Data_outB <= Data_outB_int;
	elsif(sel = "01") then
		Data_outA <= Data_outA_jmp;
		Data_outB <= Data_outB_jmp;
	end if;
	

end if;
end process;
--with OP select
--			LDST_OUT <=
--				Shadow when "1100",
--				 shadow    when OTHERS; 	

end Behavioral;

