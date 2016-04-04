-- registre 16bits : R0 à R7, A et G
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY registre IS
	generic (n: positive:=16);
	PORT (
		D:IN  STD_LOGIC_VECTOR(n-1 DOWNTO 0);
		Clk,Reset_n, Set : in std_logic;
		Q: OUT STD_LOGIC_VECTOR(n-1 DOWNTO 0)
	);
END registre;

ARCHITECTURE Bhv_reg of registre is
	BEGIN
		process(Clk, Reset_n)
			begin
				-- Si on reset
				if Reset_n = '1' then
					Q <= (others=>'0'); -- tous les bits de sortie sont initialisés à 0
				-- Sinon si la clock est à 1
				elsif Clk'event and Set='1' then
					Q<=D; -- La sortie du registre est égale à la donnée stocké dedans.
				end if;
	END process;
END Bhv_reg;
