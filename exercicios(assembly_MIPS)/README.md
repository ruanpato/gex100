# Assembly MIPS

Diretório criado para armazenar informações sobre Assembly MIPS.

## Sumário ##
**[1.](#1-instru%C3%A7%C3%B5es-assembly) Instruções Assembly.**  
**[2.](#2-conven%C3%A7%C3%A3o-de-registradores-do-mips) Conveção de registradores.**

### Ferramentas utilizadas ###

* [GNU-GCC](https://gcc.gnu.org/) - GNU gcc and g++ compiler
* [MARS](http://courses.missouristate.edu/KenVollmar/mars/) - MIPS Assembler and Runtime Simulator

## 1. Instruções Assembly ##
MIPS codifica todas instruçẽs em 32 bits.  
Padrões de codificação de instruções:  
**R:** Instruções com operandos tipo registradores:  
|   op   	|   rs   	|   rt   	|   rd   	|  shamt 	|  funct 	|
|:------:	|:------:	|:------:	|:------:	|:------:	|:------:	|
| 6 bits 	| 5 bits 	| 5 bits 	| 5 bits 	| 5 bits 	| 6 bits 	|  


## 2. Convenção de registradores do MIPS ##
|   Nome  	| Número 	|                  Uso                  	| Preservado em chamadas ? 	|
|:-------:	|:------:	|:-------------------------------------:	|:------------------------:	|
|  \$zero  	|    0   	|              Constante 0              	|            N.D           	|
|   \$at   	|    1   	|          Assembler Temporário         	|            N.D           	|
| \$v0~\$v1 	|   2~3  	| Resultados e avaliações de expressões 	|            Não           	|
| \$a0~\$a3 	|   4~7  	|               Argumentos              	|            Sim           	|
|  \$t0~t7 	|  8~15  	|              Temporários              	|            Não           	|
| \$s0~\$s7 	|  16~23 	|                 Salvos                	|            Sim           	|
| \$t8~\$t9 	|  24~25 	|              Temporários              	|            Não           	|
| \$k0~\$k1 	|  26~27 	|             SO Temporários            	|            N.D           	|
|   \$gp   	|   28   	|            Ponteiro global            	|            Sim           	|
|   \$sp   	|   29   	|          Ponteiro para pilha          	|            Sim           	|
|   \$fp   	|   30   	|          Ponteiro para frame          	|            Sim           	|
|   \$ra   	|   31   	|          Endereço de retorno          	|            Sim           	|

#### Autores ####

* **Ruan Pato** - *Exercícios e trabalhos feitos* - [Ruan Pato](https://github.com/ruanpato)
* **Me. Luciano Lores Caimi** - *Professor*