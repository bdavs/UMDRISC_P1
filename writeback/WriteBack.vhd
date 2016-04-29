----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:42:32 04/01/2016 
-- Design Name: 
-- Module Name:    WriteBack - Behavioral 
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

entity WriteBack is
Port(clk : in std_logic;
           execute_alu_out_latch  : in STD_LOGIC_VECTOR (15 downto 0);
           execute_ldst_out_latch : in STD_LOGIC_VECTOR (15 downto 0);
			  external_address: in STD_LOGIC_VECTOR (15 downto 0);
			  en_Writeback  : in std_logic;
			  en_Writeback_ctrl  : in std_logic;
			   ext_addr_en  : in std_logic;
				RA_addr : in std_logic_vector(3 downto 0);
		
			   wea  : in std_logic_vector(0 downto 0);
				ext_wea  : in std_logic_vector(0 downto 0);
				lwvd_en : in std_logic;
				 S_en  : in std_logic;
				 S_id_latch :in std_logic_vector(1 downto 0);
				 S_addr_latch :in std_logic_vector(1 downto 0);
			  Write_back :out STD_LOGIC_VECTOR (15 downto 0);
			   Write_Addr_sel  : in std_logic;
				Debug_address: in std_logic_vector(11 downto 0);
				run: in std_logic;
				Debug_data: out std_logic_vector(15 downto 0);
			  Writeback_address: out std_logic_vector(3 downto 0)

		
			  --en_write_back: in std_logic

			
			  ); 
 end WriteBack;

architecture Behavioral of WriteBack is

signal LD_ALU_mux : std_logic;
signal LD_execute_latch  :  STD_LOGIC_VECTOR (15 downto 0);
signal Ext_address  :  STD_LOGIC_VECTOR (15 downto 0);
signal LD_latch  : STD_LOGIC_VECTOR (15 downto 0);
signal execute_alu_out  : STD_LOGIC_VECTOR (15 downto 0);
signal temp  : STD_LOGIC_VECTOR (15 downto 0);
signal f_write_back  : STD_LOGIC_VECTOR (15 downto 0);
signal write_back_m  : STD_LOGIC_VECTOR (15 downto 0);

signal ext_out  : STD_LOGIC_VECTOR (15 downto 0);

signal DataMem_Debug: std_logic_vector(7 downto 0);

signal Datamem_in  : STD_LOGIC_VECTOR (15 downto 0);
signal flipped :std_logic_vector(15 downto 0);
signal S_addr :std_logic_vector(3 downto 0);
signal Real_RA: std_logic_vector(15 downto 0):= (others => '0');
--signal wea : STD_LOGIC_VECTOR (0 downto 0);
begin
flipped <= execute_ldst_out_latch(7 downto 0) & execute_ldst_out_latch(15 downto 8);
--D_addr<=execute_ldst_out_latch;
S_addr<="00" & S_addr_latch;
WB_addr_mux: entity work.mux_2to1
generic map(width => 4)
port map(
			SEL => Write_Addr_sel,
			IN_1 => RA_addr,
			IN_2 => S_addr,
			MOUT => Writeback_address);


ext_mem : entity work.Ext_mem
 PORT MAP (
    clka => clk,
    wea => ext_wea,
    addra => Ext_address(15 downto 8),
   dina => execute_alu_out_latch,
    clkb => clk,
    addrb => Ext_address(7 downto 0),
    doutb => ext_out  );

ext_address_mux: entity work.mux_2to1
generic map(width => 16)
port map(
			SEL => ext_addr_en,
			IN_1 => external_address,
			IN_2 => execute_ldst_out_latch,
			MOUT => Ext_address);

ext_data_mux: entity work.mux_2to1
generic map(width => 16)
port map(
			SEL => lwvd_en,
			IN_1 => execute_alu_out_latch,
			IN_2 => ext_out,
			MOUT => Datamem_in);

with run select
DataMem_Debug <=
	flipped(15 downto 8) when '1',
	Debug_address(7 downto 0) when '0',
	flipped(15 downto 8) when others;


Writeback: entity work.Data_Mem
port map(
	clka =>clk,
	clkb => not clk,
    wea =>wea,
    addra =>execute_ldst_out_latch(7 downto 0),
	 addrb => DataMem_Debug,
    dina =>Datamem_in,
    doutb =>LD_latch);
	 
 Debug_data <= LD_latch;
 
--clka : IN STD_LOGIC;
--    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
--    addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
--    dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
--    clkb : IN STD_LOGIC;
--    addrb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
--    doutb : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
			

writeback_mux: entity work.mux_2to1
generic map(width => 16)
port map(
			SEL => en_Writeback_ctrl,
			IN_1 => execute_alu_out_latch,
			IN_2 => LD_latch,
			MOUT => f_Write_back);




ext_mux: entity work.mux_2to1
generic map(width => 16)
port map(
			SEL => S_en,
			IN_1 =>f_Write_back ,
			IN_2 => ext_out,
			MOUT => Write_back_m);
			
			process(clk)
			begin 
			if (falling_edge(clk))then
			Write_back <= Write_back_m;
			end if;
			end process;
			
--
--Writeback_out_latch: entity work.reg
--	generic map (n => 16)
--	port map(
--			clk => clk,
--			input => Write_back_m,
--			en => en_Writeback,
--			output => Write_back);

end Behavioral;

