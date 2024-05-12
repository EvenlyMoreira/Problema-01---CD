LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY bin_bcd IS
PORT(
			A_bin, B_bin, C_bin, D_bin: IN STD_LOGIC;
			A_bcd, B_bcd, C_bcd, D_bcd: OUT STD_LOGIC
			
      );
END bin_bcd;

ARCHITECTURE logic OF bin_bcd IS
SIGNAL p_and1, p_and2, p_and3, p_and4, p_and5, p_and6, p_and7, p_and8,
						p_and9, p_or1, p_or2, p_or3, p_or4:STD_LOGIC;

BEGIN 
p_and1 <= B_bin AND D_bin;
p_and2 <= B_bin AND C_bin;
p_and3 <= A_bin AND D_bin;
p_and4 <= B_bin AND (NOT C_bin) AND (NOT D_bin);
p_and5 <= C_bin AND D_bin;
p_and6 <= A_bin AND (NOT D_bin);
p_and7 <= (NOT B_bin) AND C_bin;
p_and8 <= (NOT A_bin) AND (NOT B_bin) AND D_bin;
p_and9 <= B_bin AND C_bin AND (NOT D_bin);

p_or1 <= A_bin OR p_and1 OR p_and2;
p_or2 <= p_and3 OR p_and4;
p_or3 <= p_and5 OR p_and6 OR p_and7;
p_or4 <= p_and6 OR p_and8 OR p_and9;

A_bcd <= p_or1;
B_bcd <= p_or2;
C_bcd <= p_or3;
D_bcd <= p_or4;

END logic;