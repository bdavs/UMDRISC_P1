--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:12:33 03/29/2016
-- Design Name:   
-- Module Name:   /home/dan/Lab4/TestRAM.vhd
-- Project Name:  Lab4
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RegRAM
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
 
ENTITY TestRAM IS
END TestRAM;
 
ARCHITECTURE behavior OF TestRAM IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegRAM
    PORT(
         Clock : IN  std_logic;
         Enable : IN  std_logic;
         Read : IN  std_logic;
         Write : IN  std_logic;
         Read_AddrA : IN  std_logic_vector(3 downto 0);
         Read_AddrB : IN  std_logic_vector(3 downto 0);
         Write_AddrA : IN  std_logic_vector(3 downto 0);
         Data_inA : IN  std_logic_vector(15 downto 0);
         Data_outA : OUT  std_logic_vector(15 downto 0);
         Data_outB : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal Enable : std_logic := '0';
   signal Read : std_logic := '0';
   signal Write : std_logic := '0';
   signal Read_AddrA : std_logic_vector(3 downto 0) := (others => '0');
   signal Read_AddrB : std_logic_vector(3 downto 0) := (others => '0');
   signal Write_AddrA : std_logic_vector(3 downto 0) := (others => '0');
   signal Data_inA : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal Data_outA : std_logic_vector(15 downto 0);
   signal Data_outB : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegRAM PORT MAP (
          Clock => CLK,
          Enable => Enable,
          Read => Read,
          Write => Write,
          Read_AddrA => Read_AddrA,
          Read_AddrB => Read_AddrB,
          Write_AddrA => Write_AddrA,
          Data_inA => Data_inA,
          Data_outA => Data_outA,
          Data_outB => Data_outB
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
      wait for 100 ns;	

      -- insert stimulus here 
		
		Enable <= '1';
		Write_AddrA <= "0000";
		Data_inA <= "0000000000000011";
		Write <= '1';
		wait for period;
		Write <= '0';
		Read <= '1';
		Read_AddrA <= "0000"; wait for period;
		assert (Data_outA = "0000000000000011")  report "Failed at addr 0000"; 
		Write_AddrA <= "0001";
		Data_inA <= "0000000000000001";
		Write <= '1'; Read <= '0';
		wait for period;
		Write <= '0';
		Read <= '1';
		Read_AddrA <= "0000"; 
		Read_AddrB <= "0001"; 
		wait for period;
		assert (Data_outA = "0000000000000011")  report "Failed at addr 0000";
		assert (Data_outB = "0000000000000001")  report "Failed at addr 0001";
		
		
      wait;
   end process;

END;
