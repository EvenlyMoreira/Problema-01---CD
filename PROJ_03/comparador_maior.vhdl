LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY comparador_maior IS
PORT(
        uni,dez,cen : in  std_logic_vector (3 downto 0);
        step : in std_logic_vector (3 downto 0);
        nova_uni, nova_dez, nova_dezena, nova_cen : out std_logic_vector (3 downto 0)
    );
end entity;

    ARCHITECTURE MAIN OF comparador_maior IS

    component mux_2entradas_4b is
        port (o0,o1: in  std_logic_vector(3 downto 0);
          key: in std_logic;
              S: out std_logic_vector(3 downto 0)
    );
    end component mux_2entradas_4b;

    component somador IS
        PORT(
	A_somador       : IN std_logic;
        P_somador       : IN std_logic;
        C_IN_somador    : IN std_logic;
	O_somador       : OUT std_logic;
        C_OUT_somador   : OUT std_logic
);
        END component somador;

        component subtrator IS
        PORT(
	A_subtrator     : IN std_logic;
        P_subtrator     : IN std_logic;
        C_IN_subtrator  : IN std_logic;
	O_subtrator     : OUT std_logic;
        C_OUT_subtrator : OUT std_logic
        );
        END component subtrator;


     signal maior_uni, maior_dez, P_and : std_logic;
     signal soma_10_uni, sub_01_dez, soma_10_dez, sub_01_cen, nova_dez1, sub_01uni, sub_01cen: std_logic_vector (3 downto 0);
     signal cout_sub_uni, cout_sub_cen,cout_som_uni, cout_som_cen : std_logic_vector(3 downto 0);

begin 
        maior_uni <= (not(uni(3)) and step(3)) or 
        ((uni(3) xnor step(3)) and not(uni(2)) and step(2)) or 
        ((uni(3) xnor step(3)) and (uni(2) xnor step(2)) and  not(uni(1)) and step(1)) or 
        ((uni(3) xnor step(3)) and (uni(2) xnor step(2)) and  (uni(1) xnor step(1)) and  not(uni(0)) and step(0));
       
        maior_dez<= (not(dez(3)) and '0') or 
        ((dez(3) xnor '0') and not(dez(2)) and '0' ) or 
        ((dez(3) xnor '0') and (dez(2) xnor '0') and  not(dez(1)) and '0') or 
        ((dez(3) xnor '0') and (dez(2) xnor '0') and  (dez(1) xnor '0') and  not(dez(0)) and '1');
        
        Mux_soma10_uni : mux_2entradas_4b port map ("0000","1010",maior_uni,soma_10_uni);
        Mux_sub01_dez: mux_2entradas_4b port map ("0000","0001",maior_uni,sub_01_dez);
        
        soma10_0_uni :  somador port map(uni(0),soma_10_uni(0),'0',nova_uni(0),cout_som_uni(0));
        soma10_1_uni :  somador port map(uni(1),soma_10_uni(1),cout_som_uni(0),nova_uni(1),cout_som_uni(1));
        soma10_2_uni :  somador port map(uni(2),soma_10_uni(2),cout_som_uni(1),nova_uni(2),cout_som_uni(2));
        soma10_3_uni :  somador port map(uni(3),soma_10_uni(3),cout_som_uni(2),nova_uni(3),cout_som_uni(3));

        sub_01_0_dez : subtrator port map(dez(0),sub_01_dez(0),'0',nova_dez1(0),cout_sub_uni(0));
        sub_01_1_dez : subtrator port map(dez(1),sub_01_dez(1),cout_sub_uni(0),nova_dez1(1),cout_sub_uni(1));
        sub_01_2_dez : subtrator port map(dez(2),sub_01_dez(2),cout_sub_uni(1),nova_dez1(2),cout_sub_uni(2));
        sub_01_3_dez : subtrator port map(dez(3),sub_01_dez(3),cout_sub_uni(2),nova_dez1(3),cout_sub_uni(3));
	nova_dez <= nova_dez1;
	
	P_and <= maior_dez and maior_uni;
        Mux_soma10_dez : mux_2entradas_4b port map ("0000","1010",P_and,soma_10_dez);
        Mux_sub01_cen: mux_2entradas_4b port map ("0000","0001",P_and,sub_01_cen);

        soma10_0_dez :  somador port map(nova_dez1(0),soma_10_dez(0),'0',nova_dezena(0),cout_som_cen(0));
        soma10_1_dez :  somador port map(nova_dez1(1),soma_10_dez(1),cout_som_cen(0),nova_dezena(1),cout_som_cen(1));
        soma10_2_dez :  somador port map(nova_dez1(2),soma_10_dez(2),cout_som_cen(1),nova_dezena(2),cout_som_cen(2));
        soma10_3_dez :  somador port map(nova_dez1(3),soma_10_dez(3),cout_som_cen(2),nova_dezena(3),cout_som_cen(3));

        sub_01_0_cen: subtrator port map(cen(0),sub_01_cen(0),'0',nova_cen(0),cout_sub_cen(0));
        sub_01_1_cen: subtrator port map(cen(1),sub_01_cen(1),cout_sub_cen(0),nova_cen(1),cout_sub_cen(1));
        sub_01_2_cen: subtrator port map(cen(2),sub_01_cen(2),cout_sub_cen(1),nova_cen(2),cout_sub_cen(2));
        sub_01_3_cen: subtrator port map(cen(3),sub_01_cen(3),cout_sub_cen(2),nova_cen(3),cout_sub_cen(3));
    
        end architecture;