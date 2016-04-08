----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:42:32 04/01/2016 
-- Design Name: 
-- Module Name:    WriteBack - Behavioral 
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

entity WriteBack is
Port (		clk : in std_logic;
				RE : in std_logic;
				WE : in std_logic;
           execute_alu_out_latch  : in STD_LOGIC_VECTOR (15 downto 0);
           execute_ldst_out_latch : in STD_LOGIC_VECTOR (15 downto 0);
			  en_Writeback  : in std_logic;
			  Write_back :out STD_LOGIC_VECTOR (15 downto 0)); 
 end WriteBack;

architecture Behavioral of WriteBack is

signal LD_ALU_mux : std_logic;
signal LD_execute_latch  :  STD_LOGIC_VECTOR (15 downto 0);
signal LD_latch  : STD_LOGIC_VECTOR (15 downto 0);
signal execute_alu_out  : STD_LOGIC_VECTOR (15 downto 0);

begin
Writeblack: entity work.ExternalMem
port map(
			Clock => clk,
			Enable => en_writeback,
			Read => RE,
			Write => WE,
			AddrA =>execute_ldst_out_latch,
			Data_inA => execute_alu_out_latch,
			Data_outA => LD_latch
			
);
ex_alu_out_latch: entity work.reg
generic map (n => 16)
port map(
			clk => clk,
			input => execute_alu_out_latch,
			en => en_Writeback,
			output => execute_alu_out);
			
Writeback_latch: entity work.reg
generic map (n => 16)
port map(
			clk => clk,
			input => LD_latch,
			en => en_Writeback,
			output => LD_execute_latch);
			
writeback_mux: entity work.mux_2to1
generic map(width => 16)
port map(
			SEL => LD_ALU_mux,
			IN_1 => execute_alu_out_latch,
			IN_2 => LD_latch,
			MOUT => Write_back
);

end Behavioral;