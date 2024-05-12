library ieee;
use ieee.std_logic_1164.all;

entity LIM5 is -- compodente de contagem de senhas ate 3
   port (
	clock: in std_logic;  -- clock do sistema;
	EA: in std_logic_vector(2 downto 0);  -- load de contagem da senha;
       	lim5 : out std_logic -- saidas dos FFjk;
   );
end LIM5;

architecture logica of LIM5 is
component ffjk is
   port (ck, clr, set, j, k : in  std_logic;
                          q : out std_logic);
end component;

signal loadlim5: std_logic;
signal clr: std_logic;
signal ffjk1,ffjk2,ffjk3: std_logic;
signal ffjk1_2: std_logic;

begin
  loadlim5 <= not EA(2) and EA(0);
  clr <= ffjk3 and ffjk2;
  lim5 <= ffjk3 and ffjk1;
  ffjk1_2 <= ffjk2 and ffjk1;

  FF_JK1: ffjk port map(clock, clr, '1', loadlim5, loadlim5 , ffjk1);
  FF_JK2: ffjk port map(clock, clr, '1', ffjk1, ffjk1 , ffjk2);
  FF_JK3: ffjk port map(clock, clr, '1', ffjk1_2, ffjk1_2 , ffjk3);
end logica;
