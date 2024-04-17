----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.04.2024 22:53:27
-- Design Name: 
-- Module Name: tb_n_bit_full_adder - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity tb_n_bit_full_adder is
end tb_n_bit_full_adder;

architecture Behavioral of tb_n_bit_full_adder is

component n_bit_full_adder is
  Generic (
    N: integer
  );
  Port ( 
    a, b: in std_logic_vector(N-1 downto 0);
    sum: out std_logic_vector(N-1 downto 0);
    cout: out std_logic
  );
end component;

constant length: integer := 4;

signal a,b,sum: std_logic_vector(length-1 downto 0);
signal cout: std_logic;
begin

uut: n_bit_full_adder 
    generic map(length)  
    port map(a,b,sum,cout);

process begin
    
    a<="1111";
    b<="0010";
    wait for 5ns;
    assert sum = "0001" and cout = '1'
    severity failure;

    a<="0011";
    b<="0110";
    wait for 5ns;
    assert sum = "1001" and cout = '0'
    severity failure;
    
    a<="0101";
    b<="0111";
    wait for 5ns;
    assert sum = "1100" and cout = '0'
    severity failure;
    
    wait;
end process;
end Behavioral;
