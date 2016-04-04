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

# 3. Modules internes

  Le processeur est principalement constitué de trois parties :

  * __L'ALU__ (ou unité arithmétique et logique), qui s'occupe de tout calcul ou opération booléenne (AND, OR, NOT, etc.), qui est constitué d'une multitude de blocs s'occupant des dits calculs, puis d'un multiplexeur s'occupant de renvoyer la valeur désirée en fonction de la valeur d'un sélecteur mis en entrée,
  METTRE SCHEMA

  * __Les registres__, servant à garder les informations dont le processeur à besoin, construit sur des bascules D, des drapeaux de lecture/écriture et des bits de sélection en entrée, pour une valeur en sortie,

  * __La FSM__ (ou Finite State Machine), qui reçoit les entrées du processeur, les analyse et envoie les bons signaux en conséquence. (ARYA)

# 4. Répartition des tâches

  Le processeur étant constitué de trois modules, chaque personne a été assignée à un d'entre eux.

  * __Alex__ s'est occupé de l'__ALU__ principalement, mais a également aidé sur la __FSM__,
  * __Arya__ s'est occupé de la __FSM__, mais a aussi réalisé le décodeur/afficheur,
  * __Julien__ s'est occupé des bancs de __registre__ et, dans une moindre mesure, de certaines parties de __l'ALU__.

# 5. Résultat

Blablater sur le processeur, à quoi il ressemble tout ça.

# 6. Conclusion

Ce projet nous a permis de découvrir plus en détail l'architecture des processeurs, mais aussi de pratiquer sur des technologies concrètes et utilisées dans le monde professionnel, tels les FPGA Altera et l'environnement de développement intégré Quartus, ainsi que le l'apprentissage du langage VHDL.

Sinon, trkl ?

# 7. Améliorations

