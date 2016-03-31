----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:56:49 03/30/2016 
-- Design Name: 
-- Module Name:    RegBankCMD - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegBankCMD is
    Port ( Writeback_Data : buffer  STD_LOGIC_VECTOR (15 downto 0);
           Writeback_Addr : buffer  STD_LOGIC_VECTOR (3 downto 0);
           WE : out  STD_LOGIC;
           RE : out  STD_LOGIC);
end RegBankCMD;

architecture Behavioral of RegBankCMD is

begin



end Behavioral;

