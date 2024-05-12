library ieee;
use ieee.std_logic_1164.all;

entity displays is
    port (chave,reg_senha: in  std_logic_vector(7 downto 0);
	    EF: in std_logic_vector(2 downto 0);
            dezena, unidade : out std_logic_vector(6 downto 0));
end displays;

architecture log of displays is

component bin_bcd is
    port (A_bin, B_bin, C_bin, D_bin: in  std_logic;
          A_bcd, B_bcd, C_bcd, D_bcd: out std_logic);
end component;

component display is
    port (w,x,y,z: in  std_logic;
          led: out std_logic_vector(6 downto 0));
end component;

component multiplex8b is
    port (o0,o1,o2,o3,o4,o5: in  std_logic_vector(13 downto 0);
	  key_mux: in std_logic_vector(2 downto 0);
          S1,S0: out std_logic_vector(6 downto 0));
end component multiplex8b;

signal s1,s2,s3,s5: std_logic_vector(3 downto 0);
signal s4: std_logic_vector(2 downto 0);
signal dec_chave, uni_chave,dec_reg, uni_reg: std_logic_vector(6 downto 0);
signal bcd_chave,bcd_reg: std_logic_vector(11 downto 0);
signal chave_01,reg_01: std_logic_vector(13 downto 0);

begin
  bcd_chave(0) <= chave(0);
  bcd_chave(10) <= '0';
  bcd_chave(11) <= '0';
  U1: bin_bcd port map('0',chave(7),chave(6),chave(5),s1(0),s1(1),s1(2),s1(3));
  U2: bin_bcd port map(s1(1),s1(2),s1(3),chave(4),s2(0),s2(1),s2(2),s2(3));
  U3: bin_bcd port map(s2(1),s2(2),s2(3),chave(3),s3(0),s3(1),s3(2),s3(3));
  U4: bin_bcd port map('0',s1(0),s2(0),s3(0),bcd_chave(9),s4(0),s4(1),s4(2));
  U5: bin_bcd port map(s3(1),s3(2),s3(3),chave(2),s5(0),s5(1),s5(2),s5(3));
  U6: bin_bcd port map(s4(0),s4(1),s4(2),s5(0),bcd_chave(8),bcd_chave(7),bcd_chave(6),bcd_chave(5));
  U7: bin_bcd port map(s5(1),s5(2),s5(3),chave(1),bcd_chave(4),bcd_chave(3),bcd_chave(2),bcd_chave(1));

  bcd_reg(0) <= chave(0);
  bcd_reg(10) <= '0';
  bcd_reg(11) <= '0';
  U8: bin_bcd port map('0',reg_senha(7),reg_senha(6),reg_senha(5),s1(0),s1(1),s1(2),s1(3));
  U9: bin_bcd port map(s1(1),s1(2),s1(3),reg_senha(4),s2(0),s2(1),s2(2),s2(3));
  U10: bin_bcd port map(s2(1),s2(2),s2(3),reg_senha(3),s3(0),s3(1),s3(2),s3(3));
  U11: bin_bcd port map('0',s1(0),s2(0),s3(0),bcd_reg(9),s4(0),s4(1),s4(2));
  U12: bin_bcd port map(s3(1),s3(2),s3(3),reg_senha(2),s5(0),s5(1),s5(2),s5(3));
  U13: bin_bcd port map(s4(0),s4(1),s4(2),s5(0),bcd_reg(8),bcd_reg(7),bcd_reg(6),bcd_reg(5));
  U14: bin_bcd port map(s5(1),s5(2),s5(3),reg_senha(1),bcd_reg(4),bcd_reg(3),bcd_reg(2),bcd_reg(1));

  U15: display port map(bcd_chave(3),bcd_chave(2),bcd_chave(1),bcd_chave(0),uni_chave);  
  U16: display port map(bcd_chave(3),bcd_chave(2),bcd_chave(1),bcd_chave(0),dec_chave); 

  U17: display port map(bcd_reg(3),bcd_reg(2),bcd_reg(1),bcd_reg(0),uni_reg);  
  U18: display port map(bcd_reg(3),bcd_reg(2),bcd_reg(1),bcd_reg(0),dec_reg); 

  chave_01 <= (dec_chave(6),dec_chave(5),dec_chave(4),dec_chave(3),dec_chave(2),dec_chave(1),dec_chave(0),uni_chave(6),uni_chave(5),uni_chave(4),uni_chave(3),uni_chave(2),uni_chave(1),uni_chave(0));
  reg_01 <= (dec_reg(6),dec_reg(5),dec_reg(4),dec_reg(3),dec_reg(2),dec_reg(1),dec_reg(0),uni_reg(6),uni_reg(5),uni_reg(4),uni_reg(3),uni_reg(2),uni_reg(1),uni_reg(0));
  mux: multiplex8b port map("00000000000000","00000000000000",chave_01,reg_01,"00000010000001","10010011001001",EF,dezena,unidade);

end log;
