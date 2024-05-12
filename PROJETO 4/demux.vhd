library ieee;
use ieee.std_logic_1164.all;

entity demux is
    port (entrada: in  std_logic_vector(5 downto 0);
	  key: in std_logic_vector(1 downto 0);
          S1,S2,S3: out std_logic_vector(5 downto 0));
end demux;

architecture log of demux is

signal key0,key1: std_logic_vector(5 downto 0);

begin
    key0 <= (key(0),key(0),key(0),key(0),key(0),key(0));
    key1 <= (key(1),key(1),key(1),key(1),key(1),key(1));

    S1 <= key0 and not(key1) and entrada;
    S2 <= not(key0) and key1 and entrada;
    S3 <= key0 and key1 and entrada;
end log;