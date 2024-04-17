----------------------------------------------------------------------------------
-- Engineer: Guillermo Infiesta
-- 
-- Create Date: 17.04.2024 22:32:10
-- Module Name: n_bit_full_adder - Behavioral
-- Description: This component is an extension of the classis one bit full adder,
-- in this case the component is used to add binary numbers of any size, as long as
-- both have the same length.
-- 
-- Dependencies: This component uses the one bit full adder (full_adder) component
-- make sure you have this imported into the proyect when attempting to use 
-- n_bit_full_adder.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity n_bit_full_adder is
  Generic (
    N: integer --Length of the numbers to add and their result 
  );
  Port ( 
    a, b: in std_logic_vector(N-1 downto 0);
    sum: out std_logic_vector(N-1 downto 0);
    cout: out std_logic
  );
end n_bit_full_adder;

architecture Behavioral of n_bit_full_adder is

component full_adder is
    port(
        a, b, cin: in std_logic;
        sum, cout: out std_logic
    );
end component;

signal carry: std_logic_vector(N downto 0) := (others => '0');

begin

gen: for i in 0 to N-1 generate
    uut: full_adder port map (a(i), b(i), carry(i), sum(i), carry(i+1));
    end generate;

cout <= carry(N);

end Behavioral;
