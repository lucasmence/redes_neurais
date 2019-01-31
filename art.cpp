#include <iostream>
#include <stdlib.h>
#include <math.h>

using namespace std;

#define clearMatriz(matriz,value) for(int x = 0; x < (sizeof matriz / sizeof matriz[0]);x++){ for(int y = 0; y < (sizeof matriz[0] / sizeof(float));y++){ matriz[x][y] = value;}}
#define printMatriz(matriz) for(int x = 0; x < (sizeof matriz / sizeof matriz[0]);x++){ for(int y = 0; y < (sizeof matriz[0] / sizeof(float));y++){ cout << matriz[x][y] << " ";} cout << endl;}
#define sumMatriz(matriz,sum) sum = 0; for(int x = 0; x < (sizeof matriz / sizeof matriz[0]);x++){ for(int y = 0; y < (sizeof matriz[0] / sizeof(float));y++){ sum += matriz[x][y];}}
#define sumMatrizLine(matriz,sum,line) line == line; sum = 0; for (int y = 0; y < (sizeof matriz[0] / sizeof(float)); y++){ sum += matriz[line][y];}
#define powLineXLine(matrizA,matrizB,sum,line) sum == sum; sum = 0; for(int y = 0; y < (sizeof matrizA[0] / sizeof(float)); y++){ sum += pow(matrizA[line][y],matrizB[line][y]);}
#define maxArray(array,index) index == index; float max = -1; for(int x = 0; x < (sizeof array[0] / sizeof(float)); x++){if (array[x] > max) max = array[x]; index = x;}

float modulo(float value){
	if (value < 0){
		return value * (-1);
	}	
	else {
		return value;	
	}
}


int main(){
	
	float alpha = 0.1, beta = 1, roh = 0.95;
	//int line = 3, column = 3;	
	//float matrizInicial[line][column] = {{3,5,7},{1,3,5},{2,4,6}};
/*	int line = 3, column = 2;	
	float matrizInicial[line][column] = {{1,0},{0,1},{0.5,0.5}};*/
	int line = 3, column = 3;	
	float matrizInicial[line][column] = {{3,5,7},{1,3,5},{2,4,6}};
	float matrizSubInicial[line][column*2];
	clearMatriz(matrizSubInicial,0);
		
	float somatorio = sumMatriz(matrizInicial,somatorio);
	
	printMatriz(matrizInicial);
	
	for (int i = 0; i < line; i++){
		for (int j = 0; j < column; j++){
			matrizSubInicial[i][j] =  (matrizInicial[i][j]/somatorio);
			matrizSubInicial[i][j*2] = 1 - (matrizInicial[i][j]/somatorio);	
		}
	}
	printMatriz(matrizSubInicial);
	
	cout << somatorio << endl;
	
	float matrizComplemento[line][column];
	 clearMatriz(matrizComplemento,0);
	 
	/*pesos iniciais*/
	float w[line][column*2];
	clearMatriz(w,1);
	for (int i = 0; i < line; i++){
		for (int j = 0; j < column*2; j++){
			w[i][j] = 1;
		}	
	}
	printMatriz(w);
	
	float matrizIa[line][column*2];
	clearMatriz(matrizIa,0);
	
	for (int i = 0; i < line; i++){
		for (int j = 0; j < column; j++){
			matrizComplemento[i][j] =  (matrizInicial[i][j]/somatorio);
		//	matrizComplemento[i][j] = 1 - matrizInicial[i][j];
		}
	}
	printMatriz(matrizComplemento);
	
	do {
					
	/*concatena, se eh que existe esta palavra rsrs*/
		
		
		for (int i = 0; i < line; i++){
			for (int j = 0; j < column; j++){
				matrizIa[i][j] = matrizInicial[i][j];
				matrizIa[i][j+column] = matrizComplemento[i][j];
			}	
		}
		
	/*definicao das categorias */
	/*T = (| I ^ W |) / (alpha + |w|) */
	
		float t[3] = {0,0,0};
		float tHelper = 0;
		for (int i = 0; i < line; i++){
			powLineXLine(matrizIa,w,t[i],i);
			sumMatrizLine(w,tHelper,i);
			t[i] = t[i] / (alpha + modulo(tHelper));	
		}
		 int winnerIndex = 0; 
		 maxArray(t,winnerIndex);	
	/*teste de vigilancia*/
	/*(|I ^ W|) / (|I|) > roh*/
	
		float watchValueA = 0;
		powLineXLine(matrizIa,w,watchValueA,winnerIndex);
		float watchValueB = 0; 
		sumMatrizLine(matrizIa,watchValueB,winnerIndex);
		float watchValueTotal = modulo(watchValueA) / modulo(watchValueB);;
		bool watchTest = (watchValueTotal > roh);
		
		if (watchTest == 0){
			cout << "o teste de vigilancia foi menor ou igual ao valor de roh " << endl;
			system("pause");
			break;
		}
		
		for (int i = 0; i < column; i++){
			w[winnerIndex][i] = 1*(pow(matrizIa[winnerIndex][i],w[winnerIndex][i])) + (1 - 1) * w[winnerIndex][i];	
		} 
		cout << " a " << endl;
		printMatriz(w);
	} while (false);

	
	system("pause"); 
	
}
