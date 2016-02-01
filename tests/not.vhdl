LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;

entity fa IS
  port(a, b, cin : in STD_LOGIC;
       s, cout : out STD_LOGIC);
end fa;
architecture fa_bhv OF fa IS
BEGIN
s <= a xor b xor cin;
cout <= (a and b) or ((a xor b) and cin);
END fa_bhv;
