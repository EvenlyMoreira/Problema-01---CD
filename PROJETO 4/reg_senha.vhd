library ieee;
use ieee.std_logic_1164.all;

entity Reg_senha is
    Port (
        clock,clear,senha_3: in std_logic;
        senha : in std_logic_vector(17 downto 0);
	ffjk : in std_logic_vector(1 downto 0);
        senha_reg : out std_logic_vector(17 downto 0)
    );
end Reg_senha;

architecture log of Reg_senha is
	component ffd is
   	port (ck, clr, set, d : in  std_logic;
              q : out std_logic
	);
	end component ffd;

	component mux_2entradas_1b is
    	port (o0,o1: in  std_logic;
	  	key: in std_logic;
  	        S: out std_logic
	);
	end component mux_2entradas_1b;

signal senha_temp: std_logic_vector(17 downto 0);
signal D: std_logic_vector(17 downto 0);
signal cont_1,cont_2: std_logic;

begin
    
    cont_1 <= ffjk(0) and not(ffjk(1));
    cont_2 <= not(ffjk(0)) and ffjk(1);

    MUX_0: mux_2entradas_1b port map(senha_temp(0),senha(0),cont_1,D(0));
    FF_00: ffd port map (Clock, Clear, '1' ,D(0) , senha_temp(0));

    MUX_1: mux_2entradas_1b port map(senha_temp(1),senha(1),cont_1,D(1));
    FF_01: ffd port map (Clock, Clear, '1' ,D(1) , senha_temp(1));

    MUX_2: mux_2entradas_1b port map(senha_temp(2),senha(2),cont_1,D(2));
    FF_02: ffd port map (Clock, Clear, '1' ,D(2) , senha_temp(2));

    MUX_3: mux_2entradas_1b port map(senha_temp(3),senha(3),cont_1,D(3));
    FF_03: ffd port map (Clock, Clear, '1' ,D(3) , senha_temp(3));

    MUX_4: mux_2entradas_1b port map(senha_temp(4),senha(4),cont_1,D(4));
    FF_04: ffd port map (Clock, Clear, '1' ,D(4) , senha_temp(4));

    MUX_5: mux_2entradas_1b port map(senha_temp(5),senha(5),cont_1,D(5));
    FF_05: ffd port map (Clock, Clear, '1' ,D(5) , senha_temp(5));

    MUX_6: mux_2entradas_1b port map(senha_temp(6),senha(6),cont_2,D(6));
    FF_06: ffd port map (Clock, Clear, '1' ,D(6) , senha_temp(6));

    MUX_7: mux_2entradas_1b port map(senha_temp(7),senha(7),cont_2,D(7));
    FF_07: ffd port map (Clock, Clear, '1' ,D(7) , senha_temp(7));

    MUX_8: mux_2entradas_1b port map(senha_temp(8),senha(8),cont_2,D(8));
    FF_08: ffd port map (Clock, Clear, '1' ,D(8) , senha_temp(8));

    MUX_9: mux_2entradas_1b port map(senha_temp(9),senha(9),cont_2,D(9));
    FF_09: ffd port map (Clock, Clear, '1' ,D(9) , senha_temp(9));

    MUX_10: mux_2entradas_1b port map(senha_temp(10),senha(10),cont_2,D(10));
    FF_10: ffd port map (Clock, Clear, '1' ,D(10) , senha_temp(10));

    MUX_11: mux_2entradas_1b port map(senha_temp(11),senha(11),cont_2,D(11));
    FF_11: ffd port map (Clock, Clear, '1' ,D(11) , senha_temp(11));

    MUX_12: mux_2entradas_1b port map(senha_temp(12),senha(12),senha_3,D(12));
    FF_12: ffd port map (Clock, Clear, '1' ,D(12) , senha_temp(12));

    MUX_13: mux_2entradas_1b port map(senha_temp(13),senha(13),senha_3,D(13));
    FF_13: ffd port map (Clock, Clear, '1' ,D(13) , senha_temp(13));

    MUX_14: mux_2entradas_1b port map(senha_temp(14),senha(14),senha_3,D(14));
    FF_14: ffd port map (Clock, Clear, '1' ,D(14) , senha_temp(14));

    MUX_15: mux_2entradas_1b port map(senha_temp(15),senha(15),senha_3,D(15));
    FF_15: ffd port map (Clock, Clear, '1' ,D(15) , senha_temp(15));

    MUX_16: mux_2entradas_1b port map(senha_temp(16),senha(16),senha_3,D(16));
    FF_16: ffd port map (Clock, Clear, '1' ,D(16) , senha_temp(16));

    MUX_17: mux_2entradas_1b port map(senha_temp(17),senha(17),senha_3,D(17));
    FF_17: ffd port map (Clock, Clear, '1' ,D(17) , senha_temp(17));
  
    senha_reg <= senha_temp;

end log;