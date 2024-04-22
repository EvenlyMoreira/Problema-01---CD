library ieee;
use ieee.std_logic_1164.all;

entity mux_2entradas_4b is
    port (o0,o1: in  std_logic_vector(3 downto 0);
	        key: in std_logic;
            S: out std_logic_vector(3 downto 0)
);
end mux_2entradas_4b;

architecture log of mux_2entradas_4b is
signal key0 : std_logic_vector(3 downto 0);
begin
    key0 <= (key,key,key,key);
    S <= (o0 and not(key0)) or (o1 and key0);
end log;