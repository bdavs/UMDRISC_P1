--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:08:06 03/29/2016
-- Design Name:   
-- Module Name:   /home/dan/Lab4/PipeTest.vhd
-- Project Name:  Lab4
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PipelineController
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
USE ieee.STD_LOGIC_1164.ALL;
USE ieee.STD_LOGIC_unsigned.all;
USE ieee.numeric_std.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY PipeTest IS
END PipeTest;
 
ARCHITECTURE behavior OF PipeTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PipelineController
    PORT(
         clk : IN  std_logic;
         input : IN  std_logic_vector(15 downto 0);
         en : IN  std_logic;
         t1 : OUT  std_logic_vector(15 downto 0);
         t2 : OUT  std_logic_vector(15 downto 0);
         t3 : OUT  std_logic_vector(15 downto 0);
         t4 : OUT  std_logic_vector(15 downto 0);
         t5 : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal input : std_logic_vector(15 downto 0) := (others => '0');
   signal en : std_logic := '1';

 	--Outputs
   signal t1 : std_logic_vector(15 downto 0);
   signal t2 : std_logic_vector(15 downto 0);
   signal t3 : std_logic_vector(15 downto 0);
   signal t4 : std_logic_vector(15 downto 0);
   signal t5 : std_logic_vector(15 downto 0);

   -- Clock period definitions
    constant period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PipelineController PORT MAP (
          clk => clk,
          input => input,
          en => en,
          t1 => t1,
          t2 => t2,
          t3 => t3,
          t4 => t4,
          t5 => t5
        );

   -- Clock process definitions
    gen_Clock: process
    begin
        CLK <= '0'; wait for period;
        CLK <= '1'; wait for period;
    end process gen_Clock;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		en <= '0';
      wait for 100 ns;	
		en <= '1';
		input <= "0000000000000000"; wait for period;wait for period;
		assert (t1 = "0000000000000000")  report "Failed at t1"; 
		input <= "0000000000000001"; wait for period;wait for period;
		assert (t1 = "0000000000000001")  report "Failed at t1";
		assert (t2 = "0000000000000000")  report "Failed at t2";
		input <= "0000000000000011"; wait for period;wait for period;
		assert (t1 = "0000000000000011")  report "Failed at t1";
		assert (t2 = "0000000000000001")  report "Failed at t2";
		assert (t3 = "0000000000000000")  report "Failed at t3";
		input <= "0000000000000111"; wait for period;wait for period;
		assert (t1 = "0000000000000111")  report "Failed at t1";
		assert (t2 = "0000000000000011")  report "Failed at t2";
		assert (t3 = "0000000000000001")  report "Failed at t3";
		assert (t4 = "0000000000000000")  report "Failed at t4";
		input <= "0000000000001111"; wait for period;wait for period;
		assert (t1 = "0000000000001111")  report "Failed at t1";
		assert (t2 = "0000000000000111")  report "Failed at t2";
		assert (t3 = "0000000000000011")  report "Failed at t3";
		assert (t4 = "0000000000000001")  report "Failed at t4";
		assert (t5 = "0000000000000000")  report "Failed at t5";
      wait for period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
