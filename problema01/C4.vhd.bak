library ieee;
use ieee.std_logic_1164.all;

entity C4 is
    port (w,x,y,z: in  std_logic;
            J,K,L: out std_logic);
end C4;

architecture log of C4 is

begin
    J <= (not(x) and not(y) and not(z)) or (not(w) and x and y) or (not(w) and y and not(z));
    K <= (not(w) and not(x) and not(y) and z);
    L <= (w and not(x) and not(y)) or (not(w) and x and not(y)) or (not(x) and not(y) and not(z)) or (not(w) and x and not(z)) or (not(w) and not(x) and y and z);
end log;