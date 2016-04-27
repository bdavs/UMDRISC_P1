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
			int : IN std_logic_vector(3 downto 0);
			wdata: in std_logic;
			run: in std_logic;
			dataDMP: in std_logic;
			coreDMP: in std_logic;
			instrDMP: in std_logic;
			data: in std_logic_vector(15 downto 0);
			address: in std_logic_vector(11 downto 0);
			Debug_data : out std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
	signal int : std_logic_vector(3 downto 0);
	signal wdata: std_logic;
	signal run: std_logic;
	signal dataDMP: std_logic;
	signal coreDMP: std_logic;
	signal instrDMP: std_logic;
	signal data: std_logic_vector(15 downto 0);
	signal address: std_logic_vector(11 downto 0);
	signal Debug_data : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TopLevel PORT MAP (
          clk => clk,
          rst => rst,
			 int => int,
			 wdata => wdata,
			run => run,
			dataDMP => dataDMP,
			coreDMP => coreDMP,
			instrDMP => instrDMP,
			data => data,
			address => address,
			Debug_data => Debug_data
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
      --wait for 100 ns;	
		run <= '1';
     
		

      -- insert stimulus here 

      wait;
   end process;

END;
