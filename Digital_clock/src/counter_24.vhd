----------------------------------------------------------------------------------
-- Engineer: Guillermo Infiesta
-- 
-- Create Date: 16.04.2024 20:23:45
-- Design Name: 
-- Module Name: counter_24 - Behavioral
-- Target Devices: Basys 3
-- Description: A 0 to 23 counter we will use to count hours, it outputs the BCD
-- value of the counter.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
entity counter_24 is
  Port ( 
    clk_in: in std_logic;
    value: out std_logic_vector(7 downto 0) --its 2 digits. 2BCD displays = 8 bit
  );
end counter_24;

architecture Behavioral of counter_24 is

signal cont: std_logic_vector(4 downto 0) := (others => '0');

begin

cont_increment: process(clk_in) begin
    if(rising_edge(clk_in)) then
        if cont = 23 then
            cont <= (others => '0');
        else
            cont <= cont + 1; 
        end if;
    end if;
end process;

calc_bcd: process(cont)
    variable aux: UNSIGNED(7 downto 0):=(others => '0');
begin
        aux := (others => '0');
        for i in 4 downto 0 loop
            if(aux(7 downto 4) > 4) then
                aux(7 downto 4) := aux(7 downto 4) + 3;
            elsif(aux(3 downto 0) > 4) then
                aux(3 downto 0) := aux(3 downto 0) + 3;
            end if;
            aux := aux(6 downto 0) & cont(i); 
        end loop;
        value <= std_logic_vector(aux);
end process;

end Behavioral;
