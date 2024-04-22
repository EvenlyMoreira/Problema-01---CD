library ieee;
use ieee.std_logic_1164.all;

entity Reg_step is
    Port (
        clock,clear,load,step : in std_logic;
        A : in std_logic_vector(3 downto 0);
        A_reg : out std_logic_vector(3 downto 0)
    );
end Reg_step;

architecture log of Reg_step is
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

	component mux_2entradas_4b is
    	port (o0,o1: in  std_logic_vector(3 downto 0);
		    key: in std_logic;
  		    S: out std_logic_vector(3 downto 0)
	    );
	end component mux_2entradas_4b;


signal A_temp: std_logic_vector(3 downto 0) := (others => '0');
signal D,notD: std_logic_vector(3 downto 0);
signal key_and: std_logic;

begin
    
    key_and <= load and step;
    notD <= not(D);

    MUX1_0: mux_2entradas_1b port map(A_temp(0),A(0),key_and,D(0));
    FF_0: ffd port map (Clock, D(0), notD(0), D(0), A_temp(0));

    MUX1_1: mux_2entradas_1b port map(A_temp(1),A(1),key_and,D(1));
    FF_1: ffd port map (Clock, D(1), notD(1), D(1), A_temp(1));

    MUX1_2: mux_2entradas_1b port map(A_temp(2),A(2),key_and,D(2));
    FF_2: ffd port map (Clock, D(2), notD(2), D(2), A_temp(2));

    MUX1_3: mux_2entradas_1b port map(A_temp(3),A(3),key_and,D(3));
    FF_3: ffd port map (Clock, D(3), notD(3), D(3), A_temp(3));

    MUX4: mux_2entradas_4b port map("0001",A_temp,clear,A_reg);

end log;