----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:47:11 04/08/2016 
-- Design Name: 
-- Module Name:    InterruptController_fetch - Behavioral 
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

entity InterruptController_fetch is
port( 	clk: in std_logic;
			int: in std_logic_vector(3 downto 0);
			int_stack_push: buffer std_logic := '0';
			int_stack_pop: buffer std_logic := '0';
			addr: out std_logic_vector(11 downto 0);
			inst: in std_logic_vector(15 downto 0);
			stall_ready: out std_logic := '0';
			stall_finished: in std_logic:='0';
			writeEnable: out std_logic
			);
end InterruptController_fetch;

architecture Behavioral of InterruptController_fetch is

signal interrupts_enabled : std_logic := '1';
--signal wait_complete: std_logic := '0';
--signal wait_ready: std_logic := '0';
--signal clock_wait : std_logic_vector(2 downto 0):= "100";
signal int_latch_en: std_logic := '1';
signal int_latch: std_logic_vector(3 downto 0);
signal return_found: std_logic := '0';
signal int_addr: std_logic_vector(11 downto 0);
signal stall_number: std_logic:='0';--used to figure out which stall we are on 0 or 1
signal stall_ready_internal: std_logic:='0';

--int stack signals


signal writeEnable_flag: std_logic:='0';
begin

process(CLK)
begin
	if(CLK'event and CLK = '1') then
		if(interrupts_enabled = '1') then
		--things to do once an interrupt is triggered
			if(int(0) = '1' or int(1) = '1' or int(2) = '1' or int(3) = '1') then
				interrupts_enabled <= '0';
				int_latch_en <= '0';
				--Push pc+1
				--int_stack_input <= pc_count + 1;
				int_stack_push <= '1';
				stall_ready <= '1';
				stall_ready_internal <= '1';
				stall_number <= '0';
				--Now we flush
			end if;
		else	
		--things to do during the interrupt
			--first stall finshed. Load interrupt vector
			if(stall_ready_internal = '1' and stall_finished = '1' and stall_number = '0')then
				stall_ready <= '0';
				stall_ready_internal <= '0';
				addr <= int_addr;
				writeEnable <= '1';
				writeEnable_flag <= '1';
				stall_number <= '1';
			end if;
			
			--return is found. signal second stall
			if(return_found = '1' and stall_number = '1')then
				stall_ready <= '1';
				stall_ready_internal <= '1';
			end if;
			
			--second stall finished. Pop interrupt stack
			if(stall_ready_internal = '1' and stall_finished = '1' and stall_number = '1')then
				stall_ready <= '0';
				stall_ready_internal <= '0';
				int_stack_pop <= '1';
			end if;
			
			if(inst = x"E000") then
				return_found <= '1';
			end if;
			
		end if;
		
		if(int_stack_push = '1')then
			int_stack_push <= '0';
		end if;
		
		if(int_stack_pop = '1')then
			int_stack_pop <= '0';
		end if;
		
		if(writeEnable_flag = '1') then
			writeEnable <= '0';
			writeEnable_flag <= '0';
		end if;
		
		--LEGACY CODE DO NOT MOVE.
		
--		if(interrupts_enabled ='0' and wait_ready ='1') then
--			if(clock_wait = "000")then
--				clock_wait <= "100";
--				wait_ready <= '0';
--				return_found <= '0';
--				wait_complete <= '1';
--				addr <= int_addr;
--				writeEnable <= '1';
--				writeEnable_flag <= '1';
--			else
--				clock_wait <= clock_wait - 1;
--				addr <= "ZZZZZZZZZZZZ"; --dont do this
--				writeEnable <= '1';
--			end if;
--		end if;
		
		--makes sure we never push or pop for more than a clock cycle
		
		
		--if(interrupts_enabled = '0' and wait_complete = '1' and (return_found = '1' or inst = x"E000")) then
			-- time to load addr
			--if(clock_wait = "000")then
				--clock_wait <= "100";
				--pop stack and give the addr to the PC
				--writeEnable <= '1';
				--addr <= int_stack_output;
				--return_found <= '0';
				--wait_complete <= '0';
				--writeEnable_flag <= '1';
				--interrupts_enabled <= '1';
				--int_latch_en <= '1';
			--elsif(clock_wait = "001") then
				--int_stack_pop <= '1';
				--clock_wait <= clock_wait - 1;
			--else
				--clock_wait <= clock_wait - 1;
				--addr <= "ZZZZZZZZZZZZ"; --dont do this
				--writeEnable <= '1';
			--end if;
		--end if;
		
		
		
	end if;
end process;

int_latch_unit: entity work.reg
generic map (n => 4)
port map(clk => clk,
			input => int,
			en => int_latch_en,
			output => int_latch);
			
with int_latch select
        int_addr <=
            "ZZZZZZZZZZZZ"   when x"0",     -- We should not let this signal go through
            x"F00"   when x"1",     -- INT 4 Vector location
            x"F20"   when x"2" to x"3",     -- INT 3 Vector location
           
            x"F40"   when x"4" to x"7",     -- INT 2 Vector location
            
            x"F60"   when x"8" to x"F",     -- INT 1 Vector location
            
            "ZZZZZZZZZZZZ"   when OTHERS;     -- This will not happen unless I can't count


end Behavioral;

