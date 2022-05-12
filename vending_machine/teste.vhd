library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
entity teste is
end teste;

architecture estrutura of teste is

component bo
	port(
        i_clock : in std_logic;
        i_reset : in std_logic;
        i_value : in std_logic_vector(7 downto 0); -- a
        i_price : in std_logic_vector(7 downto 0); -- S
        i_enable_value      : in std_logic;
        i_enable_release    : in std_logic;

        o_release : out std_logic;
        o_released_item : out std_logic -- d
    );
end component;

component bc
	port(
		--ENTRADAs/Saídas possiveis
		i_clock : in std_logic; -- tempo de operção
		i_reset : in std_logic;
		i_button : in std_logic; -- Ativador do bloco
		i_released : in std_logic; -- Status
		o_enable_release : out  std_logic;
		o_enable_value : out std_logic
	);
end component;

	signal r_CLK : std_logic := '0';
	signal r_RESET : std_logic := '0';
	signal r_BUTTON : std_logic := '0';
	signal w_RELEASED : std_logic := '0';
	signal w_ENABLE_RELEASE : std_logic := '0';
	signal w_ENABLE_VALUE : std_logic := '0';
	signal r_VALOR : std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(2, 8));
	signal r_PRECO : std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(10, 8));
	signal w_SAIDAITEM : std_logic := '0';
begin 
-- Período de clock 10ns = 100MHz frequência a  
 r_CLK <= not r_CLK after 5 ns;
 r_BUTTON <= not r_BUTTON after 3 ns;
 r_RESET <= '0' after 5 ns;


    BC_INST : bc
	port map(  
		i_clock => r_CLK,
		i_reset => r_RESET,
		i_button => r_BUTTON,
		i_released => w_RELEASED,
		o_enable_release => w_ENABLE_RELEASE,
		o_enable_value => w_ENABLE_VALUE
	);
	
    BO_INST : bo
	port map(
        i_clock => r_CLK,
        i_reset => r_RESET,
        i_value => r_VALOR,
        i_price => r_PRECO,
        i_enable_value => w_ENABLE_VALUE,  
        i_enable_release => w_ENABLE_RELEASE,
        o_release => w_RELEASED,
        o_released_item => w_SAIDAITEM
	);

end estrutura;
