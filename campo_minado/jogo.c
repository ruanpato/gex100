#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

void calcula_bombas(int *campo, int num_linhas);                                                                        // Função que calcula o valor de todos os campos que não são bombas baseados nas bombas adjacentes
void insere_bombas(int *campo, int num_linhas);                                                                         // Função responsável por colocar as bombas no campo
void mostra_campo(char *campoU, int num_linhas);                                                                        // Função que exibe o campo minado

int main(){
    int i, j, n, *campo = (int*)malloc(sizeof(int)*82);
    char opt, *campoU = (char*)malloc(sizeof(char)*82);                                                                 // opt a) 5x5, b) 7x7 ou c) 9x9 | campoU é o que aparece na interface
    scanf("%c", &opt); n = (opt == 'a' ? 5 : (opt == 'b' ? 7 : 9));                                                     // Ternary to put line len
    memset(campo, 0, (n*n));                                                                                            // Deixa como 0 todas as posições do campo
    memset(campoU, '?', (n*n));                                                                                         // Deixa como ? todas as posições do campoU
    insere_bombas(campo, n);                                                                                            // Coloca as bombas no campo
    calcula_bombas(campo, n);                                                                                           // Calcula o valor dos outros campos
    while(1){
      
        mostra_campo(campoU, n);
        printf("Digite a linha e a coluna(separados por espaço): ");
        scanf("%d %d", &j, &i);                                                                                         // Pega linha coluna
        if(*(campo+((i-1)+(j-1)*n) ) == 9){                                                                             // Se a posição escolhida tem uma bomba
            *(campoU+((i-1)+(j-1)*n) ) = (*(campo+((i-1)+(j-1)*n) )+48);                                                // +48 para converter int para um número em ASCII
            printf("Você perdeu!!\n");
            mostra_campo(campoU, n);
            break;                                                                                                      // Saí do loop "encerrando  o jogo"
        }else{
            *(campoU+((i-1)+(j-1)*n) ) = (*(campo+((i-1)+(j-1)*n) )+48);                                                // +48 para converter int para um número em ASCII e revelar o campo jogado
        }
    }

    return 0;
}


/*Aparentemente OK*/
void calcula_bombas(int *campo, int num_linhas){                                                                        // Função que calcula o valor de todos os campos que não são bombas baseados nas bombas adjacentes
    for(int i = 0; i < (num_linhas*num_linhas); i++){
        if(*(campo+i) !=9){                                                                                             // Verifica se o campo não é uma bomba
            if(i-num_linhas > 0 && *(campo+(i-num_linhas)) == 9)                                                        // Verifica se tem bomba acima
                *(campo+i)+=1;
            if(i+num_linhas < num_linhas*num_linhas && *(campo+(i+num_linhas)) == 9)                                    // verifica se tem bomba abaixo
                *(campo+i)+=1;
            if((i+1)%num_linhas!=0 && i-1 >= 0 && *(campo+(i-1)) == 9)                                                  // Verifica se tem bomba a esquerda
                *(campo+i)+=1; 
            if((i+1)%num_linhas!=num_linhas && i+1 < num_linhas*num_linhas && *(campo+(i+1)) == 9)                      // Verifica se tem bomba a direita
                *(campo+i)+=1;
            if((i+1)%num_linhas!=num_linhas && i-num_linhas >= 0 && *(campo+(i-num_linhas)+1) == 9)                     // Se Diagonal superior da direita
                *(campo+i)+=1;
            if((i+1)%num_linhas!=0 && i-num_linhas >= 0 && *(campo+(i-num_linhas)-1) == 9)                              // Se Diagonal superior da esquerda
                *(campo+i)+=1;
            if((i+1)%num_linhas!=num_linhas && i+num_linhas < num_linhas*num_linhas && *(campo+(i+num_linhas)+1) == 9)  // Se Diagonal inferior da direita
                *(campo+i)+=1;
            if((i+1)%num_linhas!=0 && i+num_linhas < num_linhas*num_linhas && *(campo+(i+num_linhas)-1) == 9)           // Se Diagonal inferior da esquerda
                *(campo+i)+=1;
        }
    }
}

void insere_bombas(int *campo, int num_linhas){                                                                         // Função responsável por colocar as bombas no campo
    srand((unsigned)time(NULL));
    for(int i = 0; i < num_linhas; i++){                                                                                // Insere de em posições pseudo-aleatórias bombas(valor 9)    
        *(campo+(rand()%(num_linhas*num_linhas)+1)) = 9;                                                                // Atribui uma bomba em uma posição
    }
}

void mostra_campo(char *campoU, int num_linhas){                                                                        // Função que exibe o campo minado
    
    printf("  ");for(int i = 1; i <= num_linhas; i++) printf(" %d", i); printf("\n");
    
    printf("  |");for(int i = 0; i <= num_linhas*2-2; i++) printf("-"); printf("|\n");                                  // Imprime a linha que separa
    for(int i = 0, j=0, k=1; i < (num_linhas*num_linhas); i++){
        if(j==0)
            printf("%d ", k);
        printf("|%c", *(campoU+i));
        if(j==num_linhas-1){
            printf("|\n");
            j=0;k++;
            printf("  |");for(int i = 0; i <= num_linhas*2-2; i++) printf("-"); printf("|\n");                          // Imprime a linha que separa
        }else{
            j++;
        }
    }
}