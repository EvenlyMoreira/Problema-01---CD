library ieee;
use ieee.std_logic_1164.all;

entity C5 is
    port (w,x,y,z: in  std_logic;
            M,N,O: out std_logic);
end C5;

architecture log of C5 is

begin
    M <= (not(w) and y) or (not(w) and x and z) or (not(x) and not(y) and not(z)) or (w and not(x) and not(y));
    N <= (not(w) and not(x)) or (not(x) and not(y)) or (not(w) and not(y) and z) or (not(w) and y and not(z));
    O <= (not(w) and not(z)) or (not(w) and x and not(y)) or (not(w) and not(x) and y) or (w and not(x) and not(y));
end log;