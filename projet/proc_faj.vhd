-- Fichier de test du FPGA
-- "Active" les switchs (SW) et les led rouges (LEDR)
-- Allume la led correspondant au switch (SW(I) activé => LEDR(I) s'allume)
LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY proc_faj IS
	PORT (
		SW : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
		LEDR : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
	);
END proc_faj;

ARCHITECTURE behavior_part1 OF proc_faj IS
BEGIN
	LEDR <= SW ;
END behavior_part1 ;

