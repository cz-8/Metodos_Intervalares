import numpy as np 
from matplotlib import pyplot as plt

def desenhar_grafico(funcao_nome: str,xmin: float,xmax: float,step: float, func):

	x = np.arange(xmin,xmax,step) 
	y = func(x)
	plt.title(f"{funcao_nome}") 
	plt.xlabel("x axis caption") 
	plt.ylabel("y axis caption") 
	plt.plot(x,y) 
	plt.grid(axis='y')
	plt.grid(axis='x')
	plt.show()

n = 7;	   # numero de anos
A = 8500;  # pagamentos anuais
P = 35000; # valor atual

#desenhar_grafico("Funcao do exercicio i: (((i*((1.+i)**n))/(((1.+i)**n) -1)) - (A/P))",-1,1,0.01,lambda i: (((i*((1.+i)**n))/(((1.+i)**n) -1)) - (A/P)))
desenhar_grafico("Exemplo x: (x**2 -13)",0,10,0.01,lambda x: (x**2 -13))

