#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <iostream>

using namespace std;

main(){
	
	setlocale(LC_ALL, "Portuguese");
	
	//indices
	
	int x, y, z, pos[] = {3,1,2,0};
	
	float w[] = {1,1,1}; //entrada 1, entrada 2 e o ultimo eh o baias
	
	int ent[4][2] = {{1,1}, {1,-1}, {-1,-1}, {-1,1} };
	
	int baias = 1;
	
	float alfa = 1.5, 
	erro[] = {-1.5,-1.5,-1.5,-1.5}, 
	saida[4], 
	desejada[] = {1, -1, -1, -1},
	desvio = 0.1, //10%
	k,
	v[3];
	
	for (x = 0; x < 4; x++){
		//inicio da atualizacao dos pesos
		k = alfa * erro[pos[x]] / (( abs(ent[pos[x]][0]) + abs(ent[pos[x]][1]) + baias));	
		
		v[0] = ent[pos[x]][0] * k;
		v[1] = ent[pos[x]][1] * k;
		v[2] = baias * k;
		
		w[0] = w[0] + v[0];
		w[1] = w[1] + v[1];
		w[2] = w[2] + v[2];
		//saida calculada
		saida[pos[x]] = w[0]*ent[pos[x]][0] + w[1]*ent[pos[x]][1] + w[2]*baias;
		
		//calculo do erro
		erro[pos[x]] = desejada[pos[x]] - saida[pos[x]];
		
		//rele
		if (saida[pos[x]] >= 0){
			saida[pos[x]] = 1;
		} else {
			saida[pos[x]] = -1;
		} 
	
	}	
	
	
	
	for (y = 0; y < 4; y++){
		cout << ent[pos[y]][0];
		cout << "\t|";
		cout << ent[pos[y]][1];
		cout << "\t|";
		cout << baias;
		cout << "\t|";
		cout << saida[pos[y]];
		cout << endl;
	}
	
}
