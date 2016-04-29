--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   06:20:57 04/29/2016
-- Design Name:   
-- Module Name:   /home/bobby/UMDRISC_P1/Testbenches/optest.vhd
-- Project Name:  r3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Operand_top
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
 
ENTITY optest IS
END optest;
 
ARCHITECTURE behavior OF optest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Operand_top
    PORT(
         clk : IN  std_logic;
         RE : IN  std_logic;
         WE : IN  std_logic;
         int_mode : IN  std_logic;
         jmp_mode : IN  std_logic;
         S_en : IN  std_logic;
         S_write : IN  std_logic;
         S_Read : IN  std_logic;
         s_addr : IN  std_logic_vector(1 downto 0);
         s_id : IN  std_logic_vector(1 downto 0);
         RA_addr : IN  std_logic_vector(3 downto 0);
         RB_addr : IN  std_logic_vector(3 downto 0);
         Write_Back : IN  std_logic_vector(15 downto 0);
         Writeback_Addr : IN  std_logic_vector(3 downto 0);
         RA_data_latch : OUT  std_logic_vector(15 downto 0);
         RB_data_latch : OUT  std_logic_vector(15 downto 0);
         S_out_latch : OUT  std_logic_vector(15 downto 0);
         operand_op_latch : OUT  std_logic_vector(3 downto 0);
         op : IN  std_logic_vector(3 downto 0);
         Imm : IN  std_logic_vector(3 downto 0);
         run : IN  std_logic;
         Debug_address : IN  std_logic_vector(11 downto 0);
         Core_Debug : OUT  std_logic_vector(15 downto 0);
         en_operand : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal RE : std_logic := '0';
   signal WE : std_logic := '0';
   signal int_mode : std_logic := '0';
   signal jmp_mode : std_logic := '0';
   signal S_en : std_logic := '0';
   signal S_write : std_logic := '0';
   signal S_Read : std_logic := '0';
   signal s_addr : std_logic_vector(1 downto 0) := (others => '0');
   signal s_id : std_logic_vector(1 downto 0) := (others => '0');
   signal RA_addr : std_logic_vector(3 downto 0) := (others => '0');
   signal RB_addr : std_logic_vector(3 downto 0) := (others => '0');
   signal Write_Back : std_logic_vector(15 downto 0) := (others => '0');
   signal Writeback_Addr : std_logic_vector(3 downto 0) := (others => '0');
   signal op : std_logic_vector(3 downto 0) := (others => '0');
   signal Imm : std_logic_vector(3 downto 0) := (others => '0');
   signal run : std_logic := '1';
   signal Debug_address : std_logic_vector(11 downto 0) := (others => '0');
   signal en_operand : std_logic := '1';

 	--Outputs
   signal RA_data_latch : std_logic_vector(15 downto 0);
   signal RB_data_latch : std_logic_vector(15 downto 0);
   signal S_out_latch : std_logic_vector(15 downto 0);
   signal operand_op_latch : std_logic_vector(3 downto 0);
   signal Core_Debug : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Operand_top PORT MAP (
          clk => clk,
          RE => RE,
          WE => WE,
          int_mode => int_mode,
          jmp_mode => jmp_mode,
          S_en => S_en,
          S_write => S_write,
          S_Read => S_Read,
          s_addr => s_addr,
          s_id => s_id,
          RA_addr => RA_addr,
          RB_addr => RB_addr,
          Write_Back => Write_Back,
          Writeback_Addr => Writeback_Addr,
          RA_data_latch => RA_data_latch,
          RB_data_latch => RB_data_latch,
          S_out_latch => S_out_latch,
          operand_op_latch => operand_op_latch,
          op => op,
          Imm => Imm,
          run => run,
          Debug_address => Debug_address,
          Core_Debug => Core_Debug,
          en_operand => en_operand
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
		
		
		
		RE <= '1';
		run <= '1';
      wait for 100 ns;	
		Write_back <= x"0201";
		wait for clk_period;
		WE <= '1';
      wait for clk_period;
		Writeback_Addr <= x"2";
		wait for clk_period;
		RB_addr <= x"2";
      -- insert stimulus here 

      wait;
   end process;

END;
