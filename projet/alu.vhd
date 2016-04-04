LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

-- ALU 16 bits
-- ------------
-- On a besoin de : Additionneur, soustracteur, and, or, not, mux 8 vers 1.
-- ------------
-- Mux 8 vers 1 : 
-- 000 = a AND b
-- 001 = a OR b
-- 010 = NOT a
-- 011 = a - b
-- 100 = a + b

ENTITY alu_16bits IS 
	PORT(
    		a, b: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		sel: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        	s: OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    	);
END alu_16bits;	

ARCHITECTURE behavior_alu_16bits OF alu_16bits IS
	COMPONENT and_16bits
		PORT(
			a, b:	IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			s:	OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT or_16bits	
		PORT(
			a, b:	IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			s:	OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT not_16bits
		PORT(
			a:	IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			s:	OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT soustracteur
		PORT(
			a, b: 	IN 	STD_LOGIC_VECTOR(15 DOWNTO 0);
			cout:	OUT	STD_LOGIC;
			s: 	OUT	STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT soustracteur;

	COMPONENT full_adder_nbits
		GENERIC (n:	INTEGER:=16);
		PORT(
			Cin:	IN STD_LOGIC;
			a, b:	IN STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			s:	OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			Cout:	OUT STD_LOGIC
		);
	END COMPONENT full_adder_nbits ;

	COMPONENT mux 
		PORT(
			in0: in std_logic_vector(15 downto 0);
			in1: in std_logic_vector(15 downto 0);
			in2: in std_logic_vector(15 downto 0);
			in3: in std_logic_vector(15 downto 0);
			in4: in std_logic_vector(15 downto 0);
			in5: in std_logic_vector(15 downto 0);
			in6: in std_logic_vector(15 downto 0);
			in7: in std_logic_vector(15 downto 0);
			out1: out std_logic_vector(15 downto 0);
			sel: in std_logic_vector(2 downto 0)
		);
	END COMPONENT mux;


	SIGNAL Result_And:		STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL Result_Or:		STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL Result_Not:		STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL Result_Soustraction:	STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL Cout_Soustraction:	STD_LOGIC;
	SIGNAL Result_Addition:		STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL Cout_Addition:		STD_LOGIC;

BEGIN
	Calcul_And:		and_16bits PORT MAP(a => a, b => b, s => Result_And);
	Calcul_Or:		or_16bits PORT MAP(a => a, b => b, s => Result_Or);
	Calcul_Not:		not_16bits PORT MAP(a => b, s => Result_Not);
	Calcul_Soustraction:	soustracteur PORT MAP(a => a, b => b, cout => Cout_Soustraction, s => Result_Soustraction);
	Calcul_Addition:	full_adder_nbits PORT MAP(a => a, b => b, Cin => '0', Cout => Cout_Addition, s => Result_Addition);

	Output:			mux PORT MAP(in0 => Result_And, in1 => Result_Or, in2 => Result_Not, in3 => Result_Soustraction, 							in4 => Result_Addition, in5 => "0000000000000000", in6 => "0000000000000000", in7 							=> "0000000000000000", out1 => s, sel => sel);
END behavior_alu_16bits ;
