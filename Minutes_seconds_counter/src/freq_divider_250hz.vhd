----------------------------------------------------------------------------------
-- Engineer: Guillermo Infiesta
-- 
-- Create Date: 16.04.2024 20:37:28
-- Module Name: freq_divider_1hz - Behavioral
-- Project Name: Minutes_seconds_counter
-- Target Devices: Basys 3
-- Description: A frequency divider that turns the original 100MHZ frequency
-- of the Basys 3 internal clock into a 250hz signal which will be used to 
-- refresh the 7 segment display, which needs to be refreshed every 1ms to 16ms,
-- and since there are 4 displays, we need a 4ms period to update all 4 every 16ms.
----------------------------------------------------------------------------------

--Could´ve used a single divider with a generic for the counter, too late
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity freq_divider_250hz is
  Port ( 
    clk_in: in std_logic;
    new_clk: out std_logic
  );
end freq_divider_250hz;

architecture Behavioral of freq_divider_250hz is

signal cont: integer := 1;
begin

process(clk_in) begin
    if(rising_edge(clk_in)) then
        if cont = 40000 then
            cont <= 1;
            new_clk <= '1';
        else
            cont <= cont + 1;
            new_clk <= '0';
        end if;
        
    end if;
end process;

end Behavioral;
