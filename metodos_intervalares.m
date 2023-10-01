clear; clc; close all; % limpa as variaves e texto do ambiente

function busca_incremental(func,xmin,xmax,ns)
t0 = clock ();
	
	printf("===============METODO_DA_BUSCA_INCREMENTAL===============\n")

	% Se nenhum subintervalo foi encontrado, xb = [].
	% Busca incremental
	
	x = linspace(xmin,xmax,ns);
	nb = 0; xb = []; %xb é nulo a menos que seja detectada mudança de sinal
	f = func(x);
	iter = 0; %variavel usada para contar as iteracoes

	for k = 1:length(x)-1
		if [sign(f(k)) ~= sign(f(k+1))] %verifica se há mudança de sinal
			nb = nb + 1;
			xb(nb,1) = x(k);
			xb(nb,2) = x(k+1);
			printf("Subintervalo %d: %.7f | %.7f\n", nb, x(k), x(k+1));
		endif;
		iter = iter + 1;
	end;
	if isempty(xb) %exibe que nenhum subintervalo foi encontrado
		printf("Nenhum intervalo encontrado!");
	else
		printf("Numero de subintervalos: %d\nNumero de iteracoes: %d\n",nb,iter+1);
	endif;
	runtime = etime (clock (), t0);
	printf("Runtime: %.10f\n",runtime)
endfunction;

function bisseccao(func,xl,xu,es)
t0 = clock ();

	printf("===============METODO_DA_BISSECCAO===============\n")

	iter = 0; xr =  xl; ea = 100;

	while [ea >= es] % roda enquanto o erro aproximado eh menor q o criterio de parada

		printf("Aproximação:%.10f | xl:%0.5f|xr=%0.5f|xu=%0.5f |Iteração:%d | ea:%.5f(0,00005)\n",xr,xl,xr,xu,iter,ea)

		xr_velho = xr; % usado para calcular o erro aprixmado

		xr = (xl + xu)/2; % equação para achar a aproximaçao

		iter = iter + 1; 
		
		ea = abs((xr - xr_velho)/xr) * 100; % calcula o erro aproximado
		
		if func(xl)*func(xr) < 0 % se o produto de xr e xl
			xu = xr;	
		else
			xl = xr;
		end;
	endwhile;
	runtime = etime (clock (), t0);
	printf("Runtime: %.10f\n",runtime)

endfunction;

function falsa_posicao(func,xl,xu,es)
t0 = clock ();

	printf("===============METODO_DA_FALSA_POSICAO===============\n")

	iter = 0; xr = xl; ea = 100;

	while [ea >= es]

		printf("Aproximação:%.10f | xl:%0.5f|xr=%0.5f|xu=%0.5f |Iteração:%d | ea:%.5f(0,00005)\n",xr,xl,xr,xu,iter,ea)

		xr_velho = xr;

		xr = (xu - (func(xu)*(xl-xu))/(func(xl)-func(xu)));  % equação para achar a aproximaçao

		% mesmo algoritimo da bisseccao, só muda a equação para achar a aproximacao

		iter = iter + 1;
		
		ea = abs((xr - xr_velho)/xr) * 100;
		
		if func(xl)*func(xr) < 0
			xu = xr;	
		else
			xl = xr;
		end;
	 endwhile;
	runtime = etime (clock (), t0);
	printf("Runtime: %.10f\n",runtime)

endfunction;

%===============================VARIAVEIS_DO_EXERCICIO=============================
% consultar exercicio 5.14 cap5 pag.149
% funcao a ser utilizada pelos diferentes metodos
% conforme descreve o exercicio

es = 0.00005;		  % criterio de parada
n = 7;			      % numero de anos
A = 8500;			  % pagamentos anuais
P = 35000;			  % valor atual

funcao_exemplo = @(i) (((i.*((1.+i).^n))./(((1.+i).^n) -1)) - (A./P));
funcao_provar = @(x) x.^2 - 13
%==================================================================================

busca_incremental(funcao_exemplo,0.01,0.3,50);

bisseccao(funcao_exemplo,0.01,0.3,es);

falsa_posicao(funcao_exemplo,0.01,0.3,es);

%busca_incremental(funcao_provar,0.1,10,100);

%bisseccao(funcao_provar,0.1,10,es);

%falsa_posicao(funcao_provar,0.1,10,es);
