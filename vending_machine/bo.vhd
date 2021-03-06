library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bo is
    port(
        i_clock : in std_logic;
        i_reset : in std_logic;

        -- Data
        i_value : in std_logic_vector(7 downto 0); -- a
        i_price : in std_logic_vector(7 downto 0); -- S

        -- Control signals
        i_enable_value      : in std_logic; -- habilita o registro da soma
        i_enable_release    : in std_logic; -- indica que o item pode ser liberado

        -- Status Signal
        o_release : out std_logic; -- o valor da comparação é verdadeiro
        
        -- Output
        o_released_item : out std_logic 
    );
end bo;

architecture behave of bo is
    signal r_ACC : std_logic_vector(7 downto 0) := (others => '0'); -- acumula valores
    -- signal r_D : std_logic := '0'; -- guarda resultado da comparação
begin
    p_SUM_COMP_RELEASE : process (i_clock, i_reset) is
    begin
        if rising_edge(i_clock) then
            if (i_reset = '1') then
                r_ACC <= (others => '0');
                o_release <= '0';
                o_released_item <= '0';
            elsif (i_enable_value = '1') then -- state=ARMAZENA
                r_ACC <= std_logic_vector(unsigned(r_ACC) + unsigned(i_value));
                o_released_item <= '0';
            elsif (i_enable_release = '1') then -- state=LIBERA
                r_ACC <= (others => '0');
                o_release <= '0';
                o_released_item <= '1';
            else --state=ENTRADA|COMPARA
                o_released_item <= '0';
                if (unsigned(r_ACC) >= unsigned(i_price)) then --combinational logic
                    o_release <= '1';
                else 
                    o_release <= '0';
                end if;
            end if;
        end if;
    end process;
end behave;
