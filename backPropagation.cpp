#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <time.h>
#include <iostream>

using namespace std;

main(){
	//reajustar esse algoritmo para ficar de uma maneira que possa ser visualizada mais facil
	setlocale(LC_ALL, "Portuguese");
	
	//indices
	
	float x[3] = {1, 1, 1};
	float w[3][2] = {{-1, 1.5}, {2, 1}, {1, -1}};
	float wz[3] = {-2, -1, 1};
	float alpha = 0.8;
	float baia[2] =  {1, 1};
	
	float s[2] = {0, 0};
	float z[2] = {0, 0};
	float t1 = 0;
	float y = 0;
	float erro = 0;
	float desejada = 0.5;
	float taxaTreinamento = 0.8;
	float teta[3] = {0,0,0}; /*respectivamente teta de s1, s2 e t1*/
	float erroSaidaNeuronio[3] = {0,0,0};
	float erroNeuronio[3] = {0,0,0};
	float variacaoPeso[3] = {0,0,0};
	float novoW[3][2] = {{0,0}, {0,0}, {0,0}};
	float novoBaia[3] = {0,0,0};
	float lambda = 0.5;
	
	float e = M_E;
		
	for (int i = 0; i < 2;i++){
		s[i] = x[0] * w[0][i] + x[1] * w[1][i] + (baia[i] * w[2][i]);
		cout << "s: " << s[i] << endl;
			
		//signoidal
		z[i] = (1 - pow(e,(-lambda * s[i]))) / (1 + pow(e,(-lambda * s[i])));
		cout << "z: " << z[i] << endl;
		
		//z em modulo
		if (z[i] < 0){
			z[i] = z[i] * (-1);
		}		
	}
	
	//t
	t1 = (wz[0] * z[0]) + (wz[1] * z[1]) + (wz[2] * 1);
	cout << "t: " << t1 << endl;
	
	//saida Y
	y = (1 - pow(e,(-lambda * t1))) / (1 + pow(e,(-lambda * t1)));
	cout << "y: " << y << endl;
	
	//calculando erro
	erro = desejada - y;
	cout << "erro: " << erro << endl;
	
	//calculando teta
	teta[2] = 0.5 * lambda * (1 - (y * y));	
	cout << "teta t1: " << teta[2] << endl;
	
	//calculando erro no neuronio
	erroSaidaNeuronio[2] = teta[2]*erro;
	cout << "erro saida neuronio t1: " << erroSaidaNeuronio[2] << endl;
	
	variacaoPeso[2] = 2 * taxaTreinamento * erro * teta[2];
	cout << "variacao peso t1: " << variacaoPeso[2] << endl;
	
	//calculando novo peso das arestas e da baia
	novoW[2][0] = variacaoPeso[2] * z[0];
	novoW[2][1] = variacaoPeso[2] * z[1];
	novoBaia[2] = variacaoPeso[2] * baia[1];
	cout << "wz1 " << novoW[2][0] << endl;
	cout << "wz2 " << novoW[2][1] << endl;
	cout << "bz1 " << novoBaia[2] << endl;
	
	novoW[2][0] = wz[0] + novoW[2][0];
	novoW[2][1] = wz[1] + novoW[2][1];
	novoBaia[2] = wz[2] + novoBaia[2];
	cout << "novo wz1 " << novoW[2][0] << endl;
	cout << "novo wz2 " << novoW[2][1] << endl;
	cout << "novo bz1 " << novoBaia[2] << endl;
	
	//calculando erro de saida dos demais neuronios z1 e z2
	erroSaidaNeuronio[0] = wz[0] * erroSaidaNeuronio[2];
	cout << "erro saida neuronio z1 " << erroSaidaNeuronio[0] << endl;
	erroSaidaNeuronio[1] = wz[1] * erroSaidaNeuronio[2];
	cout << "erro saida neuronio z2 " << erroSaidaNeuronio[1] << endl;
	
	//calculando teta z1 e z2
	teta[0] = 0.5 * lambda * (1 - (z[0] * z[0]));
	teta[1] = 0.5 * lambda * (1 - (z[1] * z[1]));
	cout << "teta z1 : 0.5 *" << lambda << " * (1 - " << z[0] << ")" << endl;
	cout << "teta z1 " << teta[0] << endl;
	cout << "teta z2 " << teta[1] << endl;
	
	//calculando erro Neuronio
	erroNeuronio[0] = wz[0] * erroSaidaNeuronio[2] * teta[0];
	erroNeuronio[1] = wz[1] * erroSaidaNeuronio[2] * teta[1];
	cout << "erro neuronio z1 " << erroNeuronio[0] << endl;
	cout << "erro neuronio z2 " << erroNeuronio[1] << endl;
	
	//calculando variacao de peso dos demais neuronios
	variacaoPeso[0] = 2 * taxaTreinamento * erroSaidaNeuronio[0] * teta[0];
	variacaoPeso[1] = 2 * taxaTreinamento * erroSaidaNeuronio[1] * teta[1];
	cout << "variacao peso z1: " << variacaoPeso[0] << endl;
	cout << "variacao peso z2: " << variacaoPeso[1] << endl;
	
	//calculando novos pesos para as demais arestas
	novoW[0][0] = variacaoPeso[0] + w[0][0] * x[0];
	novoW[1][0] = variacaoPeso[0] + w[1][0] * x[1];
	novoBaia[0] = variacaoPeso[0] + w[2][0] * x[2];
	
	novoW[0][1] = variacaoPeso[1] + w[0][1] * x[0];
	novoW[1][1] = variacaoPeso[1] + w[1][1] * x[1];
	novoBaia[1] = variacaoPeso[1] + w[2][1] * x[2];
	
	cout << "novo peso w11: " << novoW[0][0] << endl;
	cout << "novo peso w12: " << novoW[1][0] << endl;
	cout << "novo baia w1: " << novoBaia[0] << endl;
	cout << "novo peso w21: " << novoW[0][1] << endl;
	cout << "novo peso w22: " << novoW[1][1] << endl;
	cout << "novo peso w2: " << novoBaia[1] << endl;
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
