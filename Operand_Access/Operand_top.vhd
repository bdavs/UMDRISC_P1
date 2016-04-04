----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:19:46 03/31/2016 
-- Design Name: 
-- Module Name:    Operand_top - Behavioral 
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
use work.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Operand_top is
port(	clk : in std_logic;
		RE : in std_logic;
		WE : in std_logic;
		RA_addr : in std_logic_vector(3 downto 0);
		RB_addr : in std_logic_vector(3 downto 0);
		Writeback_Addr : in std_logic_vector(3 downto 0);
		execute_alu_out  : in std_logic_vector(15 downto 0);
		RA_data_latch : out std_logic_vector(15 downto 0);
		RB_data_latch : out std_logic_vector(15 downto 0);
		operand_op_latch : out std_logic_vector(3 downto 0);
		op : in std_logic_vector(3 downto 0);
		Imm : in std_logic_vector(3 downto 0);
		en_operand  : in std_logic		
);
end Operand_top;

architecture Behavioral of Operand_top is

signal operand_mux_sel: std_logic;
signal ALU_RB : std_logic_vector(15 downto 0);
signal RA_data : std_logic_vector(15 downto 0);
signal RB_data : std_logic_vector(15 downto 0);
signal full_imm : std_logic_vector(15 downto 0);

begin
	
operand: entity work.RegRAM
port map(
			Clock => clk,
			Enable => en_operand,
			Read => RE,
			Write => WE,
			Read_AddrA => RA_addr,
			Read_AddrB => RB_addr,
			Write_AddrA => Writeback_Addr,
			Data_inA => execute_alu_out,
			Data_outA => RA_data,
			Data_outB => RB_data
);

-- turn 8 bit imm into 16 bits
full_imm <= "00000000" & RB_addr & Imm;

operand_RB_mux: entity work.mux_2to1
generic map(width => 16)
port map(
			SEL => operand_mux_sel,
			IN_1 => RB_data,
			IN_2 => full_imm,
			MOUT => ALU_RB
);

operand_latch_RA_data: entity work.reg
generic map (n => 16)
port map(
			clk => clk,
			input => RA_data,
			en => en_operand,
			output => RA_data_latch);
			
operand_latch_RB_data: entity work.reg
generic map (n => 16)
port map(
			clk => clk,
			input => ALU_RB,
			en => en_operand,
			output => RB_data_latch);

operand_latch_op: entity work.reg
generic map (n => 4)
port map(
			clk => clk,
			input => op,
			en => en_operand,
			output => operand_op_latch);
			
end Behavioral;

