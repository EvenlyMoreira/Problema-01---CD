library ieee;
use ieee.std_logic_1164.all;

entity mux_2entradas_1b is
    port (o0,o1: in  std_logic;
	  key: in std_logic;
          S: out std_logic
);
end mux_2entradas_1b;

architecture log of mux_2entradas_1b is
begin
    S <= (o0 and not(key)) or (o1 and key);
end log;