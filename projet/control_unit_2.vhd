library IEEE;
use IEEE.std_logic_1164.all;

ENTITY fsm IS
	PORT(
		Run, Reset, Clk:						IN	STD_LOGIC;
		IRs, R0s, R1s, R2s, R3s, R4s, R5s, R6s, R7s, Done, As, Gs: 	OUT	STD_LOGIC;
		Instruction:							IN 	STD_LOGIC_VECTOR(8 DOWNTO 0);
		BusSel:								OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
		Ope:								OUT	STD_LOGIC_VECTOR(2 DOWNTO 0)
	);
END fsm ;

ARCHITECTURE bhv_fsm OF fsm IS
	

END bhv_fsm;
