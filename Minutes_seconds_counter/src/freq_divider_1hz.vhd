----------------------------------------------------------------------------------
-- Engineer: Guillermo Infiesta
-- 
-- Create Date: 16.04.2024 20:37:28
-- Module Name: freq_divider_1hz - Behavioral
-- Project Name: Minutes_seconds_counter
-- Target Devices: Basys 3
-- Description: A frequency divider that turns the original 100MHZ frequency
-- of the Basys 3 internal clock into a 1hz signal which will be used to 
-- update the senconds.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity freq_divider_1hz is
  Port ( 
    clk_in: in std_logic;
    new_clk: out std_logic
  );
end freq_divider_1hz;

architecture Behavioral of freq_divider_1hz is

signal cont: integer := 1;
begin

process(clk_in) begin
    if(rising_edge(clk_in)) then
        if cont = 100000000 then
            cont <= 1;
            new_clk <= '1';
        else
            cont <= cont + 1;
            new_clk <= '0';
        end if;
        
    end if;
end process;

end Behavioral;
