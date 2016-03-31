-- Dlatch
library IEEE;
use IEEE.std_logic_1164.all;

entity dlatch is
port(
  write: in std_logic;
  data: in std_logic;
  output: out std_logic);
end dlatch;

architecture rtl of dlatch is
begin
  process(write, data) is
  begin
    if write then
    	output<=data;
    end if;
  end process;
end rtl;

