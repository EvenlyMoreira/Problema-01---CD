library ieee;
use ieee.std_logic_1164.all;

entity ME is  --máquina de estados
    Port (
        clock,clear: in std_logic;
        set,load,comparacao,senha3,lim5,lim20 : in std_logic;
	EA: out std_logic_vector(2 downto 0) --estado atual 
    );
end ME;

architecture log of ME is
	component ffd is
   	port (ck, clr, set, d : in  std_logic;
                       q : out std_logic
	);
	end component ffd;

signal n: std_logic_vector(2 downto 0);
signal s: std_logic_vector(2 downto 0) := "000";

begin

    n(0) <= (not(s(2)) and (not(s(1)) or s(1)) and not(s(0)) and set) or (not(s(2)) and s(1)
    and not(s(0)) and load) or ((not(s(2)) or s(2)) and not(s(1)) and s(0) and not(lim5)) or 
   (not(s(2)) and s(1) and s(0) and  not(senha3) and not(lim5));
 
    n(1) <= (not(s(2)) and not(s(1)) and s(0) and lim5) or (not(s(2)) and s(1) and not(s(0)) 
    and not(set)) or (not(s(2)) and s(1) and s(0) and not(senha3));

    n(2) <= (not(s(2)) and s(1) and not(s(0)) and set) or (not(s(2)) and s(1) and s(0) and
    comparacao and senha3) or (s(2) and not(s(1)) and (not(s(0))or s(0)) and not(lim5));
				

    FF_0: ffd port map (clock, clear, '1', n(0), s(0));

    FF_1: ffd port map (clock, clear, '1', n(1), s(1));

    FF_2: ffd port map (clock, clear, '1', n(2), s(2));

    EA <= s;

end log;
