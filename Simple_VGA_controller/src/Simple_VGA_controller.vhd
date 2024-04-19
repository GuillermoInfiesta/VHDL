----------------------------------------------------------------------------------
-- Engineer: Guillermo Infiesta
-- 
-- Create Date: 19.04.2024 17:45:52 
-- Module Name: Simple_VGA_controller - Behavioral
-- Project Name: Simple_VGA_controller
-- Target Devices: Basys 3
-- Description: A very simple VGA controller in which we can see the basics on how
-- to display throughout a VGA port, learning how things as front/back porch,
-- Hsync or Vsync work. Modifing this elements help better understand just exactly 
-- how VGA works. The project itself just prints a violet polygon on top of a black 
-- background.
-- 
-- Dependencies: freq_divider
-- 
-- Additional Comments: As sais before, it may look as a very simple program (which it
-- is), but by understanding this basics you will be able to do nearly everything you
-- want as long as is related to VGA. 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity Simple_VGA_controller is
  Port ( 
    clk: in std_logic; --Basys 3 100Mhz clk
    vgaRed, vgaBlue, vgaGreen: out std_logic_vector(3 downto 0); --4 bit for each color
    Hsync, Vsync: out std_logic
  );
end Simple_VGA_controller;

architecture Behavioral of Simple_VGA_controller is

component freq_divider is
  Generic (
    N: integer := 2 --Factor by which we divide the frequency  
  );
  Port (
    clk_in: in std_logic; 
    clk_out: out std_logic
  );
end component;

signal clk_25Mhz: std_logic;
signal x_counter, y_counter: std_logic_vector(9 downto 0) := (others => '0'); --What position of the screen we are at
signal s_vgaRed, s_vgaBlue, s_vgaGreen: std_logic_vector(3 downto 0) := (others => '0');

begin

f_div: freq_divider generic map(4) port map(clk, clk_25Mhz);

draw_val: process(clk_25Mhz) begin
    if(rising_edge(clk_25Mhz)) then
        --If outside of certain limits, color will be black
        if(x_counter < 300 or x_counter > 500 or y_counter <150 or y_counter>300)then
            s_vgaRed <= "0000";
            s_vgaGreen <= "0000";
            s_vgaBlue <= "0000";
        --If inside the limits, color will be purple
        else
            s_vgaRed <= "0110";
            s_vgaGreen <= "0000";
            s_vgaBlue <= "1100";
        end if;
    end if;    
end process;

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

Hsync <= '1' when x_counter < 96 else '0';
Vsync <= '1' when y_counter < 2 else '0';

--When assigning the colors we want to only 'paint' inside the actual display zone, what we do here is check so 
--we only assign the rgb values if we are inside the desired zone, this makes it so we only pain in black when 
--inside the front porch, back porch, etc.
vgaRed <= s_vgaRed when (x_counter > 144 and x_counter < 783 and y_counter > 35 and y_counter < 514) else "1111";
vgaBlue <= s_vgaBlue when (x_counter > 144 and x_counter < 783 and y_counter > 35 and y_counter < 514) else "1111";
vgaGreen <= s_vgaGreen when (x_counter > 144 and x_counter < 783 and y_counter > 35 and y_counter < 514) else "1111";

end Behavioral;
