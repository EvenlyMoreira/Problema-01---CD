library ieee;
use ieee.std_logic_1164.all;

entity C2 is
    port (w,x,y,z: in  std_logic;
            D,E,F: out std_logic);
end C2;

architecture log of C2 is

begin
    D <= (not(w) and not(y)) or (not(x) and not(y));
    E <= (not(w) and not(x) and not(y) and z);
    F <= (not(w) and y) or (not(w) and not(z)) or (w and not(x) and not(y));
end log;