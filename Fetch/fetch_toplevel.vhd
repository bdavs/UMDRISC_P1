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
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
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
		rst: in std_logic;
		en_fetch: in std_logic := '1';
		move_and_en: in std_logic_vector(15 downto 0);
		br_stall: in std_logic;
		int: in std_logic_vector (3 downto 0);
		int_mode : out std_logic;
		jmp_mode : out std_logic;
		output: out std_logic_vector(15 downto 0)
		);
end fetch_toplevel;

architecture Behavioral of fetch_toplevel is
signal count: std_logic_vector(11 downto 0);
signal inst: std_logic_vector(15 downto 0);
signal nop_inst: std_logic_vector(15 downto 0) := x"A000";
signal latch_input: std_logic_vector(15 downto 0);

signal outp: std_logic_vector(11 downto 0);

signal int_addr: std_logic_vector(11 downto 0);

signal push: std_logic := '0';
signal pop: std_logic := '0';

--signal br_stall: std_logic := '0';

signal tpush: std_logic := '0';
signal tpop: std_logic := '0';

signal addr: std_logic_vector(11 downto 0):= (others => '0');
signal writeEnable : std_logic:='0';


signal reset: std_logic_vector(11 downto 0) := (others => '0');

signal int_writeEnable: std_logic:='0';

signal move: std_logic_vector(11 downto 0):= (others => '0');

signal stall_ready : std_logic:='0';
signal stall_finished : std_logic := '0';
signal stall_cnt_in: std_logic_vector(1 downto 0) := (others => '0');
--signal stall_cnt_out: std_logic_vector(1 downto 0) := (others => '0');
--signal stall_temp: std_logic_vector(15 downto 0) := (others => '0');

signal SEL : std_logic_vector(1 downto 0) := "00";


begin


--stall_temp <= output;

process(clk)
begin
if (clk'event and clk = '0')then
	--writeEnable and select for PC
	if(int_writeEnable ='1')then 
		SEL <= "01";
		writeEnable <= '1';
	elsif(move_and_en(15 downto 12)="1101" or move_and_en(15 downto 12)="1111")then
		writeEnable <= '1';
		SEL <= "10";
	elsif(pop='1')then
		SEL <= "00";
		writeEnable <= '1';
	elsif(rst = '1')then
		SEL <= "11";
		writeEnable <= '1';
	else 
		writeEnable <= '0';
	end if;
	
	--stall
	if (stall_ready = '0' and br_stall = '0' and stall_cnt_in = "00")then
		latch_input <= inst;
		stall_cnt_in <= "00";
		push <= '0';
		stall_finished <= '0';
		--pop = '0';
	elsif((stall_ready = '1' and stall_cnt_in = "00") or br_stall = '1')then --first instance
		stall_cnt_in <= stall_cnt_in + 1; 
		latch_input <= nop_inst;
		stall_finished <= '0';
		if (move_and_en(15 downto 12) = "1111")then
			push <= '0';
		else
			push <= '1';
		end if;
		--pop = '0';
	elsif(stall_cnt_in = "01" or stall_cnt_in = "10" or stall_cnt_in = "00")then --stalling
		stall_cnt_in <= stall_cnt_in + 1; 
		latch_input <= nop_inst;
		push <= '0';
		stall_finished <= '0';
		--pop = '0';
	elsif(stall_ready = '1' and stall_cnt_in ="11")then --(stall done)
		stall_cnt_in <= "00";
		stall_finished <= '1';
		push <= '0';
	else 
		latch_input <= inst;
		stall_cnt_in <= "00";
		push <= '0';
		stall_finished <= '0';		--pop = '0';
	end if;

	
	
	if(move_and_en(15 downto 12) = "1110")then --return
		pop <= '1';
		
			int_mode <= '0';
			jmp_mode <= '0';

	else
		pop <= '0';
		if(stall_ready = '1' and stall_cnt_in ="11")then 
			if (int /= "0000")then
				int_mode <= '1';
				jmp_mode <= '0';
			else 
				jmp_mode <= '1';
				int_mode <= '0';
			end if;
		end if;
	end if;
		
	
end if;

end process;


ProgramCounter: entity work.ProgramCounter
port map(
			clk => clk,
			addr => addr,
			writeEnable => writeEnable,
			count => count,
			en => en_fetch
);

InterruptController: entity work.InterruptController_fetch 
port map ( 	clk => clk,
			int => int,
			addr => int_addr,
			int_stack_push => tpush,
			int_stack_pop => tpop,
			stall_ready => stall_ready,
			stall_finished => stall_finished,
			inst => inst,
			writeEnable => int_writeEnable
			);
			
			
			
move <= move_and_en(11 downto 0);
PCMux: entity work.mux_4to1
generic map( width => 12)
port map(
	SEL  => SEL,
	IN_1 => outp,
	IN_2 => int_addr,
	IN_3 => move,
	IN_4 => reset,
	MOUT => addr
	);
	
	

PCstack: entity work.PCstack
generic map( width => 12)
port map(
		  input => count,
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
			input => latch_input,
			en => en_fetch,
			output => output
			);

end Behavioral;