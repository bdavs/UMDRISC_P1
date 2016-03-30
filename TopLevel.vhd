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

signal addr: std_logic_vector(4 downto 0)  := (others => '0');
signal writeEnable : std_logic := '0';

signal t1, t2, t3, t4, t5: std_logic_vector (15 downto 0);

signal inst : std_logic_vector(15 downto 0); 
signal inst_latch : std_logic_vector(15 downto 0); 

signal op : std_logic_vector(3 downto 0); 
signal op_latch : std_logic_vector(3 downto 0); 

signal RA_addr : std_logic_vector(3 downto 0);
signal RA_addr_latch : std_logic_vector(3 downto 0);
signal RA_data : std_logic_vector(15 downto 0);
signal RA_data_latch : std_logic_vector(15 downto 0);

signal RB_addr : std_logic_vector(3 downto 0);
signal RB_addr_latch : std_logic_vector(3 downto 0);
signal RB_data : std_logic_vector(15 downto 0);
signal ALU_RB : std_logic_vector(15 downto 0);
signal RB_data_latch : std_logic_vector(15 downto 0);

signal Imm : std_logic_vector(7 downto 0);
signal Imm_latch : std_logic_vector(7 downto 0);

signal en_fetch : std_logic := '1';
signal en_decode : std_logic := '1';
signal en_pipeline : std_logic := '1';
signal en_operand : std_logic := '1';

signal operand_read : std_logic := '1';
signal operand_write : std_logic := '0';
signal operand_write_addr : std_logic_vector(3 downto 0);

signal data_in : std_logic_vector(15 downto 0);

signal operand_mux_sel: std_logic; 
begin

fetch: entity work.fetch_toplevel
port map(
			clk => clk,
			addr => addr,
			writeEnable => writeEnable,
			inst => inst);

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

fetch_latch: entity work.reg
port map(
			clk => clk,
			input => inst,
			en => en_fetch,
			output => inst_latch);

decode: entity work.Decoder
port map( 	inst => inst_latch,
				clk => clk,
				op => op,
				RA => RA_addr,
				RB => RB_addr,
				Imm => Imm);
			  
decode_latch_op: entity work.reg
generic map (n => 4)
port map(
			clk => clk,
			input => op,
			en => en_decode,
			output => op_latch);
			
decode_latch_RA: entity work.reg
generic map (n => 4)
port map(
			clk => clk,
			input => RA_addr,
			en => en_decode,
			output => RA_addr_latch);

decode_latch_RB: entity work.reg
generic map (n => 4)
port map(
			clk => clk,
			input => RB_addr,
			en => en_decode,
			output => RB_addr_latch);
			
decode_latch_Imm: entity work.reg
generic map (n => 8)
port map(
			clk => clk,
			input => Imm,
			en => en_decode,
			output => Imm_latch);
			
operand: entity work.RegRAM
port map(
			Clock => clk,
			Enable => en_operand,
			Read => operand_read,
			Write => operand_write,
			Read_AddrA => RA_addr_latch,
			Read_AddrB => RB_addr_latch,
			Write_AddrA => operand_write_addr,
			Data_inA => data_in,
			Data_outA => RA_data,
			Data_outB => RB_data
);

operand_RB_mux: entity work.mux_2to1
generic map(width => 16)
port map(
			SEL => operand_mux_sel,
			IN_1 => RB_data,
			IN_2 => "00000000"&Imm_latch,
			MOUT => ALU_RB
);

operand_latch_RA_data: entity work.reg
generic map (n => 16)
port map(
			clk => clk,
			input => RA_data,
			en => en_decode,
			output => RA_data_latch);
			
operand_latch_RB_data: entity work.reg
generic map (n => 16)
port map(
			clk => clk,
			input => ALU_RB,
			en => en_decode,
			output => RB_data_latch);
				
end Behavioral;

