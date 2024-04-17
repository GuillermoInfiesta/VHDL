----------------------------------------------------------------------------------
-- Engineer: Guillermo Infiesta
-- 
-- Create Date: 17.04.2024 22:28:50
-- Module Name: full_adder - Behavioral
-- Description: The one bit full adder is a component which receives two values
-- to add and an input carry, the addition of this tr¡hree values returns
-- the sum value and its output carry.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
  Port (
    a, b, cin: in std_logic;
    sum, cout: out std_logic
   );
end full_adder;

architecture Behavioral of full_adder is

begin

sum <= a xor b xor cin;
cout <= (a and b) or (a and cin) or (b and cin);

end Behavioral;
