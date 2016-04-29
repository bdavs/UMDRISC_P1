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
		
			WE, RE,lwvd_en : out STD_LOGIC;
					wea : out STD_LOGIC_vector(0 downto 0);
			run: in std_logic;
			S_en : out STD_LOGIC;
			S_write : out STD_LOGIC;
			S_Read : out STD_LOGIC;
			ext_wea : out STD_LOGIC_vector(0 downto 0);
			Write_Addr_sel  :out std_logic;


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
			en_writeback_ctrl:out std_logic;
			en_execute: out std_logic
			);


			

end controlModules;

architecture Combinational of controlModules is
signal stop_flag : std_logic:='0';
begin

	--signal t1, t2, t3, t4, t5 : STD_LOGIC_VECTOR(15 downto 0);

--process(clk)
--begin
-- if(t5(15 downto 12) = (x"0" or x"1" or x"2" or x"3" or x"4" or x"5" or x"6" or x"7" or x"8" or x"9" or x"B") )then
--	WE <= '1';
-- else
--	WE <= '0' ;
--	end if;
--end process;
process(clk)
begin

case t5(15 downto 12) is
	when x"0" | x"1" | x"2" | x"3" | x"4" | x"5" | x"6" | x"7" | x"8" | x"9" | x"B" =>
		WE <= '1';
	when others =>
		WE <= '0';
		end case;
		end process;
			RE <= '1';
--with t5(15 downto 12) select
--	en_writeback <= 
--		'1' when x"0" | x"1" | x"2" | x"3" | x"4" | x"5" | x"6" | x"7" | x"8" | x"9" | x"B",
--		'0' when others;

process(t5)
begin

case t5(15 downto 12) is
		when x"0"=>
		en_writeback<='1';
		Write_Addr_sel<='0';
		
	
		when x"1"=>
		en_writeback<='1';
		Write_Addr_sel<='0';
	
		when x"2"=>
		en_writeback<='1';
		Write_Addr_sel<='0';
	
		when x"3"=>
		en_writeback<='1';
		Write_Addr_sel<='0';
		
		when X"4"=>
		en_writeback<='1';
		Write_Addr_sel<='0';
	
		when x"5"=>
		en_writeback<='1';
		Write_Addr_sel<='0';
	
		when x"6"=>
		en_writeback<='1';
		Write_Addr_sel<='0';
		
		when x"7"=>
		en_writeback<='1';
		Write_Addr_sel<='0';
		
		when x"8"=>
		en_writeback<='1';
		Write_Addr_sel<='0';
		
		when "1001"=>
			en_writeback<='1';
			Write_Addr_sel<='0';
			en_writeback_ctrl<='1';
		
		when "1011"=>
			en_writeback<='1';
			Write_Addr_sel<='0';
	
		when others=>
			en_writeback<='0';
			Write_Addr_sel<='1';
			en_writeback_ctrl<='0';
		
		end case;
		case t5(15 downto 12) is
		when "1011"=>
			S_en<='1';
		when "1100"=>
			S_en<='1';
		when others=>
			S_en<='0';
		end case;

ext_addr_en<='0';
 
 

 if(t4(15 downto 12)="1010")then
 wea<="1";
 lwvd_en<='0';
 else
 wea<="0";
 lwvd_en<='1';
 end if;
 
 
 
 if(t5(15 downto 12)="1100")then
 ext_wea<="1";
 else
 ext_wea<="0";
 end if;
 
if (t5(15 downto 12)/="1011" and ID="01")then --lwvd
lwvd_en<='1';
wea<="1";
S_Read<='1';
 s_en<='1';
ext_wea<="0";
else
lwvd_en<='0';
wea<="0";
S_Read<='0';
s_en<='0';
ext_wea<="1";
end if;



if (t5(15 downto 12)/="1011" and ID="11")then --lwvs 
 S_write <= '1' ;
 s_en<='1';
 else
  S_write <= '0';
 s_en<='0';
 end if;
 
if (t5(15 downto 12)/="1100" and ID="01")then
wea<="0";
ext_wea<="1";
ext_addr_en<='1';
S_Read<='1';
 s_en<='1';
 else
 wea<="1";
ext_wea<="0";
ext_addr_en<='0';
S_Read<='0';
 s_en<='0';

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
--	process(clk,t4)
--	begin
--	if (rising_edge(clk))then
--	if (t4(15 downto 12) ="1001" or t4(15 downto 12) ="1010" )then
--		stop_flag<='1' ;
--		else 
--		stop_flag<='0';
--		end if;
--
--	end if;
--	end process;
--	
--process(stop_flag) 
--begin
--	if(stop_flag = '1' ) then
--		en_fetch <= '0';
--		en_decode <= '0';
--		en_pipeline <= '0' ;
--		en_operand <= '0' ;
--		en_execute <= '0';
--	else
--	
		en_fetch <= '1';
		en_decode <= '1';
		en_pipeline <= '1' ;
		en_operand <= '1' ;
		en_execute <= '1';
--	end if;
--end process;
	

end Combinational;

