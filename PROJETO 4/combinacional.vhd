library ieee;
use ieee.std_logic_1164.all;

entity combinacional is
    port (chave: in  std_logic_vector(5 downto 0);
	  clock,load,clear: in std_logic;
	  comparacao: out std_logic);
end combinacional;

architecture log of combinacional is

	component senha3 is
   	port (
	  loadsenha3,clear: in std_logic;  -- load de contagem da senha;
          ffjks3_1,ffjks3_2,senha3 : out std_logic -- saidas dos FFjk;
   	);
	end component senha3;

	component demux is
   	port (entrada: in  std_logic_vector(5 downto 0);
	  key: in std_logic_vector(1 downto 0);
          S1,S2,S3: out std_logic_vector(5 downto 0));
	end component demux;

	component Reg_senha is
	Port (
          clock,clear,senha_3: in std_logic;
          senha : in std_logic_vector(17 downto 0);
	  ffjk : in std_logic_vector(1 downto 0);
          senha_reg : out std_logic_vector(17 downto 0)
	);
	end component Reg_senha;

signal cont3: std_logic_vector(1 downto 0);
signal senha_03: std_logic;
signal valor,senha_registrada,comp_xnor: std_logic_vector(17 downto 0);
signal valor1,valor2,valor3: std_logic_vector(5 downto 0);

begin
	valor <= (valor3(5),valor3(4),valor3(3),valor3(2),valor3(1),valor3(0),valor2(5),valor2(4),valor2(3),valor2(2),valor2(1),valor2(0),valor1(5),valor1(4),valor1(3),valor1(2),valor1(1),valor1(0));
	contador_3: senha3 port map(load,clear,cont3(0),cont3(1),senha_03);
	mux: demux port map(chave, cont3,valor1,valor2,valor3);
	registrador: Reg_senha port map(clock,clear,senha_03,valor,cont3,senha_registrada);
	
	--comparação de igualdade

	comp_xnor <= senha_registrada xnor "111100010111100100";
        comparacao <= ((comp_xnor(0) and comp_xnor(1)) and (comp_xnor(2) and comp_xnor(3)) and (comp_xnor(4) and comp_xnor(5))) and
	((comp_xnor(6) and comp_xnor(7)) and(comp_xnor(8) and comp_xnor(9)) and (comp_xnor(10) and comp_xnor(11))) and
	((comp_xnor(12) and comp_xnor(13)) and (comp_xnor(14) and comp_xnor(15)) and (comp_xnor(16) and comp_xnor(17)));

end log;
