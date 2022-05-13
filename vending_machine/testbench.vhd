library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

architecture behavior of testbench is

component sd
    port(
        i_clock         : in std_logic;
        i_reset         : in std_logic;
        i_value         : in std_logic_vector(7 downto 0);  
        i_price         : in std_logic_vector(7 downto 0);  
        i_button        : in std_logic;                
        o_released_item : out std_logic 
    );
end component;

signal r_CLK        : std_logic := '0';
signal r_RESET 	    : std_logic := '1';
signal r_BUTTON     : std_logic := '0'; 
signal r_VALOR 	    : std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(2, 8));
signal r_PRECO 	    : std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(11, 8));
signal w_SAIDAITEM  : std_logic;

begin

r_CLK <= not r_CLK after 5 ns;
r_BUTTON <= not r_BUTTON after 3 ns;
r_RESET <= '0' after 5 ns;

SD_INST : sd
    port map(
        i_clock             => r_CLK,
        i_reset             => r_RESET,
        i_button            => r_BUTTON,
        i_value             => r_VALOR,
        i_price             => r_PRECO,
        o_released_item     => w_SAIDAITEM
    );
end behavior;
