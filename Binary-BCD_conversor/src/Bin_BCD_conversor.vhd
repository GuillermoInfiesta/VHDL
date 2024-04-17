----------------------------------------------------------------------------------
-- Engineer: Guillermo Infiesta 
--
-- Create Date: 17.04.2024 17:12:41
-- Module Name: Bin_BCD_conversor - Behavioral
-- Description: The component translates a number represented in binary format 
-- into BCD format, which may be needed if we want to display some value through
-- a series of 7-segment displays.
-- 
-- Additional Comments:
-- To determine the ammount of bits needed for the bcd output, remember that each
-- decimal digit has its own BCD value. So in order to get the size of the output
-- calculate it using ->
-- output_size = nº_of_digits(2^N - 1) * 4 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use IEEE.NUMERIC_STD.ALL;


entity Bin_BCD_conversor is
  Generic(
   N: in integer := 4; --Bit size of the binary input
   M: in integer := 8 --Bit size of the BCD output
  );
  Port (
    binary_val: in std_logic_vector(N-1 downto 0);
    bcd_val: out std_logic_vector(M-1 downto 0) 
   );
end Bin_BCD_conversor;

architecture Behavioral of Bin_BCD_conversor is

begin

process(binary_val)
    variable aux: UNSIGNED(M-1 downto 0):=(others => '0');
begin
    aux := (others => '0');
    for i in N-1 downto 0 loop
        for j in M/4 downto 1 loop
            if aux(4*j-1 downto 4*j-4) > 4 then
               aux(4*j-1 downto 4*j-4) := aux(4*j-1 downto 4*j-4) + 3; 
            end if;
        end loop;
        aux := aux(M-2 downto 0) & binary_val(i);
    end loop;   
    bcd_val <= std_logic_vector(aux);
    
end process;

end Behavioral;
