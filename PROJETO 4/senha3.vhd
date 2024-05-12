library ieee;
use ieee.std_logic_1164.all;

entity senha3 is -- componente de contagem de senhas ate 3
   port (
	loadsenha3,clear: in std_logic;  -- load de contagem da senha;
        ffjks3_1,ffjks3_2,senha3 : out std_logic -- saidas dos FFjk;
   );
end senha3;

architecture logica of senha3 is
component ffjk is
   port (ck, clr, set, j, k : in  std_logic;
                          q : out std_logic);
end component;

signal ffjk1,ffjk2: std_logic;

begin

  FF_JK1: ffjk port map(loadsenha3, clear, '1', loadsenha3, loadsenha3 , ffjk1);
  FF_JK2: ffjk port map(loadsenha3, clear, '1', ffjk1, ffjk1 , ffjk2);
  ffjks3_1 <= ffjk1 ;
  ffjks3_2 <= ffjk2 ;
  senha3 <= ffjk1 and ffjk2;

end logica;