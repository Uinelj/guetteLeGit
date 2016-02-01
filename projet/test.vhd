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
