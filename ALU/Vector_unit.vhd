----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:57:22 04/13/2016 
-- Design Name: 
-- Module Name:    Vector_unit - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Vector_Unit is
    Port ( A      : in  STD_LOGIC_VECTOR (15 downto 0);
           B      : in  STD_LOGIC_VECTOR (15 downto 0);
			  ID 		: in	STD_LOGIC_VECTOR (1 downto 0);
			  Shadow_data: in  STD_LOGIC_VECTOR (15 downto 0);
           OP     : in  STD_LOGIC_VECTOR (3 downto 0);
           RESULT : out STD_LOGIC_VECTOR  (15 downto 0);
			   RESULT2 : out STD_LOGIC_VECTOR  (15 downto 0);
				RESULT3 : out STD_LOGIC_VECTOR  (15 downto 0));
			 
end Vector_Unit;

architecture Combinational of Vector_Unit is

    signal a1, b1  : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
  signal vector : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
   signal Shadow : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');
	   signal external : STD_LOGIC_VECTOR (15 downto 0) := (OTHERS => '0');

begin
    -- Give extra bit to accound for carry,overflow,negative

    --a1 <= '0' & A;
    --b1 <= '0' & B;

    
process(OP)
	 begin
	 a1 <= A;
    b1 <= B;
if	(OP="1011" and ID="00") then --LWV
	shadow<=Shadow_data + b1;
end if;

if(OP="1011" and ID="01")then
shadow<=a1;
else if(OP="1011" and ID="11") then --LWVS
vector<=a1 + b1;
end if;
end if;

if(OP="1100" and ID="00")then --SWV
vector<=a1;
shadow<=Shadow_data + b1;
end if;   

if(OP="1100" and ID="01")then
external<=Shadow_data + b1;
shadow<=a1;
end if;





				
  
			
	

--    CCR(3) <= arith(7); -- Negative
--    CCR(2) <= '1' when arith(15 downto 0) = x"000000000000" else '0'; -- Zero
--    CCR(1) <= a1(15) xor arith(15); -- Overflow
--    CCR(0) <= arith(16); --Carry
	

end process; 
RESULT <= shadow;
REsult2 <=vector;
RESULT3<=external; 
end Combinational;

