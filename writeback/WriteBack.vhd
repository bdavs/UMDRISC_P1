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
			   ext_addr_en  : in std_logic;
		
			   wea  : in std_logic_vector(0 downto 0);
				ext_wea  : in std_logic_vector(0 downto 0);
				lwvd_en : in std_logic;
				 S_en  : in std_logic;
				 S_id_latch :in std_logic_vector(1 downto 0);
				 S_addr_latch :in std_logic_vector(1 downto 0);
			  Write_back :out STD_LOGIC_VECTOR (15 downto 0);
			  Writeback_address: out std_logic_vector(3 downto 0)
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

signal Datamem_in  : STD_LOGIC_VECTOR (15 downto 0);
signal D_addr :std_logic_vector(7 downto 0);
--signal wea : STD_LOGIC_VECTOR (0 downto 0);
begin
D_addr<=execute_ldst_out_latch(7 downto 0);


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


Writeback: entity work.Data_Mem
port map(
			clka =>clk,
    wea =>wea,
    addra =>D_addr,
    dina =>Datamem_in,
    douta =>LD_latch);
	 
	 

			

writeback_mux: entity work.mux_2to1
generic map(width => 16)
port map(
			SEL => en_Writeback,
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
			

Writeback_out_latch: entity work.reg
	generic map (n => 16)
	port map(
			clk => clk,
			input => Write_back_m,
			en => '1',
			output => Write_back);

end Behavioral;

