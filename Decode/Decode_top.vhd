----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:14:29 03/30/2016 
-- Design Name: 
-- Module Name:    Decode_top - Behavioral 
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

entity Decode_top is
port(	clk : in std_logic;
		inst : in std_logic_vector(15 downto 0);
		op_latch : out std_logic_vector(3 downto 0); 
		Imm_latch : out std_logic_vector(3 downto 0);
		RA_addr_latch : out std_logic_vector(3 downto 0);
		RB_addr_latch : out std_logic_vector(3 downto 0);
		s_addr_latch:out std_logic_vector(1 downto 0);
		s_id_latch:out std_logic_vector(1 downto 0);
		en_decode : in std_logic := '1'
);	
end Decode_top;

architecture Behavioral of Decode_top is




signal inst_latch : std_logic_vector(15 downto 0); 

signal op : std_logic_vector(3 downto 0); 
 

signal RA_addr : std_logic_vector(3 downto 0);

signal S_addr : std_logic_vector(3 downto 0);

signal S_id : std_logic_vector(3 downto 0);


signal RB_addr : std_logic_vector(3 downto 0);

signal Imm : std_logic_vector(3 downto 0);

signal en_fetch : std_logic := '1';

signal en_pipeline : std_logic := '1';
signal en_operand : std_logic := '1';




begin


decode: entity work.Decoder
port map( 	inst => inst,
				clk => clk,
				op => op,
				RA => RA_addr,
				RB => RB_addr,
				Imm => Imm,
				S_addr=>S_addr,
				S_id=>S_id);
			  
			 
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
generic map (n => 4)
port map(
			clk => clk,
			input => Imm,
			en => en_decode,
			output => Imm_latch);

decode_latch_Saddress: entity work.reg
generic map (n => 2)
port map(
			clk => clk,
			input => S_addr,
			en => en_decode,
			output => S_addr_latch);

decode_latch_Sid: entity work.reg
generic map (n => 2)
port map(
			clk => clk,
			input => S_id,
			en => en_decode,
			output => s_id_latch);



end Behavioral;

