LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

-- Operateur logique AND 16 bits
ENTITY and_16bits IS 
	PORT(
    	a, b: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        s: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END and_16bits;	

ARCHITECTURE behavior_and_16bits OF and_16bits IS
BEGIN
	s <= a AND b ;
END behavior_and_16bits ;
