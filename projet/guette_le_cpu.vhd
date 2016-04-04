LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY guette_le_cpu IS
	PORT(
		Din:						IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		Run, Reset_n, Clock:	IN STD_LOGIC;
		Bus:						OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		Done:						OUT STD_LOGIC		
	);
END guette_le_cpu;

ARCHITECTURE bhv_guette_le_cpu OF guette_le_git IS
	-- Rappel du multiplexeur 16 entrées
	COMPONENT mux_16
		port(
		in0: in std_logic_vector(15 downto 0);
		in1: in std_logic_vector(15 downto 0);
		in2: in std_logic_vector(15 downto 0);
		in3: in std_logic_vector(15 downto 0);
		in4: in std_logic_vector(15 downto 0);
		in5: in std_logic_vector(15 downto 0);
		in6: in std_logic_vector(15 downto 0);
		in7: in std_logic_vector(15 downto 0);
  		in8: in std_logic_vector(15 downto 0);
		in9: in std_logic_vector(15 downto 0);
		in10: in std_logic_vector(15 downto 0);
		in11: in std_logic_vector(15 downto 0);
		in12: in std_logic_vector(15 downto 0);
		in13: in std_logic_vector(15 downto 0);
		in14: in std_logic_vector(15 downto 0);
		in15: in std_logic_vector(15 downto 0);
		out1: out std_logic_vector(15 downto 0);
		sel: in std_logic_vector(3 downto 0));
	END COMPONENT;

	-- Rappel de l'ALU 16 bits.
	COMPONENT alu_16bits
		PORT(
    			a, b: IN STD_LOGIC_VECTOR(15 DOWNTO 0);
				sel: 	IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        		s: 	OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
    		);
	END COMPONENT ;

	-- Rappel du registre 16 bits.
	COMPONENT registre
		generic (n: positive:=16);
		PORT (
			D:IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
			Clk,Reset_n, Set : in std_logic;
			Q: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
		);
	END COMPONENT;

	-- Ajouter FSM
	COMPONENT control_unit
		PORT(
			INSTRUCTION : in std_logic_vector(8 downto 0);
			RUN, RESET, CLOCK : in std_logic;
			DONE : out std_logic;
			SEL_ALU : out std_logic_vector(2 downto 0);
			SEL_MUX : out std_logic_vector(3 downto 0)
		);
	END COMPONENT;

BEGIN
	R0:registre PORT MAP (D => , Clk => Clock, );		
	

END bhv_guette_le_cpu ;
