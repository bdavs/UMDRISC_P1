--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:15:37 03/30/2016
-- Design Name:   
-- Module Name:   /home/dan/Lab4/fetch_tb.vhd
-- Project Name:  Lab4
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: fetch_toplevel
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY fetch_tb IS
END fetch_tb;
 
ARCHITECTURE behavior OF fetch_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fetch_toplevel
    port( clk: in std_logic;
		en_fetch: in std_logic;
		int: in std_logic_vector (3 downto 0);
		output: out std_logic_vector(15 downto 0));
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
	signal int: std_logic_vector (3 downto 0) := "0000";
	signal en_fetch: std_logic:= '1';

 	--Outputs
   signal output : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fetch_toplevel PORT MAP (
          clk => clk,
			 en_fetch => en_fetch,
          output => output,
			 int => int
        );

   -- Clock process definitions
   gen_Clock: process
    begin
        clk <= '0'; wait for period;
        clk <= '1'; wait for period;
    end process gen_Clock;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 1 ns;	
		int(0) <= '1';
      wait for period*20;
		int(0) <= '0';
		wait for period*20;
		

      -- insert stimulus here 

      wait;
   end process;

END;
