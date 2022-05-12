library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity bc is
	port(
		--ENTRADAs/Saídas possiveis
		i_clock : in std_logic; -- tempo de operção
		i_reset : in std_logic;
		i_button : in std_logic; -- Ativador do bloco
		i_released : in std_logic; -- Status
		o_enable_release : out  std_logic;
		o_enable_value : out std_logic
	);
end bc;

architecture funcionalidades of bc is
	type t_estado is (ENTRADA,ARMAZENA,COMPARA,LIBERA);
	signal r_NXT_STATE : t_estado := ENTRADA;
	signal r_STATE : t_estado := ENTRADA;

begin
--Circuito Combinacional Prox Estado
	r_NXT_STATE_logic : process(r_STATE,i_button,i_released)
	begin
		case r_STATE is
			when ENTRADA =>
				if i_button = '1' then
					r_NXT_STATE <= ARMAZENA;
				else
					r_NXT_STATE <= ENTRADA;
				end if;
				
			when ARMAZENA =>
				r_NXT_STATE <= COMPARA;
				
			when COMPARA =>
				if i_released = '1' then
					r_NXT_STATE <= LIBERA;
				else 
					r_NXT_STATE <= ENTRADA;
				end if;
			when others =>
					r_NXT_STATE <= ENTRADA;
		end case;
	end process;
	
--Inicio registrador
	-- Set prox estado
registrador_estado : process(i_clock, i_reset)
	begin
		if i_reset = '1' then
			r_STATE <= ENTRADA;
		elsif rising_edge(i_clock) then
			r_STATE <= r_NXT_STATE;
		end if;
	end process;
	
	
-- Circuito combinacional das minhas saidas

logica_saida : process(r_STATE)
	begin
		case r_STATE is
			when ENTRADA =>
				o_enable_release <= '0';
				o_enable_value <= '0';
			when ARMAZENA =>
				o_enable_release <= '0';
				o_enable_value <= '1';
			when COMPARA =>
				o_enable_release <= '1';
				o_enable_value <= '0';
			when LIBERA =>
				o_enable_release <= '0';
				o_enable_value <= '0';
			when others =>
				o_enable_release <= '0';
				o_enable_value <= '0';
		end case;
	end process;
--Fim da arquitetura do contadorMoedasBCBO
end architecture;
