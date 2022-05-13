--Escopo de teste
entity teste is
	 port(
	 );
end teste;
	--Primeiro Caso = Atinge a quantidade e já libera
	signal r_PRECO : std_logic_vector(7 downto 0):= '01100100'; -- 1 real
	type moedas_colocadas is array (0 to 7) of integer;
	constant moedas : moedas_colocadas := (5,10,25,50,10) -- Apenas Libera
	--Segundo Caso = Atinge a quantidade e supera
	signal r_PRECO : std_logic_vector(7 downto 0):= '01100100'; -- 1 real
	type moedas_colocadas is array (0 to 7) of integer;
	constant moedas : moedas_colocadas := (5,10,25,50,10,25,10,5) -- Libera e Sobra moeda
	-- Terceiro Caso = Não atinge a quantidade
	signal r_PRECO : std_logic_vector(7 downto 0):= '01100100'; -- 1 real
	type moedas_colocadas is array (0 to 7) of integer;
	constant moedas : moedas_colocadas := (10,10,50) -- Não Libera
	
	