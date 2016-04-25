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

entity controlModules is

	port( clk : in  STD_LOGIC;
	
			op : in STD_LOGIC_vector(3 downto 0);
			ID:in std_logic_vector(1 downto 0);
			ccr : in STD_LOGIC_vector(3 downto 0);
			t1, t2, t3, t4, t5 : in STD_LOGIC_VECTOR(15 downto 0);
			RA_addr : out STD_LOGIC_vector(3 downto 0);
			WE, RE,lwvd_en : out STD_LOGIC;
					wea : out STD_LOGIC_vector(0 downto 0);
			run: in std_logic;
			S_en : buffer STD_LOGIC;
			S_write : out STD_LOGIC;
			S_Read : out STD_LOGIC;
			ext_wea : out STD_LOGIC_vector(0 downto 0);


			ext_addr_en:out STD_LOGIC;

		

			--latch1 : out  STD_LOGIC;
			--regBank : out  STD_LOGIC;
			--PCcnt : out  STD_LOGIC;
			
			--decode: out  STD_LOGIC;
			--latch2 : out  STD_LOGIC;
			
			--RBwrite : out  STD_LOGIC;
			--RBread : out  STD_LOGIC;
			--latch3 : out  STD_LOGIC

			en_fetch : out std_logic ;
			en_decode :out std_logic;
			en_pipeline : out std_logic ;
			en_operand :out std_logic ;
			en_Writeback:out std_logic;
			en_execute: out std_logic
			);


			

end controlModules;

architecture Combinational of controlModules is
begin

	--signal t1, t2, t3, t4, t5 : STD_LOGIC_VECTOR(15 downto 0);

process(OP)
begin

case OP is
		when "1001"=>
			en_Writeback<='1';
		when "1011"=>
			en_Writeback<='1';
		when others=>
			en_Writeback<='0';
		end case;

case OP is
		when "1011"=>
			S_en<='1';
		when "1100"=>
			S_en<='1';
		when others=>
			S_en<='0';
		end case;

ext_addr_en<='0';
 RE <= '1';
 WE <= '0' ;
 
 if(OP="1010")then
 wea<="1";
 else
 wea<="0";
 end if;
 
 if(S_en='1')then
 S_read<='1';
 else
 S_read<='0';
 end if;
 
 if(OP="1100")then
 ext_wea<="1";
 else
 ext_wea<="0";
 end if;
 
if (OP/="1011" and ID="01")then --lwvd
--RA_addr <= t4(11 downto 8);
lwvd_en<='1';
wea<="1";
ext_wea<="0";
end if;

if (OP/="1011" and ID="11")then --lwvs 
 S_write <= '1' ;
 WE<='0';
 else 
 S_write<='0';
 end if;
 
if (OP/="1100" and ID="01")then
wea<="0";
ext_wea<="1";
ext_addr_en<='1';
end if;


 end process;
 

 
 --RegBankCMD: entity work.RegBankCMD
  --  port map(       
  --         Writeback_Data => ALUOUT,
   --        Writeback_Addr => RA_addr,
    --       WE => WE,
    --       RE => RE);

	--pipeline: entity work.PipelineController 
	--port map( clk,en,input,t1,t2,t3,t4,t5);

process(run) 
begin
	if(run = '0') then
		en_fetch <= '0';
		en_decode <= '0';
		en_pipeline <= '0' ;
		en_operand <= '0' ;
		en_execute <= '0';
	else
		en_fetch <= '1';
		en_decode <= '1';
		en_pipeline <= '1' ;
		en_operand <= '1' ;
		en_execute <= '1';
	end if;
end process;
	

end Combinational;

