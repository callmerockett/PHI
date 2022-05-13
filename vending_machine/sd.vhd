library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity sd is
	port(
        -- INPUT
        i_clock : in std_logic;
        i_reset : in std_logic;
        i_value : in std_logic_vector(7 downto 0);  -- a
        i_price : in std_logic_vector(7 downto 0);  -- S
        i_button: in std_logic;                     -- c

        -- OUTPUT
        o_released_item : out std_logic -- d
	);
end sd;

architecture estrutura of sd is

component bo
	port(
        i_clock             : in std_logic;
        i_reset             : in std_logic;
        i_value             : in std_logic_vector(7 downto 0);
        i_price             : in std_logic_vector(7 downto 0);
        i_enable_value      : in std_logic;
        i_enable_release    : in std_logic;
        o_release           : out std_logic;
        o_released_item     : out std_logic
    );
end component;

component bc
	port(
		i_clock             : in std_logic;
		i_reset             : in std_logic;
		i_button            : in std_logic;
		i_released          : in std_logic;
		o_enable_release    : out std_logic;
		o_enable_value      : out std_logic
	);
end component;
	signal w_RELEASED : std_logic;
	signal w_ENABLE_RELEASE : std_logic;
	signal w_ENABLE_VALUE : std_logic;
	signal w_SAIDAITEM : std_logic;
begin 

BC_INST : bc
port map(  
    i_clock 			=> i_clock,
    i_reset 			=> i_reset,
    i_button 			=> i_button,
    i_released			=> w_RELEASED,
    o_enable_value 	    => w_ENABLE_VALUE,
    o_enable_release    => w_ENABLE_RELEASE
);
	
BO_INST : bo
port map(
    i_clock 			=> i_clock,
    i_reset	   		    => i_reset,
    i_value 			=> i_value,
    i_price 			=> i_price,
    i_enable_value 	    => w_ENABLE_VALUE,  
    i_enable_release    => w_ENABLE_RELEASE,
    o_release 			=> w_RELEASED,
    o_released_item 	=> o_released_item 
);

end estrutura;
