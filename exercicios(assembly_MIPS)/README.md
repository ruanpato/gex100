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


**I:** Para instruções com operandos imediatos:


|   op   	|   rs   	|   rt   	|   imm   	|
|:------:	|:------:	|:------:	|:-------:	|
| 6 bits 	| 5 bits 	| 5 bits 	| 16 bits 	|


**J:** Para instruçõesde saltos incondicionais(Jump):


|   op   	|   addr  	|
|:------:	|:-------:	|
| 6 bits 	| 26 bits 	|


<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;}
.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;}
.tg .td{text-align:center;vertical-align:top}
h5 {text-align:center;}
</style>


<h5>Instruções</h5>
<table class="tg">
  <tr>
    <th class="td">Nome</th>
    <th class="td">Formato</th>
    <th class="td" colspan="6">Exemplo</th>
    <th class="td">Comentários</th>
  </tr>
  <tr>
    <td class="td">add<br></td>
    <td class="td">R</td>
    <td class="td">0</td>
    <td class="td">18</td>
    <td class="td">19</td>
    <td class="td">17</td>
    <td class="td">0</td>
    <td class="td">31<br></td>
    <td class="td">add $s1, $s2, $s3 ≡ s1 = s2+s3</td>
  </tr>
  <tr>
    <td class="td">sub</td>
    <td class="td">R</td>
    <td class="td">0</td>
    <td class="td">18</td>
    <td class="td">19</td>
    <td class="td">17</td>
    <td class="td">0</td>
    <td class="td">34</td>
    <td class="td">sub $s1, $s2, $s3 ≡ s1 = s2-s3</td>
  </tr>
  <tr>
    <td class="td">lw</td>
    <td class="td">I<br></td>
    <td class="td">35</td>
    <td class="td">18</td>
    <td class="td">17</td>
    <td class="td" colspan="3">100</td>
    <td class="td">lw $s1, 0($s2) ≡ s1=S2[0]</td> <!--Warning-->
  </tr>
  <tr>
    <td class="td">sw</td>
    <td class="td">I</td>
    <td class="td">43</td>
    <td class="td">18</td>
    <td class="td">17</td>
    <td class="td" colspan="3">100</td>
    <td class="td">sw $s1, 0($s2) ≡ S2[0]=s1</td><!--Warning-->
  </tr>
</table>


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