LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

-- Soustracteur 16 bits
-- ----------
-- Principe :
-- A - B
-- A + Complément à 2 de B

ENTITY soustracteur IS
	PORT(
		a, b: 	IN 	STD_LOGIC_VECTOR(15 DOWNTO 0);
		cout:	OUT	STD_LOGIC;
		s: 	OUT	STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END soustracteur;

ARCHITECTURE behavior_soustracteur OF soustracteur IS
	COMPONENT full_adder_nbits
		GENERIC (n:	INTEGER:=16);
		PORT(
			Cin:	IN STD_LOGIC;
			a, b:	IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			s:	OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			Cout:	OUT STD_LOGIC
		);
	END COMPONENT full_adder_nbits ;

	COMPONENT complement_a_2
		PORT(
			a: 	IN 	STD_LOGIC_VECTOR(15 DOWNTO 0);
			cout:	OUT	STD_LOGIC;
			s: 	OUT	STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT complement_a_2;
	
	SIGNAL B_CA2:	STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL COUT_CA2:STD_LOGIC;

BEGIN
	CA2:complement_a_2 PORT MAP (a => b, cout => COUT_CA2, s => B_CA2);
	SOUS:full_adder_nbits PORT MAP(Cin => COUT_CA2,  a => a, b => B_CA2, s => s, Cout => cout);
END behavior_soustracteur;

