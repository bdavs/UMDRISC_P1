--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:51:32 03/30/2016
-- Design Name:   
-- Module Name:   /home/dan/DanUMDRISC/TheTestBench.vhd
-- Project Name:  DanUMDRISC
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TopLevel
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
 
ENTITY TheTestBench IS
END TheTestBench;
 
ARCHITECTURE behavior OF TheTestBench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TopLevel
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
			int : IN std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
	signal int : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TopLevel PORT MAP (
          clk => clk,
          rst => rst,
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
      wait for 100 ns;	
		int(0) <= '0';
      wait for period*10;
		

      -- insert stimulus here 

      wait;
   end process;

END;
