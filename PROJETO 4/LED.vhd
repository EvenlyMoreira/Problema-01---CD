library ieee;
use ieee.std_logic_1164.all;

entity LED is
   port (EA : in  std_logic_vector(2 downto 0);
         R,G,B : out std_logic);
end LED;

architecture log of LED is

component demux_led is
    port (key: in std_logic_vector(2 downto 0);
          S0,S1,S2,S3,S4,S5: out std_logic);
end component demux_led;

signal fechado,iniciando,valor,senha,aberto,cancelando: std_logic;
begin

	demux: demux_led port map(EA,fechado,iniciando,valor,senha,aberto,cancelando);
	R <= fechado or valor;
	G <= aberto;
	B <= iniciando or senha or cancelando;
end log;
