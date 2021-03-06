-- Code test de transfert
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY VHDLtest IS
		PORT ( SW : IN STD_LOGIC_VECTOR (17 DOWNTO 0);
				LEDR : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
				);
END VHDLtest;

ARCHITECTURE Behaviour OF VHDLtest IS
BEGIN
LEDR<= SW;
END Behaviour;

-- Full adder
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all ;

ENTITY Full_Adder IS
	PORT (
	a, b, cin : IN STD_LOGIC;
	s, cout : OUT STD_LOGIC);
END Full_Adder;

ARCHITECTURE Behaviour OF Full_Adder IS

	SIGNAL resultat : UNSIGNED(1 DOWNTO 0);
	
BEGIN
	s <= a XOR b XOR cin;
	cout <= (a AND b) OR (cin AND a) OR (cin AND b);

END Behaviour ;

-- Full Adder 4 bits
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all ;

ENTITY Full_Adder_4 IS
	PORT (
			a, b : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			s : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			cout : OUT STD_LOGIC
			);
END Full_Adder_4;

ARCHITECTURE behaviour_FA4 OF Full_Adder_4 IS

	COMPONENT Full_Adder IS
		PORT (
					a, b, cin : IN STD_LOGIC ;
					s, cout : OUT STD_LOGIC
				);
	END COMPONENT Full_Adder ;
	
	SIGNAL c : UNSIGNED (2 DOWNTO 0);
BEGIN
	Full_1 : Full_Adder PORT MAP (a(0), b(0), '0', s(0), c(0));
	Full_2 : Full_Adder PORT MAP (a(1), b(1), c(0), s(1), c(1));
	Full_3 : Full_Adder PORT MAP (a(2), b(2), c(1), s(2), c(2));
	Full_4 : Full_Adder PORT MAP (a(3), b(3), c(2), s(3), cout);
END Behaviour_FA4 ;

-- Multiplieur
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mult IS
PORT (
		a, b : STD_LOGIC_VECTOR(3 DOWNTO 0);
		s : STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
END mult ;

ARCHITECTURE Behaviour OF mult IS 
	TYPE mem_et IS ARRAY(0 TO 3) OF STD_LOGIC_VECTOR(3 DOWNTO 0);
	TYPE mem_s IS ARRAY(0 TO 3) OF STD_LOGIC_VECTOR(4 DOWNTO 0);
	TYPE mem_c IS ARRAY(0 TO 3) OF STD_LOGIC_VECTOR(4 DOWNTO 0);
	
	COMPONENT Full_Adder IS
		PORT (
				a, b, cin : IN STD_LOGIC;
				s, cout : OUT STD_LOGIC
				);
	END COMPONENT Full_Adder;
	SIGNAL 	memS : mem_s ; 
	SIGNAL	memET : mem_et ;
	SIGNAL	memC : mem_c ;

BEGIN 
	ligne : FOR i IN 0 TO 3 GENERATE
	
		memC(i)(0) <= '0';
		
		colonne : FOR j IN 0 TO 3 GENERATE
			memET(i)(j) <= (a(j) AND b(i));
	
			prem_1 : IF i=0 GENERATE
				memS(0)(j) <= memET(0)(j);
				memC(0)(4) <= '0';
			END GENERATE prem_1;
	
			prem_2 : IF i>0 GENERATE
				addN:Full_Adder PORT MAP (a => memS(i-1)(j+1), b => memET(i)(j), s => memS(i)(j), cin => memC(i)(j), cout => memC(i)(j+1));
			END GENERATE prem_2;
		
		END GENERATE colonne;
		
		memS(i)(4) <= memC(i)(4);
	
	END GENERATE ligne;
	
	--s(0) <= memS(0)(0);
	--s(1) <= memS(1)(0);
	--s(2) <= memS(2)(0);
	--s(4) <= memS(3)(1);
	--s(5) <= memS(3)(2);
	--s(7) <= memS(3)(4);
	--S(i) <= memS(i)(0);
	--S(0) <= memS(0)(0);
END behaviour ;
