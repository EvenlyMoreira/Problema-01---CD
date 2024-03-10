library ieee;
use ieee.std_logic_1164.all;

entity ckt is
    port (v: in std_logic_vector (0 to 3);
            s1,s2,s3,s4,s5: out std_logic_vector (0 to 2));
end ckt;

architecture log of ckt is

component C1 is
    port (w,x,y,z: in  std_logic;
            A,B,C: out std_logic);
end component;

component C2 is
    port (w,x,y,z: in  std_logic;
            D,E,F: out std_logic);
end component;

component C3 is
    port (w,x,y,z: in  std_logic;
            G,H,I: out std_logic);
end component;

component C4 is
    port (w,x,y,z: in  std_logic;
            J,K,L: out std_logic);
end component;

component C5 is
    port (w,x,y,z: in  std_logic;
            M,N,O: out std_logic);
end component;

begin
  U1: C1 port map(v(0),v(1),v(2),v(3),s1(0),s1(1),s1(2));
  U2: C2 port map(v(0),v(1),v(2),v(3),s2(0),s2(1),s2(2));
  U3: C3 port map(v(0),v(1),v(2),v(3),s3(0),s3(1),s3(2));
  U4: C4 port map(v(0),v(1),v(2),v(3),s4(0),s4(1),s4(2));
  U5: C5 port map(v(0),v(1),v(2),v(3),s5(0),s5(1),s5(2));
end log;