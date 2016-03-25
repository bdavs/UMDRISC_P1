----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:04:57 03/25/2016 
-- Design Name: 
-- Module Name:    controlModules - Behavioral 
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

entity controlModules is

	port( clk : in  STD_LOGIC;
			
			latch1 : out  STD_LOGIC;
			regBank : out  STD_LOGIC;
			PCcnt : out  STD_LOGIC;
			
			decode: out  STD_LOGIC;
			latch2 : out  STD_LOGIC;
			
			RBwrite : out  STD_LOGIC;
			RBread : out  STD_LOGIC;
			latch3 : out  STD_LOGIC);

end controlModules;

architecture Behavioral of controlModules is


	signal t1, t2, t3, t4, t5 : STD_LOGIC_VECTOR(15 downto 0);

begin

	pipeline: entity work.PipelineController 
	port map( clk,en,input,t1,t2,t3,t4,t5);


end Behavioral;

