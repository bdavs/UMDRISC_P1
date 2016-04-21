--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:45:16 04/17/2016
-- Design Name:   
-- Module Name:   Z:/368/UMDRisc/execute_tb.vhd
-- Project Name:  UMDRisc
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ALU
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
 
ENTITY execute_tb IS
END execute_tb;
 
ARCHITECTURE behavior OF execute_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         CLK : IN  std_logic;
         RA : IN  std_logic_vector(15 downto 0);
         RB : IN  std_logic_vector(15 downto 0);
         S_out_latch : IN  std_logic_vector(15 downto 0);
         OPCODE : IN  std_logic_vector(3 downto 0);
         CCR : OUT  std_logic_vector(3 downto 0);
         ALU_OUT : OUT  std_logic_vector(15 downto 0);
         LDST_OUT : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RA : std_logic_vector(15 downto 0) := (others => '0');
   signal RB : std_logic_vector(15 downto 0) := (others => '0');
   signal S_out_latch : std_logic_vector(15 downto 0) := (others => '0');
   signal OPCODE : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal CCR : std_logic_vector(3 downto 0);
   signal ALU_OUT : std_logic_vector(15 downto 0);
   signal LDST_OUT : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          CLK => CLK,
          RA => RA,
          RB => RB,
          S_out_latch => S_out_latch,
          OPCODE => OPCODE,
          CCR => CCR,
          ALU_OUT => ALU_OUT,
          LDST_OUT => LDST_OUT
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;
		--Data Memory
		opcode<="1010";
		RA<="0000000011111111";
		RB<="1111111100000000";
		S_out_latch<="1111111111111111";
		assert(ALU_out="0000000011111111");
		assert(LDST_OUT="1111111100000000");
		
		wait for CLK_period*20;
		--SWV 
		opcode<="1100";
		RA<="1010101010101010";
		assert(ALU_out="1010101010101010");
		assert(LdsT_OUT="011111111011111111");
		
		wait for CLK_period*20;
		--LW
		opcode<="1001";
		RA<="1010101010101111";
		RB<="0000000000000000";
		S_out_latch<="1111111111111111";
		--assert(ALU_out="1010101010101010");
		assert(LdsT_OUT="0000000000000000");
       
			wait for CLK_period*20;
		--LWV
		opcode<="1011";
		RA<="1010101010101111";
		RB<="0000000000000001";
		S_out_latch<="1111111111111111";
		--assert(ALU_out="1010101010101010");
		assert(LdsT_OUT="1111111111111111");

      wait;
   end process;

END;
