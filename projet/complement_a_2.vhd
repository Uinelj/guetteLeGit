LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

-- Complément à 2 d'un nombre binaire codé sur 16 bits.

ENTITY ca2 IS
	PORT(
		a: 	IN 	STD_LOGIC_VECTOR(15 DOWNTO 0);
		cout:	OUT	STD_LOGIC;
		s: 	OUT	STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END ca2;

ARCHITECTURE behavior_ca2 OF ca2 IS
	COMPONENT full_adder_nbits IS 
		GENERIC (n:	INTEGER:=16);
		PORT(
			Cin:	IN STD_LOGIC;
			a, b:	IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			s:	OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			Cout:	OUT STD_LOGIC
		);
	END COMPONENT full_adder_nbits ;
BEGIN
	FA:full_adder_nbits PORT MAP(Cin => "0",  a => NOT(a), b => "0000000000000001", s => s, Cout => cout);
END behavior_ca2;
