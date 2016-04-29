----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:14:18 03/25/2016 
-- Design Name: 
-- Module Name:    TopLevel - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TopLevel is
port(	clk : in std_logic;
		rst : in std_logic;
		int : in std_logic_vector( 3 downto 0);
		wdata: in std_logic;
		Stage: in std_logic_vector(2 downto 0);
		data: in std_logic_vector(15 downto 0);
		address: in std_logic_vector(11 downto 0);
		Debug_data : out std_logic_vector(15 downto 0)
);	
end TopLevel;

architecture Behavioral of TopLevel is

signal addr: std_logic_vector(11 downto 0)  := (others => '0');
signal writeEnable : std_logic := '0';

signal t1, t2, t3, t4, t5: std_logic_vector (15 downto 0):= (others => '0');

signal inst : std_logic_vector(15 downto 0):= (others => '0'); 
signal inst_latch : std_logic_vector(15 downto 0):= (others => '0'); 

signal run:  std_logic;
signal branch:  std_logic;
signal op : std_logic_vector(3 downto 0):= (others => '0'); 
signal operand_op_latch : std_logic_vector(3 downto 0):= (others => '0'); 


signal RA_addr : std_logic_vector(3 downto 0):= (others => '0');
signal RA_data : std_logic_vector(15 downto 0):= (others => '0');
signal A : std_logic_vector(15 downto 0):= (others => '0');

signal Writeback_Addr : std_logic_vector(3 downto 0):= (others => '0');
signal Write_back : std_logic_vector(15 downto 0):= (others => '0');

signal wea: std_logic_vector( 0 downto 0):=(others => '0'); 
signal ext_wea: std_logic_vector( 0 downto 0):=(others => '0'); 

signal S_en : std_logic := '1';
signal S_write : std_logic := '1';
signal S_read : std_logic := '1';
signal S_out_latch : std_logic_vector(15 downto 0):= (others => '0');
signal external_address : std_logic_vector(15 downto 0):= (others => '0');
signal S_id : std_logic_vector(1 downto 0):= (others => '0');
signal S_id_latch : std_logic_vector(1 downto 0):= (others => '0');
signal S_addr : std_logic_vector(1 downto 0):= (others => '0');
signal S_addr_latch : std_logic_vector(1 downto 0):= (others => '0');
signal S_out : std_logic_vector(15 downto 0):= (others => '0');


signal RB_addr : std_logic_vector(3 downto 0):= (others => '0');
signal RB_data : std_logic_vector(15 downto 0):= (others => '0');
signal B : std_logic_vector(15 downto 0):= (others => '0');
signal Imm_w : std_logic_vector(3 downto 0):= (others => '0');

signal en_fetch : std_logic := '1';
signal en_decode : std_logic := '1';
signal en_pipeline : std_logic := '1';
signal en_operand : std_logic := '1';
signal en_Writeback: std_logic := '1';

signal Write_Addr_sel: std_logic := '0';

signal en_Execute:  std_logic;
signal ext_addr_en:  std_logic;
signal lwvd_en:  std_logic:='0';

--signal en_execute:  std_logic;

--signal en_Execute:  std_logic;
--signal ext_addr_en:  std_logic;
--signal lwvd_en:  std_logic;


signal operand_read : std_logic := '1';
signal operand_write : std_logic := '0';
signal operand_write_addr : std_logic_vector(3 downto 0):= (others => '0');

signal data_in : std_logic_vector(15 downto 0):= (others => '0');

signal ccr: std_logic_vector(3 downto 0):= (others => '0');

signal execute_alu_out: std_logic_vector(15 downto 0):= (others => '0');
signal execute_ldst_out: std_logic_vector(15 downto 0):= (others => '0');
signal EXT_OUT: std_logic_vector(15 downto 0):= (others => '0');

signal RE: std_logic:='0'; 
signal WE: std_logic:='0'; 
signal en_writeback_ctrl: std_logic:='0';

signal int_mode: std_logic:='0'; 
signal jmp_mode: std_logic:='0';

signal move: std_logic_vector(15 downto 0);

signal br_stall: std_logic:='0';


signal Stage1: std_logic_vector(15 downto 0);
signal Core_Debug: std_logic_vector(15 downto 0);
signal Stage2: std_logic_vector(15 downto 0);
signal Data_mem_Debug: std_logic_vector(15 downto 0);
signal Stage3: std_logic_vector(15 downto 0);
signal Stage4: std_logic_vector(15 downto 0);
signal Stage5: std_logic_vector(15 downto 0);
signal DataDump: std_logic_vector(15 downto 0);
signal ROM_Debug_signal:std_logic_vector(15 downto 0);
signal Debug_selector: std_logic_vector(2 downto 0);
begin

--Debug Mux
--Debug_selector <= instrDMP & coreDMP & dataDMP;
with Stage select
Debug_data <= 
	Stage1 when "000", 
	Stage2 when "001", 
	Stage3 when "010", 
	Stage4 when "011",
	Stage5 when "100",
	DataDump when "101", 
	x"ECE3" when others; --bad input

