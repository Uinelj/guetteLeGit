LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

-- Operateur logique OR 16 bits
ENTITY or_16bits IS 
	PORT(
    	a, b: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        s: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END and_16bits;	

ARCHITECTURE behavior_or_16bits OF or_16bits IS
BEGIN
	s <= a OR b ;
END behavior_or_16bits ;
