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
use work.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity controlModules is

	port( clk : in  STD_LOGIC;
	
			op : in STD_LOGIC_vector(3 downto 0);
			ccr : in STD_LOGIC_vector(3 downto 0);
			t1, t2, t3, t4, t5 : in STD_LOGIC_VECTOR(15 downto 0);
			RA_addr : out STD_LOGIC_vector(3 downto 0);
			WE, RE : out STD_LOGIC;
					wea : out STD_LOGIC_vector(0 downto 0);
			en_Writeback : out STD_LOGIC;
			S_en : buffer STD_LOGIC;
			S_write : out STD_LOGIC;
			S_Read : out STD_LOGIC;
			ext_wea : out STD_LOGIC_vector(0 downto 0)
			--latch1 : out  STD_LOGIC;
			--regBank : out  STD_LOGIC;
			--PCcnt : out  STD_LOGIC;
			
			--decode: out  STD_LOGIC;
			--latch2 : out  STD_LOGIC;
			
			--RBwrite : out  STD_LOGIC;
			--RBread : out  STD_LOGIC;
			--latch3 : out  STD_LOGIC
			);

			

end controlModules;

architecture Behavioral of controlModules is


	--signal t1, t2, t3, t4, t5 : STD_LOGIC_VECTOR(15 downto 0);



begin


 RE <= '1';
 WE <= '0' when OP="1010" else '1';
 wea<="1" when OP="1010" else "0";
en_Writeback<='1' when OP="1001" else '0';
 RA_addr <= t4(11 downto 8);
 with OP select
   S_en <=
			'1' when "1011",
			'1' when "1100",
			'0' when others;
 S_write <= '1' when S_en='1' else '0' ;
  S_Read <= '1' when S_en='1' else '0' ;
  ext_wea<='1' when OP="1100" else '0';
 

 
 --RegBankCMD: entity work.RegBankCMD
  --  port map(       
  --         Writeback_Data => ALUOUT,
   --        Writeback_Addr => RA_addr,
    --       WE => WE,
    --       RE => RE);

	--pipeline: entity work.PipelineController 
	--port map( clk,en,input,t1,t2,t3,t4,t5);


end Behavioral;

