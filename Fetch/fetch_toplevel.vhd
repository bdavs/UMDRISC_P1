----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:06:39 03/30/2016 
-- Design Name: 
-- Module Name:    fetch_toplevel - Behavioral 
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

entity fetch_toplevel is
port( clk: in std_logic;
		en_fetch: in std_logic := '1';
		move_and_en: in std_logic_vector(15 downto 0);
		int: in std_logic_vector (3 downto 0);
		output: out std_logic_vector(15 downto 0)
		);
end fetch_toplevel;

architecture Behavioral of fetch_toplevel is
signal count: std_logic_vector(11 downto 0);
signal inst: std_logic_vector(15 downto 0);

signal inp: std_logic_vector(11 downto 0);
signal outp: std_logic_vector(11 downto 0);
signal toutp: std_logic_vector(11 downto 0);

signal int_addr: std_logic_vector(11 downto 0);

signal push: std_logic := '0';
signal pop: std_logic := '0';

signal tpush: std_logic := '0';
signal tpop: std_logic := '0';

signal addr: std_logic_vector(11 downto 0);
signal writeEnable : std_logic;


signal reset: std_logic_vector(11 downto 0) := (others => '0');

signal int_writeEnable: std_logic;

signal move: std_logic_vector(11 downto 0);
signal stall_ready : std_logic;
signal stall_finished : std_logic;


begin


--int_on <= int(0) or int(1) or int(2) or int(3);
			
			
			
--we only want to write once
--then continue counting
process(clk)
begin
if (clk'event and clk = '0')then
	if(int_writeEnable ='1')then 
		writeEnable <= '1';
	elsif(move_and_en(15 downto 13) = "11")then
		writeEnable <= '1';
	elsif(pop='1')then
		writeEnable <= '1';
	else writeEnable <= '0';
	end if;
end if;

--
--if (clk'event and clk = '1')then
--	writeEnable <= '0';
--end if;
end process;


ProgramCounter: entity work.ProgramCounter
port map(
			clk => clk,
			addr => addr,
			writeEnable => writeEnable,
			count => count
);

InterruptController: entity work.InterruptController_fetch 
port map ( 	clk => clk,
			int => int,
			addr => int_addr,
			int_stack_push => tpush,
			int_stack_pop => tpop,
			--int_stack_output => toutp,--temp
			stall_ready => stall_ready,
			stall_finished => stall_finished,
			inst => inst,
			writeEnable => int_writeEnable
			);
			
			
			
move <= move_and_en(11 downto 0);
PCMux: entity work.mux_4to1
generic map( width => 12)
port map(
	SEL  => "00",
	IN_1 => outp,
	IN_2 => int_addr,
	IN_3 => move,
	IN_4 => reset,
	MOUT => addr
	);
	
	

PCstack: entity work.PCstack
generic map( width => 12)
port map(
			  input => inp,
           output => outp,
           push => push,
           pop => pop,
			  clk => clk
);
  
ROM: entity work.ROM
port map(
			ADDRA => count,
			CLKA => clk,
			DOUTA => inst
);

fetch_latch: entity work.reg
port map(
			clk => clk,
			input => inst,
			en => en_fetch,
			output => output
			);

end Behavioral;