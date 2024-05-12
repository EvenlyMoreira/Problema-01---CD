library ieee;
use ieee.std_logic_1164.all;

entity demux_led is
    port (key: in std_logic_vector(2 downto 0);
          S0,S1,S2,S3,S4,S5: out std_logic);
end demux_led;

architecture log of demux_led is

begin

    S0 <= not(key(2)) and not(key(1)) and not(key(0)) and '1';
    S1 <= not(key(2)) and not(key(1)) and key(0) and '1';
    S2 <= not(key(2)) and key(1) and not(key(0)) and '1';
    S3 <= not(key(2)) and key(1) and key(0) and '1';
    S4 <= key(2) and not(key(1)) and not(key(0)) and '1';
    S5 <= key(2) and not(key(1)) and key(0) and '1';

end log;
