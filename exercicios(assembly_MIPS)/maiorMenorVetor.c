#include <stdio.h>

int main(){
	int n, i, vetor[103];//vetor[n-2] smaller value, vetor[n-3] smaller value index, vetor[n-1] bigger value
	printf("\nEntre com o tamanho do vetor: ");
	scanf("%d", &n);n+=3;				
	for(i=0; i<(n-3); i++){
		printf("\nEntre com o elemento do indice %d: ", i);
		scanf("%d", &vetor[i]);
		if(i==0){
			vetor[n-3]=i;vetor[n-2]=vetor[0];vetor[n-1]=vetor[0];
		}else{
			if(vetor[n-2] > vetor[i]){
				vetor[n-2] = vetor[i];
				vetor[n-3] = i;
			}
			if(vetor[n-1] < vetor[i])
				vetor[n-1] = vetor[i];
		}
	}printf("\nMaior valor: %d\nIndice do menor valor: %d\n", vetor[n-1], vetor[n-3]);
	
	return 0;
}