Stage5 <= Write_back;
Stage4 <= execute_alu_out;
Stage3 <= A(7 downto 0) & B(7 downto 0);
Stage2 <= x"add" & RA_addr;
Stage1 <= inst;

with Stage select
run <=
	'0' when "101",
	'1' when others;

junk_stuff: entity work.stuff
port map(
			clk => clk,
			move => move,
			execute_alu_out => execute_alu_out,
			branch => branch,
			t5 => t5,
			t4 => t4,
			A => A,
			B => B,
			RA_data => RA_Data,
			RB_data => RB_Data,
			op => op,
			t3 => t3,
			ccr => ccr
			);
			
fetch: entity work.fetch_toplevel
port map(
			clk => clk,
			int => int,
			rst => rst,
			int_mode => int_mode,
			jmp_mode => jmp_mode,

			branch => branch,
			move_and_en => move,
			en_fetch => en_fetch,
			output => inst,
			run => run,
			Debug_address => address,
			ROM_Debug => ROM_Debug_signal
			);

Decode_top_level: entity work.Decode_top			
port map(	clk => clk,
		inst => inst,
		op_latch => op,
		Imm_latch => Imm_w,
		RA_addr_latch => RA_addr,
		RB_addr_latch => RB_addr,
		S_id_latch=>S_id,
		S_addr_latch=>S_addr,
		en_decode=>en_decode
);	


operand_top_level: entity work.Operand_top
port map(	clk => clk,
		RE => RE,
		WE => WE,
		RA_addr => RA_addr,
		RB_addr =>RB_addr,
		int_mode => int_mode,
		jmp_mode => jmp_mode,
		S_en =>S_en, 
		S_write => S_write,
		S_Read=>S_read,
		S_id=>S_id,
		S_addr=>S_addr,
		S_out_latch=>S_out_latch,
		Writeback_Addr =>Writeback_Addr,
		--execute_alu_out  =>execute_alu_out,
		RA_data_latch =>RA_data,
		RB_data_latch =>RB_data,
		operand_op_latch =>operand_op_latch,
		Imm =>Imm_w,
		Write_Back =>Write_back,
		op => op,
		en_operand  =>	en_operand,
		run => run,
		Debug_address => address,
		Core_Debug => Core_Debug
		);
	

execute: entity work.ALU
port map(  CLK => clk,
           RA  => A,
           RB  => B,
			  S_out_latch=>S_out_latch,
           OPCODE  =>operand_op_latch,
           CCR => ccr,
			  S_ID=>s_id,
			  S_addr=>S_addr,
           ALU_OUT  => execute_alu_out,
			  EXT_OUT=>EXT_OUT,
           LDST_OUT => execute_ldst_out,
			  en_execute => en_execute

);
	
Write_Back_Stage: entity work.WriteBack
Port map(clk =>clk,
           execute_alu_out_latch => execute_alu_out,
           execute_ldst_out_latch =>execute_ldst_out,
			  en_Writeback => en_Writeback,
			  external_address=>EXT_OUT,
			  Write_back =>Write_back,
				wea=>wea,
				RA_addr=>t5(11 downto 8),
				lwvd_en=>lwvd_en,
				s_en=>S_en,
				S_id_latch=>S_id,
				S_addr_latch=>S_addr,
				writeback_address=>writeback_addr,
				ext_wea=>ext_wea,
				Write_Addr_sel=>Write_Addr_sel,
				en_writeback_ctrl=>en_writeback_ctrl,
				Debug_address => address,
				run => run,
				Debug_Data => DataDump,
				ext_addr_en=>ext_addr_en

				--en_write_back => en_Writeback
			  );
			
	
	
pipline: entity work.PipelineController
port map (
			 clk => clk,
			 en => en_pipeline,
			 input => inst,
			 t1 => t1,
			 t2 => t2,
			 t3 => t3,
			 t4 => t4,
			 t5 => t5
			 );

		
ControlModules_top: entity work.ControlModules
port map(clk => clk,
			op => operand_op_latch,
			ccr => ccr,
			RE => RE,
			WE => WE,
			t1 => t1,
			run => run,
			 t2 => t2,
			 t3 => t3,
			 t4 => t4,
			 t5 => t5,
			 wea=>wea,
			 ext_wea=>ext_wea,
			 --en_writeback=>en_Writeback,
			 S_en =>S_en ,
			 ID=>S_id,
			S_write =>S_write ,


			ext_addr_en=>ext_addr_en,
			S_Read =>S_read,
			lwvd_en=>lwvd_en,

			--S_Read =>S_read,

			--ext_addr_en=>ext_addr_en,
			--S_Read =>S_read,
			--lwvd_en=>lwvd_en,

			en_fetch => en_fetch,
			en_decode => en_decode,
			en_pipeline => en_pipeline,
			en_operand => en_operand,
			en_Writeback => en_Writeback,
			en_execute => en_execute

			);

			

end Behavioral;

