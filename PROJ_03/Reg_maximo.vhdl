library ieee;
use ieee.std_logic_1164.all;

entity Reg_maximo is
    Port (
        clock,clear,load,mx_mi,step: in std_logic;
        A : in std_logic_vector(11 downto 0);
        A_reg : out std_logic_vector(11 downto 0)
    );
end Reg_maximo;

architecture log of Reg_maximo is
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

	component mux_2entradas_12b is
    	port (o0,o1: in  std_logic_vector(11 downto 0);
		key: in std_logic;
  		S: out std_logic_vector(11 downto 0)
	);
	end component mux_2entradas_12b;


signal A_temp: std_logic_vector(11 downto 0);
signal D, notD: std_logic_vector(11 downto 0);
signal key_and: std_logic;

begin

    key_and <= load and mx_mi and not(step);
    notD <= not D;

    MUX_0: mux_2entradas_1b port map(A_temp(0),A(0),key_and,D(0));
    FF_0: ffd port map (Clock,D(0),notD(0), D(0), A_temp(0));

    MUX_1: mux_2entradas_1b port map(A_temp(1),A(1),key_and,D(1));
    FF_1: ffd port map (Clock,D(1),notD(1), D(1), A_temp(1));

    MUX_2: mux_2entradas_1b port map(A_temp(2),A(2),key_and,D(2));
    FF_2: ffd port map (Clock,D(2),notD(2), D(2), A_temp(2));

    MUX_3: mux_2entradas_1b port map(A_temp(3),A(3),key_and,D(3));
    FF_3: ffd port map (Clock,D(3),notD(3), D(3), A_temp(3));

    MUX_4: mux_2entradas_1b port map(A_temp(4),A(4),key_and,D(4));
    FF_4: ffd port map (Clock,D(4),notD(4), D(4), A_temp(4));

    MUX_5: mux_2entradas_1b port map(A_temp(5),A(5),key_and,D(5));
    FF_5: ffd port map (Clock,D(5),notD(5), D(5), A_temp(5));

    MUX_6: mux_2entradas_1b port map(A_temp(6),A(6),key_and,D(6));
    FF_6: ffd port map (Clock,D(6),notD(6), D(6), A_temp(6));

    MUX_7: mux_2entradas_1b port map(A_temp(7),A(7),key_and,D(7));
    FF_7: ffd port map (Clock,D(7),notD(7), D(7), A_temp(7));

    MUX_8: mux_2entradas_1b port map(A_temp(8),A(8),key_and,D(8));
    FF_8: ffd port map (Clock,D(8),notD(8), D(8), A_temp(8));

    MUX_9: mux_2entradas_1b port map(A_temp(9),A(9),key_and,D(9));
    FF_9: ffd port map (Clock,D(9),notD(9),D(9), A_temp(9));

    MUX_10: mux_2entradas_1b port map(A_temp(10),A(10),key_and,D(10));
    FF_10: ffd port map (Clock,D(10),notD(10),D(10), A_temp(10));

    MUX_11: mux_2entradas_1b port map(A_temp(11),A(11),key_and,D(11));
    FF_11: ffd port map (Clock,D(11),notD(11),D(11), A_temp(11));

    MUX12: mux_2entradas_12b port map("100110011001",A_temp,clear,A_reg);

end log;