library ieee;
use ieee.std_logic_1164.all;

entity Reg_valor is
    Port (
        clock,clear: in std_logic;
        valor : in std_logic_vector(11 downto 0);
        valor_reg : out std_logic_vector(11 downto 0)
    );
end Reg_valor;

architecture log of Reg_valor is
	component ffd is
   	port (ck, clr, set, d : in  std_logic;
                        q : out std_logic
	);
	end component ffd;
    
signal notValor : STD_LOGIC_VECTOR (11 downto 0); 
    
begin

    FF_00: ffd port map (Clock, Clear, '1', valor(0), valor_reg(0));
    FF_01: ffd port map (Clock, Clear, '1', valor(1), valor_reg(1));
    FF_02: ffd port map (Clock, Clear, '1', valor(2), valor_reg(2));
    FF_03: ffd port map (Clock, Clear, '1', valor(3), valor_reg(3));
    FF_04: ffd port map (Clock, Clear, '1', valor(4), valor_reg(4));
    FF_05: ffd port map (Clock, Clear, '1', valor(5), valor_reg(5));
    FF_06: ffd port map (Clock, Clear, '1', valor(6), valor_reg(6));
    FF_07: ffd port map (Clock, Clear, '1', valor(7), valor_reg(7));
    FF_08: ffd port map (Clock, Clear, '1', valor(8), valor_reg(8));
    FF_09: ffd port map (Clock, Clear, '1', valor(9), valor_reg(9));
    FF_10: ffd port map (Clock, Clear, '1', valor(10), valor_reg(10));
    FF_11: ffd port map (Clock, Clear, '1', valor(11), valor_reg(11));

end log;