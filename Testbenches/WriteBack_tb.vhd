--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:12:44 04/15/2016
-- Design Name:   
-- Module Name:   Z:/UMDRISC_P1/Testbenches/WriteBack_tb.vhd
-- Project Name:  UMDRisc
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: WriteBack
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
 
ENTITY WriteBack_tb IS
END WriteBack_tb;
 
ARCHITECTURE behavior OF WriteBack_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT WriteBack
    PORT(
         clk : IN  std_logic;
         execute_alu_out_latch : IN  std_logic_vector(15 downto 0);
         execute_ldst_out_latch : IN  std_logic_vector(15 downto 0);
         en_Writeback : IN  std_logic;
         wea : IN  std_logic_vector(0 downto 0);
         ext_wea : IN  std_logic_vector(0 downto 0);
         S_en : IN  std_logic;
         Write_back : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal execute_alu_out_latch : std_logic_vector(15 downto 0) := (others => '0');
   signal execute_ldst_out_latch : std_logic_vector(15 downto 0) := (others => '0');
   signal en_Writeback : std_logic := '0';
   signal wea : std_logic_vector(0 downto 0) := (others => '0');
   signal ext_wea : std_logic_vector(0 downto 0) := (others => '0');
   signal S_en : std_logic := '0';

 	--Outputs
   signal Write_back : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: WriteBack PORT MAP (
          clk => clk,
          execute_alu_out_latch => execute_alu_out_latch,
          execute_ldst_out_latch => execute_ldst_out_latch,
          en_Writeback => en_Writeback,
          wea => wea,
          ext_wea => ext_wea,
          S_en => S_en,
          Write_back => Write_back
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
--Data Memory Test
     wait for clk_period*10;
	execute_alu_out_latch <= "0000000000000011";
	execute_ldst_out_latch<="0000000000000000";
	wea<="1";
	ext_wea<="0";
	S_en<='0';
	en_Writeback<='1';
	assert (Write_back= "00000000000000011")  report "Failed op" ;
		
	wait for clk_period*10;
	execute_alu_out_latch <= "1000000000000011";
	execute_ldst_out_latch<="0000000000001111";
	wea<="0";
	en_Writeback<='1';
	S_en<='1';
	 
	 
	 wait for clk_period*10;
	 wea<="0";
	 execute_alu_out_latch <= "1100000000000011";
	execute_ldst_out_latch<="0000000000001111";
	assert (Write_back= "10000000000000011")  report "Failed op" ;
	en_Writeback<='1';
      -- insert stimulus here 

	wait for clk_period*10;
	wea<="0";
	execute_alu_out_latch <= "0000000000000000";
	execute_ldst_out_latch<="0000000000000000";
	assert (Write_back= "10000000000000011")  report "Failed op" ;
	en_Writeback<='1';
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
      wait;
   end process;


END;
