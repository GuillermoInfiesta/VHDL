----------------------------------------------------------------------------------
-- Engineer: Guillermo Infiesta
-- 
-- Create Date: 16.04.2024 23:47:49
-- Module Name: BCD_conversor - Behavioral
-- Project Name: Minutes_seconds_counter
-- Target Devices: Basys 3
-- Description: This module converts a BCD input to a 7-segment output 
-- which will later be displayed in the FPGA board. 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BCD_7seg_conversor is
  Port ( 
    binary: in std_logic_vector(3 downto 0);
    seven_seg: out std_logic_vector(6 downto 0)
  );
end BCD_7seg_conversor;

architecture Behavioral of BCD_7seg_conversor is

begin

--We know we only display nimbers in the range [0-9], thats why it doesnt cover [a-f]
seven_seg <= "0000001" when binary = "0000" else
             "1001111" when binary = "0001" else
             "0010010" when binary = "0010" else
             "0000110" when binary = "0011" else
             "1001100" when binary = "0100" else
             "0100100" when binary = "0101" else
             "0100000" when binary = "0110" else
             "0001111" when binary = "0111" else
             "0000000" when binary = "1000" else
             "0001100" when binary = "1001" else
             "0000000";

end Behavioral;
