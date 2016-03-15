-- Testbench for 16b 8 to 1 Multiplexer
library IEEE;
use IEEE.std_logic_1164.all;

entity testbench is
-- empty
end testbench;

architecture tb of testbench is

-- DUT component
component mux is
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
end component;
--signal a_in, b_in, q_out: std_logic;
signal in0, in1, in2, in3, in4, in5, in6, in7, out1: std_logic_vector(15 downto 0);
signal sel : std_logic_vector(2 downto 0);

begin

  -- Connect DUT
  DUT: mux port map(in0, in1, in2, in3, in4, in5, in6, in7, out1, sel);

  process
  begin
  	in0 <= "0111000011110001";
    in1 <= "0111000011110010";
    in2 <= "0111000011110011";
    in3 <= "0111000011110100";
    in4 <= "0111000011110101";
    in5 <= "0111000011110110";
    in6 <= "0111000011110111";
    in7 <= "0111000011111000";
    sel <= "001";
    wait for 1 ns;
    assert(out1="0111000011110010") report("Fail sel=1") severity error;
  end process;
end tb;
