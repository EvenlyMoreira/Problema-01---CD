LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY subtrator IS
PORT(
		A_subtrator     : IN std_logic;
        P_subtrator     : IN std_logic;
        C_IN_subtrator  : IN std_logic;
		O_subtrator     : OUT std_logic;
        C_OUT_subtrator : OUT std_logic
);
END subtrator;


ARCHITECTURE subtracao OF subtrator IS
SIGNAL P_XOR1, P_XOR2,P_AND1, P_AND2, P_AND3,P_OR : std_logic;
		 
		 
BEGIN
    P_XOR1 <= A_subtrator xor P_subtrator; 
    P_XOR2 <= P_XOR1 xor C_IN_subtrator;

    O_subtrator <= P_XOR2;

    P_AND1 <= not(A_subtrator) and P_subtrator;
    P_AND2 <= not(A_subtrator) and C_IN_subtrator;
    P_AND3 <= P_subtrator and C_IN_subtrator;
    P_OR <= P_AND1 or P_AND2 or P_AND3;

    C_OUT_subtrator <= P_OR;


END subtracao;