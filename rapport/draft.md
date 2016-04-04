# Rapport de projet : Processeur 16 bits.

# 1. Contexte et résumé du projet

  Ce projet se place dans le cadre de l'UE d'architecture des ordinateurs de L3 Informatique de l'Université de Cergy-Pontoise.

  L'idée est de reprendre le projet de l'année passée, un processeur 4bits Logisim, mais de le réaliser sur 16bits sur FPGA. Cette approche fait intervenir d'autres outils (l'IDE Quartus et le langage VHDL), et est plus concrète, puisque réalisée sur du matériel (FPGA).

# 2. Spécification du processeur

Le processeur travaille avec des données de 16 bits et est capable de réaliser des opérations arithmétiques simples (addition, soustraction), ainsi que des opérations logiques (AND, OR, NOT).

La table des opcodes est disponible ci-dessous :

| OPCODE | Opération réalisée | Entrées | Sorties |
|--------|--------------------|---------|---------|
| ADD    | Addition           | 2       | 1       |
| SUB    | Soustraction       | 2       | 1       |
| AND    | ET Booléen         | 2       | 1       |
| OR     | OU Booléen         | 2       | 1       |
| NOT    | NON Booléen        | 1       | 1       |
| MV     | Déplacement registre | 2 | 0 |
| MVI    | Déplacement immédiat | 1 | 0 |

# 3. Modules internes

  Le processeur est principalement constitué de trois parties :

  * __L'ALU__ (ou unité arithmétique et logique), qui s'occupe de tout calcul ou opération booléenne (AND, OR, NOT, etc.), qui est constitué d'une multitude de blocs s'occupant des dits calculs, puis d'un multiplexeur s'occupant de renvoyer la valeur désirée en fonction de la valeur d'un sélecteur mis en entrée,

  Voici une partie du code source de l'ALU :

  ```vhdl

  BEGIN
  	Calcul_And:		and_16bits PORT MAP(a => a, b => b, s => Result_And);
  	Calcul_Or:		or_16bits PORT MAP(a => a, b => b, s => Result_Or);
  	Calcul_Not:		not_16bits PORT MAP(a => b, s => Result_Not);
  	Calcul_Soustraction:	soustracteur PORT MAP(a => a, b => b, cout => Cout_Soustraction, s => Result_Soustraction);
  	Calcul_Addition:	full_adder_nbits PORT MAP(a => a, b => b, Cin => '0', Cout => Cout_Addition, s => Result_Addition);

  	Output:			mux PORT MAP(in0 => Result_And, in1 => Result_Or, in2 => Result_Not, in3 => Result_Soustraction, 							in4 => Result_Addition, in5 => "0000000000000000", in6 => "0000000000000000", in7 							=> "0000000000000000", out1 => s, sel => sel);
  END behavior_alu_16bits ;

  ```

  * __Les registres__, servant à garder les informations dont le processeur à besoin, construit sur des bascules D, des drapeaux de lecture/écriture et des bits de sélection en entrée, pour une valeur en sortie.


  * __La FSM__ (ou Finite State Machine), qui reçoit les entrées du processeur, les analyse et envoie les bons signaux en conséquence.

  ```

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


  ```
# 4. Répartition des tâches

  Le processeur étant constitué de trois modules, chaque personne a été assignée à un d'entre eux.

  * __Alex__ s'est occupé de l'__ALU__ principalement, mais a également aidé sur la __FSM__,
  * __Arya__ s'est occupé de la __FSM__, mais a aussi réalisé le décodeur/afficheur,
  * __Julien__ s'est occupé des bancs de __registre__ et, dans une moindre mesure, de certaines parties de __l'ALU__.


# 6. Conclusion

Ce projet nous a permis de découvrir plus en détail l'architecture des processeurs, mais aussi de pratiquer sur des technologies concrètes et utilisées dans le monde professionnel, tels les FPGA Altera et l'environnement de développement intégré Quartus, ainsi que le l'apprentissage du langage VHDL.

Sinon, trkl ?

# 7. Améliorations
