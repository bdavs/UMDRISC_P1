--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:07:22 04/13/2016
-- Design Name:   
-- Module Name:   /home/bobby/UMDRISC_P1/Testbenches/fetch_tb.vhd
-- Project Name:  r2
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
use work.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY fetch_tb IS
END fetch_tb;
 
ARCHITECTURE behavior OF fetch_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fetch_toplevel
    PORT(
         clk : IN  std_logic;
         en_fetch : IN  std_logic;
         move_and_en : IN  std_logic_vector(15 downto 0);
         int : IN  std_logic_vector(3 downto 0);
         output : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal en_fetch : std_logic := '1';
   signal move_and_en : std_logic_vector(15 downto 0) := (others => '0');
   signal int : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fetch_toplevel PORT MAP (
          clk => clk,
          en_fetch => en_fetch,
          move_and_en => move_and_en,
          int => int,
          output => output
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
