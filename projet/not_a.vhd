LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

-- Operateur logique NOT 16 bits
-- Attention, ne fonctionne que pour l'entrée A de l'ALU.
ENTITY not_16bits IS 
	PORT(
    	a: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        s: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END not_16bits;	

ARCHITECTURE behavior_not_16bits OF not_16bits IS
BEGIN
	s <= NOT(a) ;
END behavior_not_16bits ;
