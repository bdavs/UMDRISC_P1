----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:14:18 03/25/2016 
-- Design Name: 
-- Module Name:    TopLevel - Behavioral 
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

entity TopLevel is
port(	clk : in std_logic;
		rst : in std_logic
);	
end TopLevel;

architecture Behavioral of TopLevel is

signal addr: std_logic_vector(15 downto 0)  := (others => '0');
signal writeEnable : std_logic := '0';

signal t1, t2, t3, t4, t5: std_logic_vector (15 downto 0):= (others => '0');

signal inst : std_logic_vector(15 downto 0):= (others => '0'); 
signal inst_latch : std_logic_vector(15 downto 0):= (others => '0'); 

 
signal op : std_logic_vector(3 downto 0):= (others => '0'); 
signal operand_op_latch : std_logic_vector(3 downto 0):= (others => '0'); 


signal RA_addr : std_logic_vector(3 downto 0):= (others => '0');
signal RA_data : std_logic_vector(15 downto 0):= (others => '0');

signal Writeback_Addr : std_logic_vector(3 downto 0):= (others => '0');

signal RB_addr : std_logic_vector(3 downto 0):= (others => '0');
signal RB_data : std_logic_vector(15 downto 0):= (others => '0');

signal Imm : std_logic_vector(3 downto 0):= (others => '0');

signal en_fetch : std_logic := '1';
signal en_decode : std_logic := '1';
signal en_pipeline : std_logic := '1';
signal en_operand : std_logic := '1';

signal operand_read : std_logic := '1';
signal operand_write : std_logic := '0';
signal operand_write_addr : std_logic_vector(3 downto 0):= (others => '0');

signal data_in : std_logic_vector(15 downto 0):= (others => '0');

signal ccr: std_logic_vector(3 downto 0):= (others => '0');

signal execute_alu_out: std_logic_vector(15 downto 0):= (others => '0');
signal execute_alu_out_latch: std_logic_vector(15 downto 0):= (others => '0');

signal execute_ldst_out: std_logic_vector(15 downto 0):= (others => '0');
signal execute_ldst_out_latch: std_logic_vector(15 downto 0):= (others => '0');

signal RE: std_logic:='0'; 
signal WE: std_logic:='0'; 

begin

fetch: entity work.fetch_toplevel
port map(
			clk => clk,
			addr => addr,
			writeEnable => writeEnable,
			en_fetch => en_fetch,
			output => inst
			);

Decode_top: entity work.Decode_top			
port map(	clk => clk,
		inst => inst,
		op_latch => op,
		Imm_latch => Imm,
		RA_addr_latch => RA_addr,
		RB_addr_latch => RB_addr		
);	


operand_top: entity work.Operand_top
port map(	clk => clk,
		RE => RE,
		WE => WE,
		RA_addr => RA_addr,
		RB_addr =>RB_addr,
		Writeback_Addr =>Writeback_Addr,
		execute_alu_out  =>execute_alu_out,
		RA_data_latch =>RA_data,
		RB_data_latch =>RB_data,
		operand_op_latch =>operand_op_latch,
		Imm =>Imm,
		op => op,
		en_operand  =>	en_operand
		);
	
	execute: entity work.ALU
port map(  CLK => clk,
           RA  => RA_data,
           RB  => RB_data,
           OPCODE  => operand_op_latch,
           CCR => ccr,
           ALU_OUT  => execute_alu_out,
           LDST_OUT => execute_ldst_out
);
	
	
	
	
pipline: entity work.PipelineController
port map (
			 clk => clk,
			 en => en_pipeline,
			 input => inst,
			 t1 => t1,
			 t2 => t2,
			 t3 => t3,
			 t4 => t4,
			 t5 => t5);


			
			

		
ControlModules: entity work.ControlModules
port map(clk => clk,
			op => operand_op_latch,
			ccr => ccr,
			RA_addr => Writeback_Addr,
			RE => RE,
			WE => WE,
			t1 => t1,
			 t2 => t2,
			 t3 => t3,
			 t4 => t4,
			 t5 => t5
			);

			

alu_out_latch: entity work.reg
generic map (n => 16)
port map(
			clk => clk,
			input => execute_alu_out,
			en => en_decode,
			output => execute_alu_out_latch);
			
ldst_out_latch: entity work.reg
generic map (n => 16)
port map(
			clk => clk,
			input => execute_ldst_out,
			en => en_decode,
			output => execute_ldst_out_latch);
			
			
			
end Behavioral;

