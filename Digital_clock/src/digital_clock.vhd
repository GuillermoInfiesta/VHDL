---------------------------------------------------------------------------------- 
-- Engineer: Guillermo Infiesta
-- 
-- Create Date: 20.04.2024 17:57:22
-- Module Name: digital_clock - Behavioral
-- Project Name: Digital clock
-- Target Devices: Basys 3
-- Description: This project when connected to a monitor via VGA cable will display
-- a clock in the format hours:minutes:seconds.
-- 
-- Dependencies: counter_60, counter_40, BCD_7seg_conversor, freq_divider
-- 
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity digital_clock is
  Port ( 
    clk: in std_logic;
    vgaRed, vgaGreen, vgaBlue: out std_logic_vector(3 downto 0);
    Hsync, Vsync: out std_logic
  );
end digital_clock;

architecture Behavioral of digital_clock is
-------------------------
component freq_divider is
  Generic (
    N: integer := 2
  );
  Port (
    clk_in: in std_logic; 
    clk_out: out std_logic
  );
end component;
-------------------------

-------------------------
component counter_60 is
   Port (
       clk_in: in std_logic;
       value: out std_logic_vector(7 downto 0);
       carry: out std_logic
   );
end component; 
-------------------------

-------------------------
component counter_24 is 
  Port ( 
    clk_in: in std_logic;
    value: out std_logic_vector(7 downto 0)
  );
end component;
-------------------------

-------------------------
component BCD_7seg_conversor is
  Port ( 
    binary: in std_logic_vector(3 downto 0);
    seven_seg: out std_logic_vector(6 downto 0)
  );
end component;
-------------------------

signal clk_25Mhz, clk_1hz: std_logic;
signal hours, minutes, seconds: std_logic_vector(7 downto 0) := (others => '0');
signal carrys: std_logic_vector(1 downto 0) := (others => '0');
signal hours_d1, hours_d2, minutes_d1, minutes_d2, seconds_d1, seconds_d2: std_logic_vector(6 downto 0) := (others => '0');
signal x_counter, y_counter: std_logic_vector(9 downto 0);
procedure draw_digit(
    signal digit: in std_logic_vector(6 downto 0);
    signal x_offset, y_offset: in std_logic_vector(9 downto 0);
    constant x_base, y_base: in integer;
    signal red: out std_logic_vector(3 downto 0)
    ) is
    constant height: integer := 160;
    constant width: integer := 80;
begin
    if(x_offset > x_base and x_offset < x_base + width and
       y_offset > y_base and y_offset < y_base + height) then
       
        if(digit(6) = '0' and (y_offset < y_base + (height/7) and 
        x_offset > x_base + (width/4) and x_offset < x_base + (3 * width / 4))) then
            red <= "1111";
        end if;
        
        if(digit(5) = '0' and (x_offset > x_base + (3 * width / 4) and
        y_offset < y_base + (3 * height/7))) then
            red <= "1111";
        end if;
        
        if(digit(4) = '0' and (x_offset > x_base + (3 * width / 4) and
        y_offset > y_base + (4 * height/7))) then
            red <= "1111";
        end if;
        
        if(digit(3) = '0' and (y_offset > y_base + (6 * height/7) and 
        x_offset > x_base + (width/4) and x_offset < x_base + (3 * width / 4))) then
            red <= "1111";
        end if;
        
        if(digit(2) = '0' and (x_offset < x_base + width / 4 and
        y_offset > y_base + (4 * height/7))) then
            red <= "1111";
        end if;
        
        if(digit(1) = '0' and (x_offset < x_base + width / 4 and
        y_offset < y_base + (3 * height/7))) then
            red <= "1111";
        end if;
        
        if(digit(0) = '0' and 
        (x_offset > x_base + width / 4 and x_offset < x_base + (3 * width / 4) and
        y_offset > y_base + (3 * height/7) and y_offset < y_base + (4 * height/7))) then
            red <= "1111";
        end if;
    end if;
end procedure;
   
procedure draw_dots(
    signal x_offset, y_offset: in std_logic_vector(9 downto 0);
    constant x_base, y_base: in integer;
    signal red: out std_logic_vector(3 downto 0)
    ) is
    constant height: integer := 160;
    constant width: integer := 40;
begin
    if(x_offset > x_base and x_offset < x_base + width and
       ((y_offset > y_base + height / 5 and y_offset < y_base + (2 * height / 5)) or
       (y_offset > y_base + (3 * height / 5) and y_offset < y_base + (4 * height / 5)))) then
        red<="1111";    
    end if;
end procedure;
begin

freq_div_1hz: freq_divider generic map(100000000) port map(clk, clk_1hz);
freq_div_25mhz: freq_divider generic map(4) port map(clk, clk_25Mhz);
counter_s: counter_60 port map(clk_1hz, seconds, carrys(0));
counter_m: counter_60 port map(carrys(0), minutes, carrys(1));
counter_h: counter_24 port map(carrys(1), hours);
seg_h1: BCD_7seg_conversor port map(hours(7 downto 4), hours_d1);
seg_h2: BCD_7seg_conversor port map(hours(3 downto 0), hours_d2);
seg_m1: BCD_7seg_conversor port map(minutes(7 downto 4), minutes_d1);
seg_m2: BCD_7seg_conversor port map(minutes(3 downto 0), minutes_d2);
seg_s1: BCD_7seg_conversor port map(seconds(7 downto 4), seconds_d1);
seg_s2: BCD_7seg_conversor port map(seconds(3 downto 0), seconds_d2);

counters_update: process(clk_25Mhz) begin
    if(rising_edge(clk_25Mhz)) then
        if(x_counter < 799)then
            x_counter <= x_counter+1;
        else
            if(y_counter < 525)then
                y_counter <= y_counter + 1;
            else
                y_counter <= (others => '0');
            end if;
            x_counter <= (others => '0');
        end if;
    end if;
end process;


draw: process begin
    if(rising_edge(clk)) then
        vgaRed <= "0000";
        vgaGreen <= "0000";
        vgaBlue <= "0000";
        draw_digit(hours_d1, x_counter, y_counter, 150, 200, vgaRed);
        draw_digit(hours_d2, x_counter, y_counter, 240, 200, vgaRed);
        draw_dots(x_counter, y_counter, 330, 200, vgaRed);
        draw_digit(minutes_d1, x_counter, y_counter, 380, 200, vgaRed);
        draw_digit(minutes_d2, x_counter, y_counter, 470, 200, vgaRed);
        draw_dots(x_counter, y_counter, 560, 200, vgaRed);
        draw_digit(seconds_d1, x_counter, y_counter, 610, 200, vgaRed);
        draw_digit(seconds_d2, x_counter, y_counter, 700, 200, vgaRed);
    end if;
end process;

Hsync <= '1' when x_counter < 96 else '0';
Vsync <= '1' when y_counter < 2 else '0';

vgaBlue <= "0000";
vgaGreen <= "0000";

end Behavioral;
