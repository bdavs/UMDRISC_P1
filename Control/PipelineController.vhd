----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:55:16 03/25/2016 
-- Design Name: 
-- Module Name:    PipelineController - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PipelineController is
	port (clk 		: in STD_LOGIC;
			input 	: in STD_LOGIC_VECTOR (15 downto 0);
			en 		: in STD_LOGIC;
			t1 		: out STD_LOGIC_VECTOR (15 downto 0);
			t2 		: out STD_LOGIC_VECTOR (15 downto 0);
			t3 		: out STD_LOGIC_VECTOR (15 downto 0);
			t4 		: out STD_LOGIC_VECTOR (15 downto 0);
			t5 		: out STD_LOGIC_VECTOR (15 downto 0)
			);

end PipelineController;

architecture Structural of PipelineController is
	signal t1_out, t2_out, t3_out, t4_out, t5_out : STD_LOGIC_VECTOR (15 downto 0);
begin
	process(input)
	begin
		t1_out <= input;
	end process;
	
--	U1: entity work.reg 
--	port map( clk    => clk,
--              en    => en,
--              input  => input,
--              output => t1_out);
				  
	U2: entity work.reg 
	port map( clk    => clk,
              en    => en,
              input  =>  t1_out,
              output => t2_out);
				  
	U3: entity work.reg 
	port map( clk    => clk,
              en    => en,
              input  => t2_out,
              output => t3_out);
				  
	U4: entity work.reg 
	port map( clk    => clk,
              en    => en,
              input  => t3_out,
              output => t4_out);
				  
	U5: entity work.reg 
	port map( clk    => clk,
              en    => en,
              input  => t4_out,
              output => t5_out);
				  
	t1 <= t1_out;
	t2 <= t2_out;
	t3 <= t3_out;
	t4 <= t4_out;
	t5 <= t5_out;

end Structural;


