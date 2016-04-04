library IEEE;
use IEEE.std_logic_1164.all;

entity mux_16 is
	port(
		in0: in std_logic_vector(15 downto 0);
		in1: in std_logic_vector(15 downto 0);
		in2: in std_logic_vector(15 downto 0);
		in3: in std_logic_vector(15 downto 0);
		in4: in std_logic_vector(15 downto 0);
		in5: in std_logic_vector(15 downto 0);
		in6: in std_logic_vector(15 downto 0);
		in7: in std_logic_vector(15 downto 0);
  		in8: in std_logic_vector(15 downto 0);
		in9: in std_logic_vector(15 downto 0);
		in10: in std_logic_vector(15 downto 0);
		in11: in std_logic_vector(15 downto 0);
		in12: in std_logic_vector(15 downto 0);
		in13: in std_logic_vector(15 downto 0);
		in14: in std_logic_vector(15 downto 0);
		in15: in std_logic_vector(15 downto 0);
		out1: out std_logic_vector(15 downto 0);
		sel: in std_logic_vector(3 downto 0));
end mux_16;

architecture rtl_16 of mux_16 is
begin
  process(in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, sel) is
  begin
  C: case sel is
  	when "0000" => out1 <= in0;
  	when "0001" => out1 <= in1;
  	when "0010" => out1 <= in2;
  	when "0011" => out1 <= in3;
  	when "0100" => out1 <= in4;
  	when "0101" => out1 <= in5;
  	when "0110" => out1 <= in6;
  	when "0111" => out1 <= in7;
	when "1000" => out1 <= in8;
  	when "1001" => out1 <= in9;
  	when "1010" => out1 <= in10;
  	when "1011" => out1 <= in11;
  	when "1100" => out1 <= in12;
  	when "1101" => out1 <= in13;
  	when "1110" => out1 <= in14;
  	when "1111" => out1 <= in15;
    when others => out1 <= in0;
  end case C;
  end process;
end rtl_16;
