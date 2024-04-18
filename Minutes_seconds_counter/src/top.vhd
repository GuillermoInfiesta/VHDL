----------------------------------------------------------------------------------
-- Engineer: Guillermo Infiesta
-- 
-- Create Date: 16.04.2024 20:00:41
-- Module Name: top - Behavioral
-- Project Name: Minutes_seconds_counter
-- Target Devices: Basys 3
-- Description: This project, when implemented into the FPGA will act as a counter
-- displaying minutes and secconds through the 7 segment display the board comes with.
-- Dependencies: freq_divider_250hz,  freq_divider_1hz, counter_60, BCD_conversor.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top is
  Port ( 
    clk: in std_logic;
    an: out std_logic_vector(3 downto 0);
    seg: out std_logic_vector(6 downto 0);
    dp: out std_logic
  );
end top;

architecture Behavioral of top is
component counter_60 is 
    port(
    clk_in: in std_logic;
    value: out std_logic_vector(7 downto 0);
    carry: out std_logic
    );
end component;

component freq_divider_1hz is 
    port(
        clk_in: in std_logic;
        new_clk: out std_logic     
    );
end component;

component freq_divider_250hz is 
    port(
        clk_in: in std_logic;
        new_clk: out std_logic     
    );
end component;

component BCD_conversor is
    port(
        binary: in std_logic_vector(3 downto 0);
        seven_seg: out std_logic_vector(6 downto 0)
    );
end component;

signal clk_1hz, clk_250hz, carry1, carry2: std_logic;
signal display_index : std_logic_vector(1 downto 0) := "00";
signal seconds, minutes: std_logic_vector(7 downto 0);
signal display: std_logic_vector(27 downto 0);

begin
f250hz: freq_divider_250hz port map(clk, clk_250hz);
f1hz: freq_divider_1hz port map(clk, clk_1hz);
cnt1: counter_60 port map(clk_1hz, seconds, carry1);
cnt2: counter_60 port map(carry1, minutes, carry2);
bcd1: BCD_conversor port map(seconds(3 downto 0), display(6 downto 0));
bcd2: BCD_conversor port map(seconds(7 downto 4), display(13 downto 7));
bcd3: BCD_conversor port map(minutes(3 downto 0), display(20 downto 14));
bcd4: BCD_conversor port map(minutes(7 downto 4), display(27 downto 21));

process(clk_250hz) begin
    if(rising_edge(clk_250hz)) then
        if(display_index = 0) then
            an <= "1110";
            seg<=display(6 downto 0);
            display_index <= display_index + 1;
        elsif(display_index = 1) then
            an <= "1101";
            seg<=display(13 downto 7);
            display_index <= display_index + 1;
        elsif(display_index = 2) then
            an <= "1011";
            seg<=display(20 downto 14);
            display_index <= display_index + 1;
        else
            an <= "0111";
            seg<=display(27 downto 21);
            display_index <= (others => '0');
        end if;
    end if;
end process;

dp<='1';

end Behavioral;
