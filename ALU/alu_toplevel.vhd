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
           OPCODE   : in  STD_LOGIC_VECTOR (3 downto 0);
           CCR      : out STD_LOGIC_VECTOR (3 downto 0);
           ALU_OUT  : out STD_LOGIC_VECTOR (19 downto 0);
           LDST_OUT : out STD_LOGIC_VECTOR (15 downto 0));
end ALU;

architecture Structural of ALU is

    signal arith     : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
	 signal vector     : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
    signal logic     : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
    signal shift     : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
	 signal move      : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
    signal memory    : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
	 signal ccr_move : STD_LOGIC_VECTOR (3 downto 0) := (OTHERS => '0');
    signal ccr_arith : STD_LOGIC_VECTOR (3 downto 0) := (OTHERS => '0');
    signal ccr_logic : STD_LOGIC_VECTOR (3 downto 0) := (OTHERS => '0');
	 signal ALU_OUT_tmp     : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
	
	 signal br_en     : STD_LOGIC := '0';

begin

    --LDST_OUT <= memory;
	   Vector_Unit: entity work.Vector_Unit
    port map( A      => RA,
              B      => RB,
              OP     => OPCODE,
            
              RESULT => vector);
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
              RESULT => memory);
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
				  MOVE	   => move,
				  CCR_MOVE  => ccr_move,
              CCR_ARITH => ccr_arith,
              CCR_LOGIC => ccr_logic,
              ALU_OUT   => ALU_OUT_tmp,
              CCR_OUT   => CCR);
				  
	alu_out_latch: entity work.reg
	generic map (n => 16)
	port map(
			clk => clk,
			input => ALU_OUT_tmp,
			en => '1',
			output => ALU_OUT);
			
	ldst_out_latch: entity work.reg
	generic map (n => 16)
	port map(
			clk => clk,
			input => memory,
			en => '1',
			output => LDST_OUT);
			
			

	end Structural;

