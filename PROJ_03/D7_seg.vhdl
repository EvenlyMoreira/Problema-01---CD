LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY D7_seg IS
    PORT(
            SW      : in std_logic_vector (3 downto 0);
            HEX     : out std_logic_vector (6 downto 0)
    );
END ENTITY;

ARCHITECTURE main OF D7_seg IS

BEGIN
    HEX(0) <= (NOT(SW(3)) AND NOT(SW(2)) AND NOT(SW(1)) AND SW(0)) OR (SW(2) AND NOT(SW(1)) AND NOT(SW(0)));
        
    HEX(1) <= (SW(2) AND NOT(SW(1)) AND SW(0)) OR (SW(2) AND SW(1) AND NOT(SW(0)));
        
    HEX(2) <= NOT(SW(2)) AND SW(1) AND NOT(SW(0));

    HEX(3) <= (NOT(SW(3)) AND NOT(SW(2)) AND NOT(SW(1)) AND SW(0)) OR (SW(2) AND NOT(SW(1)) AND NOT(SW(0))) OR (SW(2) AND SW(1) AND SW(0));
           
    HEX(4) <= SW(0) OR (SW(2) AND NOT(SW(1)));

    HEX(5) <= (NOT(SW(3)) AND NOT(SW(2)) AND SW(0)) OR (NOT(SW(2)) AND SW(1)) OR (SW(1) AND SW(0));

    HEX(6) <= (NOT(SW(3)) AND NOT(SW(2)) AND NOT(SW(1))) OR (SW(2) AND SW(1) AND SW(0));
            
END ARCHITECTURE;