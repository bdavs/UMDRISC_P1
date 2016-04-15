--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:14:51 04/08/2016
-- Design Name:   
-- Module Name:   /home/bobby/UMDRISC_P1/Testbenches/PCstack_tb.vhd
-- Project Name:  r2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PCstack
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
 
ENTITY PCstack_tb IS
END PCstack_tb;
 
ARCHITECTURE behavior OF PCstack_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PCstack
    PORT(
         input : IN  std_logic_vector(11 downto 0);
         output : OUT  std_logic_vector(11 downto 0);
         push : IN  std_logic;
         pop : IN  std_logic;
         clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal input : std_logic_vector(11 downto 0) := (others => '0');
   signal push : std_logic := '0';
   signal pop : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal output : std_logic_vector(11 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PCstack PORT MAP (
          input => input,
          output => output,
          push => push,
          pop => pop,
          clk => clk
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

      wait for clk_period/2;
		input <= x"123";
		push <= '1';
		wait for clk_period;
		input <= x"210";
		push <= '1';
		wait for clk_period;
		input <= x"F10";
		push <= '1';
		
		wait for clk_period;		
		input <= x"111";
		push <= '0';
		wait for clk_period;		
		input <= x"111";
		pop <= '1';
		wait for clk_period*10;
      -- insert stimulus here 

      wait;
   end process;

END;
