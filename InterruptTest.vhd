--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:33:19 04/09/2016
-- Design Name:   
-- Module Name:   /home/dan/otherDanUMDRISC/InterruptTest.vhd
-- Project Name:  otherDanUMDRISC
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: InterruptController_fetch
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
 
ENTITY InterruptTest IS
END InterruptTest;
 
ARCHITECTURE behavior OF InterruptTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT InterruptController_fetch
    PORT(
         clk : IN  std_logic;
         int : IN  std_logic_vector(3 downto 0);
         addr : OUT  std_logic_vector(15 downto 0);
         pc_count : IN  std_logic_vector(15 downto 0);
         inst : IN  std_logic_vector(15 downto 0);
         writeEnable : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal int : std_logic_vector(3 downto 0) := (others => '0');
   signal pc_count : std_logic_vector(15 downto 0) := (others => '0');
   signal inst : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal addr : std_logic_vector(15 downto 0);
   signal writeEnable : std_logic;

   -- Clock period definitions
   constant period : time := 5 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: InterruptController_fetch PORT MAP (
          clk => clk,
          int => int,
          addr => addr,
          pc_count => pc_count,
          inst => inst,
          writeEnable => writeEnable
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
		inst <= x"000E";

      -- insert stimulus here 

      wait;
   end process;

END;
