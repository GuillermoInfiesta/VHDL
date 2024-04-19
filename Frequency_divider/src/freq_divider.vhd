----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.04.2024 17:47:25
-- Design Name: 
-- Module Name: freq_divider - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

entity freq_divider is
  Generic (
    N: integer := 2 --Factor by which we divide the frequency  
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
