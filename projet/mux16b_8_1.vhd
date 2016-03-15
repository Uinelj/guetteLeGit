-- Author : Julien ABADJI
-- Simple 16bit 8 to 1 Multiplexer.
library IEEE;
use IEEE.std_logic_1164.all;

entity mux is
port(
  in0: in std_logic_vector(15 downto 0);
  in1: in std_logic_vector(15 downto 0);
  in2: in std_logic_vector(15 downto 0);
  in3: in std_logic_vector(15 downto 0);
  in4: in std_logic_vector(15 downto 0);
  in5: in std_logic_vector(15 downto 0);
  in6: in std_logic_vector(15 downto 0);
  in7: in std_logic_vector(15 downto 0);
  out1: out std_logic_vector(15 downto 0);
  sel: in std_logic_vector(2 downto 0));
end mux;

architecture rtl of mux is
begin
  process(in0, in1, in2, in3, in4, in5, in6, in7, sel) is
  begin
  C: case sel is
  	when "000" => out1 <= in0;
  	when "001" => out1 <= in1;
  	when "010" => out1 <= in2;
  	when "011" => out1 <= in3;
  	when "100" => out1 <= in4;
  	when "101" => out1 <= in5;
  	when "110" => out1 <= in6;
  	when "111" => out1 <= in7;
    when others => out1 <= in0;
  end case C;
  end process;
end rtl;
