library ieee;
use ieee.std_logic_1164.all;

entity multiplex8b is
    port (o0,o1,o2,o3,o4,o5: in  std_logic_vector(13 downto 0);
	  key_mux: in std_logic_vector(2 downto 0);
          S1,S0: out std_logic_vector(6 downto 0));
end multiplex8b;

architecture log of multiplex8b is
signal key_mux0,key_mux1,key_mux2: std_logic_vector(13 downto 0);
signal and0,and1,and2,and3,and4,and5,S: std_logic_vector(13 downto 0);
begin
    key_mux0 <= (key_mux(0),key_mux(0),key_mux(0),key_mux(0),key_mux(0),key_mux(0),key_mux(0),key_mux(0),key_mux(0),key_mux(0),key_mux(0),key_mux(0),key_mux(0),key_mux(0));
    key_mux1 <= (key_mux(1),key_mux(1),key_mux(1),key_mux(1),key_mux(1),key_mux(1),key_mux(1),key_mux(1),key_mux(1),key_mux(1),key_mux(1),key_mux(1),key_mux(1),key_mux(1));
    key_mux2 <= (key_mux(2),key_mux(2),key_mux(2),key_mux(2),key_mux(2),key_mux(2),key_mux(2),key_mux(2),key_mux(2),key_mux(2),key_mux(2),key_mux(2),key_mux(2),key_mux(2));

    and0 <= (not(key_mux0) and not(key_mux1) and not(key_mux2) and o0);
    and1 <= (key_mux0 and not(key_mux1) and not(key_mux2) and o1);
    and2 <= (not(key_mux0) and key_mux1 and not(key_mux2) and o2);
    and3 <= (key_mux0 and key_mux1 and not(key_mux2) and o3);
    and4 <= (not(key_mux0) and not(key_mux1) and key_mux2 and o4);
    and5 <= (key_mux0 and not(key_mux1) and key_mux2 and o5);

    S <= and0 or and1 or and2 or and3 or and4 or and5;
    S0 <= (S(6),S(5),S(4),S(3),S(2),S(1),S(0));
    S0 <= (S(13),S(12),S(11),S(10),S(9),S(8),S(7));
end log;
