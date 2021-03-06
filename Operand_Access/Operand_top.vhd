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
port(clk : in std_logic;
		RE : in std_logic;
		WE : in std_logic;
		int_mode : in std_logic;
		jmp_mode : in std_logic;
		S_en : in std_logic;
		S_write : in std_logic;
		S_Read : in std_logic;
		s_addr: in std_logic_vector(1 downto 0);
		s_id: in std_logic_vector(1 downto 0);
		RA_addr : in std_logic_vector(3 downto 0);
		RB_addr : in std_logic_vector(3 downto 0);
		Write_Back : in std_logic_vector(15 downto 0);
		Writeback_Addr : in std_logic_vector(3 downto 0);
		--execute_alu_out  : in std_logic_vector(15 downto 0);
		RA_data_latch : out std_logic_vector(15 downto 0);
		RB_data_latch : out std_logic_vector(15 downto 0);
		S_out_latch : out std_logic_vector(15 downto 0):= (others => '0');
		operand_op_latch : out std_logic_vector(3 downto 0);
		op : in std_logic_vector(3 downto 0);
		Imm : in std_logic_vector(3 downto 0);
		run: in std_logic;
		Debug_address: in std_logic_vector (11 downto 0);
		Core_Debug: out std_logic_vector(15 downto 0);

		en_operand  : in std_logic	
);
end Operand_top;

architecture Behavioral of Operand_top is

signal operand_mux_sel: std_logic := '0';
signal ALU_RB : std_logic_vector(15 downto 0);
signal ALU_RA: std_logic_vector(15 downto 0);
signal RA_data : std_logic_vector(15 downto 0);
signal RB_data : std_logic_vector(15 downto 0);
signal full_imm : std_logic_vector(15 downto 0);
signal S_out : std_logic_vector(15 downto 0);
signal RA_addr_Debug: std_logic_vector(3 downto 0);
signal operand_op_latch_t: std_logic_vector(3 downto 0);
--signal S_addr : std_logic_vector(1 downto 0);
--signal int_mode : std_logic;
--signal jmp_mode : std_logic; --CHANGE THIS TO AN INPUT ONCE YOU NEED IT BOBBY
begin

with run select
RA_addr_Debug <=
	RA_addr when '1',
	Debug_address(3 downto 0) when '0',
	RA_addr when others;

operand: entity work.Operand_Registers
port map(
			Clock => clk,
			Enable => en_operand,
			Read => RE,
			Write => WE,
			Read_AddrA => RA_addr_Debug,
			int_mode => int_mode,
			jmp_mode => jmp_mode,
			Read_AddrB => RB_addr,
			Write_AddrA => Writeback_Addr,
			Data_inA => Write_back,
			Data_outA => RA_data,
			Data_outB => RB_data
);

Core_Debug <= RA_data;

Shadow: entity work.Shadow_Register
port map(
				clock => clk,
           Data_in =>Write_Back,
           Read_addrA=>S_addr,
			  Write_addrA=>Writeback_Addr(1 downto 0),
			  S_en => S_en,
			  S_write=>S_write,
			    S_read=>S_read,
			  S_out =>S_out
); 

-- turn 8 bit imm into 16 bits

with operand_op_latch_t select
operand_mux_sel <= '0' when x"0" | x"1" | x"2" | x"3" | x"4",
							'1' when others;

full_imm <= "00000000" & RB_addr & Imm;

operand_RB_mux: entity work.mux_2to1
generic map(width => 16)
port map(
			SEL => operand_mux_sel,
			IN_1 => RB_data,
			IN_2 => full_imm,
			MOUT => ALU_RB
);


--operand_latch_RA_data: entity work.reg
--generic map (n => 16)
--port map(
--			clk => clk,
--			input => RA_data,
--			en => en_operand,
--			output => RA_data_latch);

S_out_latch_data: entity work.reg
generic map (n => 16)
port map(
			clk => clk,
			input => S_out,
			en => en_operand,
			output => S_out_latch);
			
		

			
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
			output => operand_op_latch_t);
			
operand_op_latch <= operand_op_latch_t;
RA_data_latch <= RA_data;
--process(clk)
--			begin 
--			if (falling_edge(clk))then
--			
--			end if;
--			end process;

			
end Behavioral;

