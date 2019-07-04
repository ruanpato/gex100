# Assembly MIPS

Diretório criado para armazenar informações sobre Assembly MIPS.

## Sumário ##
**[01.](#01-instru%C3%A7%C3%B5es-assembly) Instruções Assembly.**  
**[02.](#02-conven%C3%A7%C3%A3o-de-registradores-do-mips) Conveção de registradores.**  
**[0x](#ferramentas-utilizadas-e-bibliografia) Ferramentas utilizadas e bibliografia**

## 01. Instruções Assembly ##
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

##### Instruções #####
<table><tr><td rowspan="2">Categoria</td><td rowspan="2">Nome</td><td rowspan="2">Formato</td><td rowspan="2">Exemplo</td><td colspan="6">Exemplo de codificação</td><td rowspan="2">Significado</td><td rowspan="2">Comentários</td></tr><tr><td>6 bits</td><td>5 bits</td><td>5bits</td><td>5bits</td><td>5bits</td><td>6bits</td></tr><tr><td rowspan="13">Aritimética</td><td>add<br></td><td>R</td><td>add $1, $s2, $s3</td><td>0</td><td>18</td><td>19</td><td>17</td><td>0</td><td>31<br></td><td>$s1=$s2+$s3<br></td><td>overflow</td></tr><tr><td>sub</td><td>R</td><td>sub $s1, $s2, $s3</td><td>0</td><td>18</td><td>19</td><td>17</td><td>0</td><td>34</td><td>$s1=$s2-$s3</td><td>overflow</td></tr><tr><td>addi</td><td>I</td><td>addi $1, $s2, 10</td><td>8</td><td>2</td><td>1</td><td colspan="3">100</td><td>$s1=$s2+10</td><td>overflow<br></td></tr><tr><td>addu</td><td>R</td><td>addu $s1, $s2, $s3</td><td>0<br></td><td>2</td><td>3</td><td>1</td><td>0</td><td>33</td><td>$s1=$s2+$s3</td><td>no-overflow</td></tr><tr><td>subu</td><td>R</td><td>subu $s1, $s2, $s3<br></td><td>0</td><td>2</td><td>3</td><td>1</td><td>0</td><td>35</td><td>$s1=$s2-$s3</td><td>no-overflow<br></td></tr><tr><td>addiu</td><td>I</td><td>addiu $s1, $s2, 10</td><td>9</td><td>2</td><td>1</td><td colspan="3">10</td><td>$s1=$s2+$s3</td><td>no-overflow</td></tr><tr><td>mfc0</td><td>R</td><td>mfc0 $1, $epc<br></td><td>16</td><td>0</td><td>1</td><td>14</td><td>0</td><td>0</td><td>$s1=$epc</td><td></td></tr><tr><td>mult</td><td>R</td><td>mult $s2, $s3<br></td><td>0</td><td>2</td><td>3</td><td>0</td><td>0</td><td>24<br></td><td>Hi,Lo = $s2*$s3</td><td>64-sinalizado produto em Hi, Lo registrador</td></tr><tr><td>multu</td><td>R</td><td>multu $s2, $s3</td><td>0</td><td>2</td><td>3</td><td>0</td><td>0</td><td>25</td><td>Hi,Lo = $s2*$s3</td><td>64-sinalizado produto em Hi, Lo registrador<br></td></tr><tr><td>div<br></td><td>R</td><td>div $s2, $s3</td><td>0</td><td>2</td><td>3</td><td>0</td><td>0</td><td>26</td><td>Lo = $s2/$s3<br>Hi = $s2%$s3<br></td><td>Lo = Quociente<br>Hi = Resto<br></td></tr><tr><td>divu</td><td>R</td><td>divu $s2, $s3</td><td>0</td><td>2<br></td><td>3</td><td>0</td><td>0</td><td>27</td><td>Lo = $s2/$s3<br>Hi = $s2, $s3<br></td><td>Quociente não negativo e resto</td></tr><tr><td>mfhi</td><td>R</td><td>mfhi $s1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>16</td><td>$s1 = Hi<br></td><td>Copia Hi em $s1</td></tr><tr><td>mflo<br></td><td>R</td><td>mflo $s1</td><td>0</td><td>0</td><td>0</td><td>1</td><td>0</td><td>16</td><td>$s1 = Lo</td><td>Copia Lo em $s1</td></tr><tr><td rowspan="6">Lógico</td><td>and</td><td>R<br></td><td>and $s1, $s2, $s3</td><td>0</td><td>2<br></td><td>3<br></td><td>1</td><td>0</td><td>36</td><td>$s1=$s2&amp;$s3</td><td>E lógico (and)<br></td></tr><tr><td>or</td><td>R<br></td><td>or $s1, $s2, $s3</td><td>0</td><td>2</td><td>3</td><td>1</td><td>0</td><td>37</td><td>$s1=$s2|$s3</td><td>Ou lógico (or)</td></tr><tr><td>andi</td><td>I</td><td>andi $s1, $s2, 10</td><td>12</td><td>2</td><td>1</td><td colspan="3">10</td><td>$s1=$s2&amp;10</td><td>E lógico (and)</td></tr><tr><td>ori</td><td>I</td><td>ori $s1, $s2, 10</td><td>13</td><td>2</td><td>1</td><td colspan="3">10</td><td>$s1=$s2|10</td><td>Ou lógico (or)</td></tr><tr><td>sll</td><td>R</td><td>sll $s1, $s2, 10</td><td>0</td><td>0</td><td>2</td><td>1</td><td>10</td><td>0</td><td>$s1=$s2&lt;&lt;10</td><td>Deslocamento binário a esquerda</td></tr><tr><td>srl<br></td><td>R</td><td>srl $s1, $s2, 10</td><td>0</td><td>0</td><td>2</td><td>1</td><td>10</td><td>2</td><td>$s1=$s2&gt;&gt;10</td><td>Deslocamento binário a direita</td></tr><tr><td rowspan="3">Transferência de dados</td><td>lw<br></td><td>I</td><td>lw $s1, 100($s2)</td><td>35<br></td><td>2</td><td>1</td><td colspan="3">100</td><td>$s1=Mem[$s2+100]<br></td><td>Carrega da memória e coloca no registrador<br></td></tr><tr><td>sw</td><td>I</td><td>sw $s1, 100($s2)</td><td>43</td><td>2</td><td>1</td><td colspan="3">100</td><td>Mem[$s2+100]=$s1</td><td>Carrega do registrador e coloca na memória<br></td></tr><tr><td>lui</td><td>I</td><td>lui $s1, 100</td><td>15</td><td>0</td><td>1</td><td colspan="3">100</td><td>$s1=100*2^16</td><td>Carrega um constante elevada em 16 bits<br></td></tr><tr><td rowspan="2">Desvio condiconal</td><td>beq</td><td>I</td><td>beq $s1, $s2, 25</td><td>4</td><td>2</td><td>1</td><td colspan="3">25</td><td>if ($s1 == $s2) then go to PC+4+100</td><td>Desvio condicional se for igual<br></td></tr><tr><td>bne</td><td>I</td><td>bne $s1, $s2, 25</td><td>5</td><td>2</td><td>1</td><td colspan="3">25</td><td>if ($s1 != $s2) then go to PC+4+100</td><td>Desvio condicional se não for igual</td></tr><tr><td rowspan="4">Operador relacional</td><td>slt</td><td>R</td><td>slt $s1, $s2, $s3</td><td>0</td><td>2</td><td>3</td><td>1</td><td>0</td><td>42</td><td>if ($s2 &lt; $s3) then $s1 = 1 else $s1 = 0<br></td><td>Conjunto dos números inteiros</td></tr><tr><td>slti</td><td>I<br></td><td>slti $s1, $s2, 100</td><td>10</td><td>2</td><td>1</td><td colspan="3">100</td><td>if ($s2 &lt; 100) then $s1 = 1 else $s1 = 0</td><td>Conjunto dos números inteiros</td></tr><tr><td>sltu</td><td>R</td><td>sltu $s1, $s2, $s3</td><td>0</td><td>2</td><td>3</td><td>1</td><td>0</td><td>43</td><td>if ($s2 &lt; $s3) then $s1 = 1 else $s1 = 0</td><td>Conjunto dos números naturais</td></tr><tr><td>sltiu</td><td>I</td><td>sltiu $s1, $s2, 100</td><td>11</td><td>2</td><td>1</td><td colspan="3">100</td><td>if ($s2 &lt; 100) then $s1 = 1 else $s1 = 0</td><td>Conjunto dos números naturais</td></tr><tr><td rowspan="3">"Pulo" incondicional<br></td><td>j</td><td>J</td><td>j 2500</td><td>2</td><td colspan="5">2500</td><td>Pula para a posição 2500</td><td>Pula para 2500</td></tr><tr><td>jr</td><td>R<br></td><td>jr $ra</td><td>0</td><td>31</td><td>0</td><td>0</td><td>0</td><td>0</td><td>Pula para o endereço que está em $ra</td><td>Pula para o endereço que está em $ra</td></tr><tr><td>jal</td><td>J<br></td><td>jal 2500</td><td>3</td><td colspan="5">2500</td><td>Pula para o endereço 2500 e coloca em $ra o endereço da linha que o jal chamou</td><td>Pula para o endereço 2500 e coloca em $ra o endereço da linha que o jal chamou</td></tr></table>


## 02. Convenção de registradores do MIPS ##
|   Nome  	| Número 	|                  Uso                  	| Preservado em chamadas ? 	|
|:-------:	|:------:	|:-------------------------------------:	|:------------------------:	|
|  \$zero  	|    0   	|              Constante 0              	|            N.D           	|
|   \$at   	|    1   	|          Assembler Temporário         	|            Não           	|
| \$v0~\$v1 	|   2~3  	| Resultados e avaliações de expressões 	|            Não           	|
| \$a0~\$a3 	|   4~7  	|               Argumentos              	|            Não           	|
|  \$t0~t7 	|  8~15  	|              Temporários              	|            Não           	|
| \$s0~\$s7 	|  16~23 	|                 Salvos                	|            Sim           	|
| \$t8~\$t9 	|  24~25 	|              Temporários              	|            Não           	|
| \$k0~\$k1 	|  26~27 	|             SO Temporários            	|            Não           	|
|   \$gp   	|   28   	|            Ponteiro global            	|            Sim           	|
|   \$sp   	|   29   	|          Ponteiro para pilha          	|            Sim           	|
|   \$fp   	|   30   	|          Ponteiro para frame          	|            Sim           	|
|   \$ra   	|   31   	|          Endereço de retorno          	|            Sim           	|


### Ferramentas utilizadas e Bibliografia ###

* [GNU-GCC](https://gcc.gnu.org/) - GNU gcc and g++ compiler.
* [MARS](http://courses.missouristate.edu/KenVollmar/mars/) - MIPS Assembler and Runtime Simulator.
* PATTERSON, David Andrew; HENNESSY, John Leroy. Arquitetura de Computadores: Uma Abordagem Quantitativa. 5. ed. Rio de Janeiro: Elsevier, 2014. 731 p. Tradução de: Kraszczuk.

#### Autores ####

* **Ruan Pato** - *Exercícios e trabalhos feitos* - [Ruan Pato](https://github.com/ruanpato)
* **Me. Luciano Lores Caimi** - *Professor*