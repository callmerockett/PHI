library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity machine is
    port(
        i_clock : in std_logic;
        i_reset : in std_logic;

        -- Data
        i_value : in std_logic_vector(7 downto 0); -- a
        i_price : in std_logic_vector(7 downto 0); -- S

        -- Control signals
        i_enable_value      : in std_logic;
        i_enable_release    : in std_logic;

        -- Status Signal
        o_release : out std_logic;
        
        -- Output
        o_released_item : out std_logic -- d
    );
end machine;

architecture behave of machine is
    signal r_ACC : std_logic_vector(7 downto 0) := (others => '0');

begin
    
    p_DATA_PATH : process (i_clock) is
    begin
        if rising_edge(i_clock) then
            if (i_reset = '0') then
                r_ACC <= (others => '0');
                o_release <= '0';
                o_released_item <= '0';
            else
                -- Add new value to accumulated 
                if (i_enable_value = '1') then
                    r_ACC <= std_logic_vector(unsigned(r_ACC) + unsigned(i_value));
                end if;

                -- Comparison between accumulated value and item's price
                if (r_ACC >= i_price) then
                    r_ACC <= (others => '0');
                    o_release <= '1';
                    o_released_item <= '0';
                end if;
                
                -- Release item
                if (i_enable_release = '1') then 
                    -- r_ACC <= (others => '0');
                    o_release <= '0';
                    o_released_item <= '1';
                end if;
            end if;
        end if;
    end process;
end behave;
