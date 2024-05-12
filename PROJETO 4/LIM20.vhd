library ieee;
use ieee.std_logic_1164.all;

entity LIM20 is -- compodente de contagem de senhas ate 3
   port (
	clock: in std_logic;  -- clock do sistema;
	EA: in std_logic_vector(2 downto 0);  -- load de contagem da senha;
       	lim20 : out std_logic -- saidas dos FFjk;
   );
end LIM20;

architecture logica of LIM20 is
component ffjk is
   port (ck, clr, set, j, k : in  std_logic;
                          q : out std_logic);
end component;

signal loadlim20: std_logic;
signal clr: std_logic;
signal ffjk1 , ffjk2 , ffjk3 , ffjk4 , ffjk5: std_logic;
signal ffjk12 , ffjk123 , ffjk1234: std_logic;

begin
  loadlim20 <= EA(2)and not EA(1) and not EA(0);
  clr <= ffjk1 and ffjk3 and ffjk5;
  lim20 <= ffjk3 and ffjk5;
  ffjk12 <= ffjk1 and ffjk2;

  ffjk123 <= ffjk1 and ffjk12 and ffjk3;

  ffjk1234 <= ffjk1 and ffjk12 and ffjk123 and ffjk4;

  FF_JK1: ffjk port map(clock, clr, '1', loadlim20, loadlim20 , ffjk1);

  FF_JK2: ffjk port map(clock, clr, '1', ffjk1, ffjk1 , ffjk2);

  FF_JK3: ffjk port map(clock, clr, '1', ffjk12, ffjk12 , ffjk3);

  FF_JK4: ffjk port map(clock, clr, '1', ffjk123, ffjk123 , ffjk4);

  FF_JK5: ffjk port map(clock, clr, '1', ffjk1234, ffjk1234 , ffjk5);

end logica;

