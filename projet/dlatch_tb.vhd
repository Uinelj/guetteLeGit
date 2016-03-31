-- Testbench for dlatch
library IEEE;
use IEEE.std_logic_1164.all;
 
entity testbench is
-- empty
end testbench; 

architecture tb of testbench is

-- DUT component
component dlatch is
port(
  write: in std_logic;
  data: in std_logic;
  output: out std_logic);
end component;

signal write_in, data_in, output_out: std_logic;

begin

  -- Connect DUT
  DUT: dlatch port map(write_in, data_in, output_out);

  process
  begin
    write_in <= '1';
    data_in <= '0';
    wait for 1 ns;
    assert(output_out='0') report "Fail 1/0" severity error;
  
	write_in <= '1';
    data_in <= '1';
    wait for 1 ns;
    assert(output_out='1') report "Fail 1/1" severity error;
      
	write_in <= '0';
    data_in <= '0';
    wait for 1 ns;
    assert(output_out='1') report "Fail 1/1" severity error;
    
    write_in <= '0';
    data_in <= '1';
    wait for 1 ns;
    assert(output_out='1') report "Fail 1/1" severity error;
    assert false report "Test done." severity note;
    wait;
  end process;
end tb;

