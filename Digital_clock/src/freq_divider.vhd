----------------------------------------------------------------------------------
-- Engineer: Guillermo Infiesta
-- 
-- Create Date: 19.04.2024 17:47:25
-- Module Name: freq_divider - Behavioral
-- Description: A module which can be used to generate a lower frequency when needed. 
--
-- Additional Comments: Be sure to set the N generic correctly, if you set it to 2 the 
--frequency output will be half of the input, if you set it to 4 it will be a forth, and
-- so on.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity freq_divider is
  Generic (
    N: integer := 2  
  );
  Port (
    clk_in: in std_logic; 
    clk_out: out std_logic
  );
end freq_divider;

architecture Behavioral of freq_divider is

signal cont : integer := 1;
begin

process(clk_in) begin
    if(rising_edge(clk_in)) then
        if(cont = N) then
            cont <= 1;
            clk_out <= '1';
        else
            cont <= cont + 1;
            clk_out <= '0';
        end if;
    end if;
end process;

end Behavioral;
