library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb is
end tb;

architecture Behavioral of tb is

component Bin_BCD_conversor is 
  Generic(
   N: in integer := 4; --Bit size of the binary input
   M: in integer := 8--Bit size of the BCD output
  );
  Port (
    binary_val: in std_logic_vector(N-1 downto 0);
    bcd_val: out std_logic_vector(M-1 downto 0) 
   );
end component;   

-- IMPORTANT: IF CHANGING THE INPUT OR OUTPUT SIZE, REMEMBER TO CHANGE
-- THE SIZE OF THIS SIGNALS TOO IN ORDER FOR THE TEST_BENCH TO WORK
signal bin: std_logic_vector(5 downto 0):="000000";
signal bcd: std_logic_vector(7 downto 0);

begin

uut: Bin_BCD_conversor 
    generic map(6, 8)
    port map(bin, bcd);
process begin
    bin <= "111111";
    wait for 20ns;
    assert bcd = "01100011"
    severity failure;
    
    bin <= "010101";
    wait for 20ns;
    assert bcd = "00100001"
    severity failure;
    
    bin <= "111000";
    wait for 20ns;
    assert bcd = "01010110"
    severity failure;
    wait ;
end process;
end;
