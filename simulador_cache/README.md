# Assembly MIPS

Diretório criado para armazenar informações sobre Assembly MIPS.

## Sumário ##
**[01.](#01-Instru%C3%A7%C3%B5es-para-implementa%C3%A7%C3%A3o) Instruções para implementação.**  

## 01. Instruções para implementação ##
Especificações:  
    * **Número de células na MP: 128;**  
    * **Tamanho do bloco: 4 células;**  
    * **Número de linhas na cache: 8;**  
    * **Tamanho da célula: 8 bits;**  
    * **Tamanho do conjunto 2 ou 4 linhas (definida pelo número entre parênteses ao lado da política de cada grupo).**  
Cada dupla deve implementar a política de mapeamento, substituição e escrita conforme especificado na folha a seguir.  
Na tela do programa deve ser apresentado todo o conteúdo da memória principal, da memória cache, da próxima localização que será substituída (de acordo com a política definida), além de um menu que de acesso às seguintes operações:  
    * Ler o conteúdo de um endereço da memória;  
    * Escrever um determinado endereço na memória;  
    * Apresentar as estatísticas de acertos e faltas (absolutos e percentuais) para as três situações: leitura, escrita e geral;  
    * Encerrar o programa.  
OBS1: Os valores e endereços devem ser apresentados em hexadecimal ou binário.  
OBS2: Ao ler um endereço deve informar se encontrou na cache ou não. Qual o número do bloco a que se refere o endereço, qual o quadro na cache que está mapeado e o deslocamento do mesmo.  
OBS3: Os contadores da política de substituição possuem 3 bits.

## 02. Convenção de registradores do MIPS ##


### Ferramentas utilizadas e Bibliografia ###


#### Autores ####

* **Ruan Pato** - *Exercícios e trabalhos feitos* - [Ruan Pato](https://github.com/ruanpato)
* **Me. Luciano Lores Caimi** - *Professor*
