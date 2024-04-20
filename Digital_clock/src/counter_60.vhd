----------------------------------------------------------------------------------
-- Engineer: Guillermo Infiesta
-- 
-- Create Date: 16.04.2024 20:23:45
-- Design Name: 
-- Module Name: counter_60 - Behavioral
-- Project Name: Minutes_seconds_counter
-- Target Devices: Basys 3
-- Description: A 0 to 59 counter for both seconds and minutes. Since we know we are 
-- going to display the clock we convert from binary to bcd in the counter itself, so
-- value its already the bcd value of minutes/seconds. 
-- 
-- Dependencies: 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity counter_60 is
  Port (
   clk_in: in std_logic;
   value: out std_logic_vector(7 downto 0); --its 2 digits. 2BCD displays = 8 bit
   carry: out std_logic
   );
end counter_60;

architecture Behavioral of counter_60 is
signal cont: std_logic_vector(5 downto 0);

begin

cont_increment: process(clk_in) begin
    if(rising_edge(clk_in)) then
        if cont = 59 then
            cont <= (others => '0');
            carry <= '1';
        else
            cont <= cont + 1; 
            carry <= '0';
        end if;
    end if;
end process;

calc_bcd: process(cont)
    variable aux: UNSIGNED(7 downto 0):=(others => '0');
begin
        aux := (others => '0');
        for i in 5 downto 0 loop
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
