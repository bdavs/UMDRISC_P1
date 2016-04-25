---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Engineer: Daniel Noyes
-- 
-- Create Date:    SPRING 2015
-- Module Name:    ALU_Toplevel
-- Project Name:   ALU
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
-- Description: ALU top level
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.all;

entity ALU is
    Port ( CLK      : in  STD_LOGIC;
           RA       : in  STD_LOGIC_VECTOR (15 downto 0);
           RB       : in  STD_LOGIC_VECTOR (15 downto 0);
			  S_ID	:in std_logic_vector(1 downto 0);
			  S_addr	:in  std_logic_vector(1 downto 0);
			  S_addr_latch :out  std_logic_vector(1 downto 0);
			  S_id_latch :out  std_logic_vector(1 downto 0);
			  S_out_latch       : in  STD_LOGIC_VECTOR (15 downto 0);
           OPCODE   : in  STD_LOGIC_VECTOR (3 downto 0);
           CCR      : out STD_LOGIC_VECTOR (3 downto 0);
           ALU_OUT  : out STD_LOGIC_VECTOR (15 downto 0);
           LDST_OUT : out STD_LOGIC_VECTOR (15 downto 0);
			  EXT_OUT : out STD_LOGIC_VECTOR (15 downto 0));
end ALU;

architecture Structural of ALU is

    signal arith     : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
	 signal vector     : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
	 signal Shadow     : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
	 	 signal external     : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
    signal logic     : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
    signal shift     : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
	 signal move      : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
    signal memory    : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
	 signal ccr_move : STD_LOGIC_VECTOR (3 downto 0) := (OTHERS => '0');
    signal ccr_arith : STD_LOGIC_VECTOR (3 downto 0) := (OTHERS => '0');
    signal ccr_logic : STD_LOGIC_VECTOR (3 downto 0) := (OTHERS => '0');
	signal LDST_OUT_M     : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0'); 
	 signal LDST_address    : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0'); 
	 signal ALU_OUT_tmp     : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
	  signal EXT_OUT_tmp     : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
	  signal LDST_OUT_tmp     : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
	 signal ccr_tmp     : STD_LOGIC_VECTOR (3 downto 0) := (OTHERS => '0');

	 
	 signal br_en     : STD_LOGIC := '0';

begin

    --LDST_OUT <= memory;
	 Vector_Unit: entity work.Vector_Unit
    port map( A      => RA,
              B      => RB,
				  Shadow_data=>S_out_latch,
              OP     => OPCODE,
					ID=>S_ID,
              RESULT => shadow,
				  Result2 =>vector,
				  result3=>external );
    Arith_Unit: entity work.Arith_Unit
    port map( A      => RA,
              B      => RB,
              OP     => OPCODE(2 downto 0),
              CCR    => ccr_arith,
              RESULT => arith);

    Logic_Unit: entity work.Logic_Unit
    port map( A      => RA,
              B      => RB,
              OP     => OPCODE(2 downto 0),
              CCR    => ccr_logic,
              RESULT => logic);

    shift_unit: entity work.alu_shift_unit
    port map( A      => RA,
              COUNT  => RB(2 downto 0),
              OP     => opcode(3),
              RESULT => shift);

    Load_Store_Unit: entity work.Load_Store_Unit
    port map( CLK    => CLK,
              A      => RA,
              IMMED  => RB,
              OP     => opcode,
              RESULT => memory,
				  result2=>ldst_address);
	 Movement_Unit: entity work.Movement_Unit
    port map( CLK    => CLK,
              Ra      => RA,
              Rb  => RB,
              OP     => opcode,
				  ccr_move => ccr_move,
              RESULT => move);

    ALU_Mux: entity work.ALU_Mux
    port map( OP        => opcode,
              ARITH     => arith,
              LOGIC     => logic,
              SHIFT     => shift,
              MEMORY    => memory,
				  Vector=>vector,
				  Shadow=>Shadow,
				  external=>external,
				  ldst_address=>ldst_address,
				  MOVE	   => move,
				  CCR_MOVE  => ccr_move,
              CCR_ARITH => ccr_arith,
              CCR_LOGIC => ccr_logic,
              ALU_OUT   => ALU_OUT_tmp,
				  EXT_OUT   => EXT_OUT_tmp,
				  LDST_OUT   => LDST_OUT_tmp,
              CCR_OUT   => CCR_tmp);
				  
	alu_out_latch: entity work.reg
	generic map (n => 16)
	port map(
			clk => clk,
			input => ALU_OUT_tmp,
			en => '1',
			output => ALU_OUT);
			
	ext_out_latch: entity work.reg
	generic map (n => 16)
	port map(
			clk => clk,
			input => EXT_OUT_tmp,
			en => '1',
			output => EXT_OUT);
			
	
	ccr_latch: entity work.reg
	generic map (n => 4)
	port map(
			clk => clk,
			input => ccr_tmp,
			en => '1',
			output => CCR);
	
	
			
--ldst_out_mux: entity work.mux_2to1
--generic map(width => 16)
--port map(
--			SEL => '1',
--			IN_1 => memory,
--			IN_2 => LDST_OUT_tmp,
--			MOUT => LDST_OUT_M

			
			
	ldst_out_latch: entity work.reg
	generic map (n => 16)
	port map(
			clk => clk,
			input => LDST_OUT_tmp,
			en => '1',
			output => LDST_OUT);
			
			
	Saddr_latch: entity work.reg
	generic map (n => 2)
	port map(
			clk => clk,
			input => S_addr,
			en => '1',
			output => S_addr_latch);
	
	Sid_latch: entity work.reg
	generic map (n => 2)
	port map(
			clk => clk,
			input => S_id,
			en => '1',
			output => S_id_latch);
			

	end Structural;

