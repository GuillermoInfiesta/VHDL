----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.04.2024 22:52:38
-- Design Name: 
-- Module Name: tb_full_adder - Behavioral
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

entity tb_full_adder is
end tb_full_adder;

architecture Behavioral of tb_full_adder is

component full_adder is
    port(
        a, b, cin: in std_logic;
        sum, cout: out std_logic
    );
end component;
signal a, b, cin, sum, cout: std_logic;
begin
uut: full_adder port map(a,b,cin,sum,cout);

process begin
    a<='0';
    b<='1';
    cin<='1';
    wait for 10ns;

    a<='1';
    b<='1';
    cin<='1';
    wait for 10ns;
    
    a<='1';
    b<='0';
    cin<='0';
    wait for 10ns;
    
    a<='0';
    b<='0';
    cin<='0';
    wait for 10ns;
    
    wait;
end process;
end Behavioral;
