-- Full adder 1 bit
-- Additionne deux nombres codés sur un bit chacun.

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY full_adder_1bit IS
	PORT(
		a, b, Cin: 	IN STD_LOGIC ;
		s, Cout:		OUT STD_LOGIC
	);
END full_adder_1bit;
	
ARCHITECTURE behavior_fa OF full_adder_1bit IS
BEGIN
	s <= a XOR b XOR Cin ;
	Cout <= (a AND b) OR (a AND Cin) OR (b AND Cin);
END behavior_fa ;

-- Full adder général. (top level entity)
-- Pour les test
-- Testé le full adder n bits généric
-- Fonctionne très bien pour le full adder 1 bit
LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY full_adder IS
	PORT(
		SW: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		LEDR: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		LEDG: OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END full_adder ;
	
ARCHITECTURE behavior OF full_adder IS
	COMPONENT full_adder_1bit
		PORT(
			a, b, Cin: 	IN STD_LOGIC ;
			s, Cout:		OUT STD_LOGIC
		);
	END COMPONENT;
	
BEGIN
	FA : Full_adder_1bit PORT MAP (a => SW(0), b => SW(1), Cin => SW(2), s => LEDG(0), Cout => LEDG(1));
	LEDR <= SW ;
END behavior;
		
-- Full adder n bits générique
-- Permet de créer un full adder de n'importe quelle nombre de bits en changeant la valeur de n.
LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY full_adder_nbits IS 
	GENERIC (n:	INTEGER:=2);
	PORT(
		Cin:	IN STD_LOGIC;
		a, b:	IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		s:		OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		Cout:	OUT STD_LOGIC
	);
END full_adder_nbits ;

ARCHITECTURE behavior_full_adder_nbits OF full_adder_nbits IS
	COMPONENT full_adder
		PORT(
			a, b, Cin:	IN STD_LOGIC;
			s, Cout:		OUT STD_LOGIC
		);
	END COMPONENT;
	SIGNAL t:STD_LOGIC_VECTOR(n DOWNTO 0);

BEGIN
	t(0)<=Cin;
	Cout<=t(n);

	FA:FOR i IN 0 TO n-1 GENERATE
		FA_i:full_adder PORT MAP(Cin => t(i), a => a(i), b => b(i), s => s(i), Cout => t(i+1));
	END GENERATE ;
END behavior_full_adder_nbits ;
