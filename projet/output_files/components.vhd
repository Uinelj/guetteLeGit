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

	resultat <= ('0' & a) + ('0' & b) + ('0' & cin);
	s <= resultat(0);
	cout <= resultat(1);

END Behaviour ;

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
