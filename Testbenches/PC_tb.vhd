--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:37:23 04/12/2016
-- Design Name:   
-- Module Name:   /home/bobby/UMDRISC_P1/Testbenches/PC_tb.vhd
-- Project Name:  r2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ProgramCounter
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
USE ieee.std_logic_unsigned.ALL;
USE ieee.std_logic_arith.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY PC_tb IS
END PC_tb;
 
ARCHITECTURE behavior OF PC_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ProgramCounter
    PORT(
         clk : IN  std_logic;
         addr : IN  std_logic_vector(11 downto 0);
         writeEnable : IN  std_logic;
         count : buffer  std_logic_vector(11 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal addr : std_logic_vector(11 downto 0) := (others => '0');
   signal writeEnable : std_logic := '0';

 	--Outputs
   signal count : std_logic_vector(11 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ProgramCounter PORT MAP (
          clk => clk,
          addr => addr,
          writeEnable => writeEnable,
          count => count
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
		writeEnable <= '0';
		addr <= x"F00";
      wait for clk_period*10;
		writeEnable <= '0';
		addr <= x"E00";
		wait for clk_period*10;
		writeEnable <= '1';
		addr <= x"D00";
		wait for clk_period/2;
		writeEnable <= '0';
		wait for clk_period*10;
		writeEnable <= '1';
		addr <= x"C00";
		wait for clk_period*10;
		writeEnable <= '0';
		addr <= x"B00";
		
		
		-- insert stimulus here 

      wait;
   end process;

END;
