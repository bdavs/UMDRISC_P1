--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:16:54 03/29/2016
-- Design Name:   
-- Module Name:   Z:/Project1/decode_tb.vhd
-- Project Name:  Project1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Decoder
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
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY decode_tb IS
END decode_tb;
 
ARCHITECTURE behavior OF decode_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decoder
    PORT(
         inst : IN  std_logic_vector(15 downto 0);
         clk : IN  std_logic;
         op : OUT  std_logic_vector(3 downto 0);
         RA : OUT  std_logic_vector(3 downto 0);
         RB : OUT  std_logic_vector(3 downto 0);
         Imm : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal inst : std_logic_vector(15 downto 0) := (others => '0');
   signal clk : std_logic := '0';

 	--Outputs
   signal op : std_logic_vector(3 downto 0);
   signal RA : std_logic_vector(3 downto 0);
   signal RB : std_logic_vector(3 downto 0);
   signal Imm : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decoder PORT MAP (
          inst => inst,
          clk => clk,
          op => op,
          RA => RA,
          RB => RB,
          Imm => Imm
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
		inst <= "0000000000000000";
      -- insert stimulus here 
		assert (op = "0000")  report "Failed op" ;
		assert (RA = "0000")  report "Failed RA" ;
		assert (RB = "0000")  report "Failed RB" ;
		assert (Imm = "0000")  report "Failed Imm" ;

		wait for clk_period*10;
		inst <= "0001001000110100";
		
		assert (op = "0001")  report "Failed op" ;
		assert (RA = "0010")  report "Failed RA" ;
		assert (RB = "0011")  report "Failed RB" ;
		assert (Imm = "0100")  report "Failed Imm" ;
		
		
      wait;
   end process;

END;
