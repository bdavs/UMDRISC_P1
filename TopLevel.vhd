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

signal inst : std_logic_vector(15 downto 0); 
signal inst_latch : std_logic_vector(15 downto 0); 

signal op : std_logic_vector(3 downto 0); 
signal op_latch : std_logic_vector(3 downto 0); 

signal RA : std_logic_vector(3 downto 0);
signal RA_latch : std_logic_vector(3 downto 0);

signal RB : std_logic_vector(3 downto 0);
signal RB_latch : std_logic_vector(3 downto 0);

signal Imm : std_logic_vector(7 downto 0);
signal Imm_latch : std_logic_vector(7 downto 0);

signal en_fetch : std_logic := '1';
signal en_decode : std_logic := '1';

begin

fetch: entity work.fetch_toplevel
port map(
			clk => clk,
			addr => addr,
			writeEnable => writeEnable,
			inst => inst);

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
				RA => RA,
				RB => RB,
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
			input => RA,
			en => en_decode,
			output => RA_latch);

decode_latch_RB: entity work.reg
generic map (n => 4)
port map(
			clk => clk,
			input => RA,
			en => en_decode,
			output => RA_latch);
			
decode_latch_Imm: entity work.reg
generic map (n => 8)
port map(
			clk => clk,
			input => Imm,
			en => en_decode,
			output => Imm_latch);
				
end Behavioral;

