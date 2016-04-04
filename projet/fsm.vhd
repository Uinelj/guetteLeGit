LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity control_unit is
	port (
		INSTRUCTION : in std_logic_vector(8 downto 0);
		RUN, RESET, CLOCK : in std_logic;
		DONE,IRset,Aset,Gset: out std_logic;
		R_set : out std_logic_vector( 7 downto 0);
		SEL_ALU : out std_logic_vector(2 downto 0);
		FETCH : out std_logic;
		SEL_MUX : out std_logic_vector(3 downto 0)
	);
end entity control_unit;

architecture control_unit of control_unit is

	-- SIGNALS
	signal SEL_RX: std_logic_vector(3 downto 0);
	signal SEL_RY: std_logic_vector(3 downto 0);
	signal wr_rx : std_logic_vector(7 downto 0);
	signal mux_g : std_logic_vector(3 downto 0);
	signal mux_din: std_logic_vector(3 downto 0);
	
	--type STATES is (IDLE, INIT, CHECK, ADD, SUB, AND, OR, NOT, MUL);
	signal STATE: std_logic_vector(3 downto 0) := "0000";
	constant STATE_IDLE: std_logic_vector(3 downto 0) := "0000";
	constant STATE_CHECK: std_logic_vector(3 downto 0) := "0001";
	constant STATE_ADD: std_logic_vector(3 downto 0) := "0010";
	constant STATE_SUB: std_logic_vector(3 downto 0) := "0011";
	constant STATE_AND: std_logic_vector(3 downto 0) := "0100";
	constant STATE_OR: std_logic_vector(3 downto 0) := "0101";
	constant STATE_NOT: std_logic_vector(3 downto 0) := "0110";
	constant STATE_MVI: std_logic_vector(3 downto 0) := "1000";
	constant STATE_MV: std_logic_vector(3 downto 0) := "1001";


	
begin

	-- ROUTING
	
	mux_g <= "1000";
	mux_din <= "1001";
	
		-- RX READ TRANSMISSION
	with INSTRUCTION(5 downto 3) select SEL_RX <=
		"0000" when "000",
		"0001" when "001",
		"0010" when "010",
		"0011" when "011",
		"0100" when "100",
		"0101" when "101",
		"0110" when "110",
		"0111" when "111",
		(others => 'Z') when others;
	
		-- RY READ TRANSMISSION
	with INSTRUCTION(8 downto 3) select SEL_RY <=
		"0000" when "000",
		"0001" when "001",
		"0010" when "010",
		"0011" when "011",
		"0100" when "100",
		"0101" when "101",
		"0110" when "110",
		"0111" when "111",
		(others => 'Z') when others;
		
		-- set registre
		WITH INSTRUCTION(5 DOWNTO 3) SELECT wr_rx <=
		"00000001" WHEN "000",
		"00000010" WHEN "001",
		"00000100" WHEN "010",
		"00001000" WHEN "011",
		"00010000" WHEN "100",
		"00100000" WHEN "101",
		"01000000" WHEN "110",
		"10000000" WHEN "111",
		(OTHERS => 'X') WHEN OTHERS;
		
	-- PROCESS TRANSITION

	TRANSITION : process(RESET, CLOCK)
	begin
	
		if RESET = '1' then
			STATE <= STATE_IDLE;
		elsif rising_edge(CLOCK) then
			case STATE is
				-- IDLE
				when STATE_IDLE =>
					if RUN = '1' then
						STATE <= STATE_CHECK;
						DONE <= '0';
					end if;
				-- CHECK
				when STATE_CHECK =>
				if INSTRUCTION(3)='1' then --MV / MVI
					if INSTRUCTION(0)='1' then
					STATE<= STATE_MV;
					elsif INSTRUCTION(0)='0' then
					STATE<=STATE_MVI;
					end if;
				else
					if INSTRUCTION(2) = '0' then -- ADD / SUB
						if INSTRUCTION(1) = '1'and INSTRUCTION(0)='0' then -- ADD
							STATE <= STATE_ADD;
						elsif INSTRUCTION(0)='1' then
							STATE <= STATE_SUB; -- SUB
						end if;
					elsif INSTRUCTION(2) = '1' then -- AND / OR / NOT
						if INSTRUCTION(1) = '0' and INSTRUCTION(0) = '0' then -- AND
							STATE <= STATE_AND;
						elsif INSTRUCTION(1) = '0' and INSTRUCTION(0) = '1' then -- OR
							STATE <= STATE_OR;
						elsif INSTRUCTION(1) = '1' and INSTRUCTION(0) = '0' then -- NOT
							STATE <= STATE_NOT;
						end if;
					end if;
				end if;
				-- ADD
				when STATE_ADD =>
					SEL_ALU <= INSTRUCTION(2 downto 0);
					Aset<='1';
					SEL_MUX<= SEL_RX;
					Aset<='0';
					SEL_MUX<= SEL_RY;
					Gset<='1';
					Gset<='0';
					SEL_MUX<=mux_g;
					DONE <='1';
					STATE <= STATE_IDLE;
				-- SUB
				when STATE_SUB =>
					SEL_ALU <= INSTRUCTION(2 downto 0);
					Aset<='1';
					SEL_MUX<= SEL_RX;
					Aset<='0';
					SEL_MUX<= SEL_RY;
					Gset<='1';
					Gset<='0';
					SEL_MUX<=SEL_RX;
					DONE <='1';
					STATE <= STATE_IDLE;
				-- AND
				when STATE_AND =>
					SEL_ALU <= INSTRUCTION(2 downto 0);
					Aset<='1';
					SEL_MUX<= SEL_RX;
					Aset<='0';
					SEL_MUX<= SEL_RY;
					Gset<='1';
					Gset<='0';
					SEL_MUX<=SEL_RX;
					DONE <='1';
					STATE <= STATE_IDLE;
				-- OR
				when STATE_OR =>
					SEL_ALU <= INSTRUCTION(2 downto 0);
					Aset<='1';
					SEL_MUX<= SEL_RX;
					Aset<='0';
					SEL_MUX<= SEL_RY;
					Gset<='1';
					Gset<='0';
					SEL_MUX<=SEL_RX;
					DONE <='1';
					STATE <= STATE_IDLE;
				-- NOT
				when STATE_NOT =>
					SEL_ALU <= INSTRUCTION(2 downto 0);
					Aset<='1';
					SEL_MUX<= SEL_RX;
					Aset<='0';
					SEL_MUX<= SEL_RY;
					Gset<='1';
					Gset<='0';
					SEL_MUX<=SEL_RX;
					DONE <='1';
					STATE <= STATE_IDLE;
				-- MVI
				when STATE_MVI =>
					SEL_MUX<=mux_din;
					R_set<=wr_rx;
					R_set<="00000000";
					DONE <= '1';
				-- MV
				when STATE_MV =>
					R_set<=wr_rx;
					SEL_MUX <= SEL_RY;
					R_set<="00000000";
					DONE <= '1';
				when others =>
					--TODO
			end case;
		end if; 
	end process;

	GENERATION : process(STATE)
	begin
		if STATE = STATE_IDLE then
			FETCH <= '1';
		else
			FETCH <= '0';
		end if;
	end process;

end architecture control_unit;