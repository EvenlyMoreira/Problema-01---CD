LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity MAIN is
    PORT(
	A0   : IN std_logic_vector (3 downto 0);
        A1   : IN std_logic_vector (3 downto 0);
        A2   : IN std_logic_vector (3 downto 0);
        STEP   : IN std_logic;
	UP_DOWN : IN std_logic;
        MX_MI : IN std_logic;
        LOAD : IN std_logic;
        CLR : IN std_logic;
        CLOCK : IN std_logic;
        LED_MX_MI: OUT std_logic;
        LED_CK : OUT std_logic;
        Q0  : OUT std_logic_vector (6 downto 0);
        Q1  : OUT std_logic_vector (6 downto 0);
        Q2  : OUT std_logic_vector (6 downto 0)
    );
end entity;

architecture logic of MAIN is 
   
    component  somador IS
        PORT(
            A_somador       : IN std_logic;
            P_somador       : IN std_logic;
            C_IN_somador    : IN std_logic;
	    O_somador       : OUT std_logic;
            C_OUT_somador   : OUT std_logic
        );
    END component somador;

    component  subtrator IS
        PORT(
	    A_subtrator     : IN std_logic;
            P_subtrator     : IN std_logic;
            C_IN_subtrator  : IN std_logic;
            O_subtrator     : OUT std_logic;
            C_OUT_subtrator : OUT std_logic
        );
    END component subtrator;

    component mux_2entradas_4b is
        port (
            o0,o1: in  std_logic_vector(3 downto 0);
            key: in std_logic;
            S: out std_logic_vector(3 downto 0)
    );
    end component mux_2entradas_4b;

    component mux_2entradas_12b is
    port (o0,o1: in  std_logic_vector(11 downto 0);
	        key: in std_logic;
            S: out std_logic_vector(11 downto 0)
    );
    end component mux_2entradas_12b;

    component Reg_valor is
        Port (
            clock,clear: in std_logic;
            valor : in std_logic_vector(11 downto 0);
            valor_reg : out std_logic_vector(11 downto 0)
        );
    end component Reg_valor;

    component  Reg_step is
        Port (
            clock,clear,load,step : in std_logic;
            A : in std_logic_vector(3 downto 0);
            A_reg : out std_logic_vector(3 downto 0)
        );
    end component  Reg_step;

    component ck_div is
        port (ck_in : in  std_logic;
              ck_out: out std_logic);
     end component ck_div; 

    component Reg_maximo is
        Port (
            clock,clear,load,mx_mi,step: in std_logic;
            A : in std_logic_vector(11 downto 0);
            A_reg : out std_logic_vector(11 downto 0)
        );
    end component Reg_maximo;
    
    component Reg_minimo is
        Port (
            clock,clear,load,mx_mi,step : in std_logic;
            A : in std_logic_vector(11 downto 0);
            A_reg : out std_logic_vector(11 downto 0)
        );
    end component Reg_minimo;

    component D7_seg IS
    PORT(
            SW      : in std_logic_vector (3 downto 0);
            HEX     : out std_logic_vector (6 downto 0)
    );
    END component D7_seg;


    component comparador_maior IS
    PORT(
        uni,dez,cen : in  std_logic_vector (3 downto 0);
        step : in std_logic_vector (3 downto 0);
        nova_uni, nova_dez, nova_dezena, nova_cen : out std_logic_vector (3 downto 0)
    );
    end component comparador_maior;

    component comparador is
    port (x,y: in  std_logic_vector(11 downto 0);
          maior_igual: out std_logic
    );
    end component comparador;
    
     
    signal A_bcd,A_regmax,A_regmin: std_logic_vector (11 downto 0);
    signal CK,max_maior_igual,min_maior_igual : std_logic;
    signal passo , mux_passo: std_logic_vector (3 downto 0);
    signal valor_new: std_logic_vector (11 downto 0) := (others => '0');

    signal O_somador_uni,C_out_uni_som, O_soma_uni,C_out_uni_soma:  std_logic_vector (3 downto 0);
    signal O_subtrator_uni, C_out_uni_sub : std_logic_vector (3 downto 0); 

    signal O_somador_dez,C_out_dez_som, O_soma_dez,C_out_dez_soma:  std_logic_vector (3 downto 0);

    signal O_somador_cen,C_out_cen_som, O_soma_cen,C_out_cen_soma:  std_logic_vector (3 downto 0);

    signal dezenas_soma_uni,dezenas_soma_dez,dezenas_soma_cen: std_logic;
    signal valor_new_uni, valor_new_dez, valor_new_cen :std_logic_vector (3 downto 0);
    signal uni_new, dez_new, cen_new : std_logic_vector (3 downto 0);

    signal soma10_uni, soma10_dez, sub1_dez, sub1_cen :std_logic_vector (3 downto 0);
	
    signal key_step : std_logic;
    signal somador1,subtrator1,valorBCD : std_logic_vector (11 downto 0);


    begin 
        
        A_bcd <= (A2(3),A2(2),A2(1),A2(0),A1(3),A1(2),A1(1),A1(0),A0(3),A0(2),A0(1),A0(0));

        CK_D: ck_div port map (CLOCK, CK);
        LED_CK <= CK;

        R_step: Reg_step port map (CK,CLR,LOAD,STEP,A0,passo);
        R_max : Reg_maximo port map (CK,CLR,LOAD,MX_MI,STEP,A_bcd,A_regmax);
        R_min : Reg_minimo port map (CK,CLR,LOAD,MX_MI,STEP,A_bcd,A_regmin);

        valor_new_uni <=(valor_new(3),valor_new(2),valor_new(1),valor_new(0));
        valor_new_dez <=(valor_new(7),valor_new(6),valor_new(5),valor_new(4));
        valor_new_cen<=(valor_new(11),valor_new(10),valor_new(9),valor_new(8));

         
	Som_unid0 : somador port map (valor_new_uni(0),mux_passo(0),'0',O_somador_uni(0),C_out_uni_som(0));
        Som_unid1 : somador port map (valor_new_uni(1),mux_passo(1),C_out_uni_som(0),O_somador_uni(1),C_out_uni_som(1));
        Som_unid2 : somador port map (valor_new_uni(2),mux_passo(2),C_out_uni_som(1),O_somador_uni(2),C_out_uni_som(2));
        Som_unid3 : somador port map (valor_new_uni(3),mux_passo(3),C_out_uni_som(2),O_somador_uni(3),C_out_uni_som(3));
        
        dezenas_soma_uni <= (O_somador_uni(3) and O_somador_uni(2)) or (O_somador_uni(3) and O_somador_uni(1)) or C_out_uni_som(3) ;
        Soma_u1 : somador port map ('0',O_somador_uni(0),'0',O_soma_uni(0),C_out_uni_soma(0));
        Soma_u2 : somador port map (dezenas_soma_uni,O_somador_uni(1),C_out_uni_soma(0),O_soma_uni(1),C_out_uni_soma(1));
        Soma_u3 : somador port map (dezenas_soma_uni,O_somador_uni(2),C_out_uni_soma(1),O_soma_uni(2),C_out_uni_soma(2));
        Soma_u4 : somador port map ('0',O_somador_uni(3),C_out_uni_soma(2),O_soma_uni(3),C_out_uni_soma(3));

        
        Som_dez0 : somador port map (valor_new_dez(0),C_out_uni_soma(3),'0',O_somador_dez(0),C_out_dez_som(0));
        Som_dez1 : somador port map (valor_new_dez(1),'0',C_out_dez_som(0),O_somador_dez(1),C_out_dez_som(1));
        Som_dez2 : somador port map (valor_new_dez(2),'0',C_out_dez_som(1),O_somador_dez(2),C_out_dez_som(2));
        Som_dez3 : somador port map (valor_new_dez(3),'0',C_out_dez_som(2),O_somador_dez(3),C_out_dez_som(3));
            
        dezenas_soma_dez <= (O_somador_dez(3) and O_somador_dez(2)) or (O_somador_dez(3) and O_somador_dez(1)) or C_out_dez_som(3) ;
        Soma_d1 : somador port map ('0',O_somador_dez(0),'0',O_soma_dez(0),C_out_dez_soma(0));
        Soma_d2 : somador port map (dezenas_soma_dez,O_somador_dez(1),C_out_dez_soma(0),O_soma_dez(1),C_out_dez_soma(1));
        Soma_d3 : somador port map (dezenas_soma_dez,O_somador_dez(2),C_out_dez_soma(1),O_soma_dez(2),C_out_dez_soma(2));
        Soma_d4 : somador port map ('0',O_somador_dez(3),C_out_dez_soma(2),O_soma_dez(3),C_out_dez_soma(3));
        
        Som_cen0 : somador port map (valor_new_cen(0),C_out_dez_soma(3),'0',O_somador_cen(0),C_out_cen_som(0));
        Som_cen1 : somador port map (valor_new_cen(1),'0',C_out_cen_som(0),O_somador_cen(1),C_out_cen_som(1));
        Som_cen2 : somador port map (valor_new_cen(2),'0',C_out_cen_som(1),O_somador_cen(2),C_out_cen_som(2));
        Som_cen3 : somador port map (valor_new_cen(3),'0',C_out_cen_som(2),O_somador_cen(3),C_out_cen_som(3));
            
        dezenas_soma_cen <= (O_somador_cen(3) and O_somador_cen(2)) or (O_somador_cen(3) and O_somador_cen(1)) or C_out_cen_som(3) ;
        Soma_c1 : somador port map ('0',O_somador_cen(0),'0',O_soma_cen(0),C_out_cen_soma(0));
        Soma_c2 : somador port map (dezenas_soma_cen,O_somador_cen(1),C_out_cen_soma(0),O_soma_cen(1),C_out_cen_soma(1));
        Soma_c3 : somador port map (dezenas_soma_cen,O_somador_cen(2),C_out_cen_soma(1),O_soma_cen(2),C_out_cen_soma(2));
        Soma_c4 : somador port map ('0',O_somador_cen(3),C_out_cen_soma(2),O_soma_cen(3),C_out_cen_soma(3));
        

        Comparador_sub : comparador_maior port map (valor_new_uni,valor_new_dez,valor_new_cen,mux_passo,soma10_uni, sub1_dez,soma10_dez, sub1_cen); 

        Sub_unid0 : subtrator port map (soma10_uni(0),mux_passo(0),'0',O_subtrator_uni(0),C_out_uni_sub(0));
        Sub_unid1 : subtrator port map (soma10_uni(1),mux_passo(1),C_out_uni_sub(0),O_subtrator_uni(1),C_out_uni_sub(1));
        Sub_unid2 : subtrator port map (soma10_uni(2),mux_passo(2),C_out_uni_sub(1),O_subtrator_uni(2),C_out_uni_sub(2));
        Sub_unid3 : subtrator port map (soma10_uni(3),mux_passo(3),C_out_uni_sub(2),O_subtrator_uni(3),C_out_uni_sub(3));

	somador1 <= (O_somador_cen(3),O_somador_cen(2),O_somador_cen(1),O_somador_cen(0),O_somador_dez(3),O_somador_dez(2),O_somador_dez(1),O_somador_dez(0),O_soma_uni(3),O_soma_uni(2),O_soma_uni(1),O_soma_uni(0));
	subtrator1 <= (sub1_cen(3),sub1_cen(2),sub1_cen(1),sub1_cen(0),sub1_dez(3),sub1_dez(2),sub1_dez(1),sub1_dez(0),O_subtrator_uni(3),O_subtrator_uni(2),O_subtrator_uni(1),O_subtrator_uni(0));
	MUX_ud: mux_2entradas_12b port map(subtrator1,somador1,up_down,valorBCD);
        R_valor: Reg_valor port map (CLOCK,CLR,valorBCD,valor_new);

        comparador_max : comparador port map (valor_new,A_regmax,max_maior_igual);
        comparador_min : comparador port map (A_regmin,valor_new,min_maior_igual);
        MUX4b_s : mux_2entradas_4b port map (passo,"0000",key_step,mux_passo);  

        key_step <= (max_maior_igual and UP_DOWN) or (min_maior_igual and not(UP_DOWN));
        LED_MX_MI <= NOT (key_step);
        
        uni_new <= (valor_new(3),valor_new(2),valor_new(1),valor_new(0));
        dez_new <= (valor_new(7),valor_new(6),valor_new(5),valor_new(4));
        cen_new <= (valor_new(11),valor_new(10),valor_new(9),valor_new(8));

        D7_uni : D7_seg port map (uni_new,Q0);
        D7_dez : D7_seg port map (dez_new,Q1);
        D7_cen : D7_seg port map (cen_new,Q2);
 

end logic;