library ieee;
use ieee.std_logic_1164.all;

entity C3 is
    port (w,x,y,z: in  std_logic;
            G,H,I: out std_logic);
end C3;

architecture log of C3 is

begin
    G <= (not(w) and not(z)) or (w and not(x) and not(y)) or (not(w) and not(x) and y) or (not(w) and x and not(y));
    H <= (not(w) and x) or (not(w) and z) or (not(w) and y) or (w and not(x) and not(y));
    I <= (not(w) and not(z)) or (w and not(x) and not(y)) or (not(w) and not(x) and y) or (not(w) and x and not(y));
end log;