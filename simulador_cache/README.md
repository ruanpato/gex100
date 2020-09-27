# Assembly MIPS

Diretório criado para armazenar informações sobre Assembly MIPS.

## Sumário ##

- [Assembly MIPS](#assembly-mips)
  - [Sumário](#sumário)
  - [01. Instruções para implementação](#01-instruções-para-implementação)
  - [02. Políticas](#02-políticas)
  - [03. Padrões de codificação](#03-padrões-de-codificação)
  - [04. Instruções de uso](#04-instruções-de-uso)
  - [05. Observações](#05-observações)
  - [06. Ferramentas utilizadas e Bibliografia](#06-ferramentas-utilizadas-e-bibliografia)
  - [07. Autores](#07-autores)

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

## 02. Políticas ##
* Mapeamento Associativo por conjuntos(4).
* Escrita no retorno.
* LRU.

## 03. Padrões de codificação ##
[PEP8](https://www.python.org/dev/peps/pep-0008/)

## 04. Instruções de uso ##

**Pré-requisitos:** 
* Python 3
* Biblioteca bitarray(para o python3)


**Instruções para instalação da biblioteca bitarray:**

* **Windows:**
  * Caso o python 3.7.3 já esteja nas variáveis de ambiente:
    * Baixe o arquivo get-pip<i></i>.py neste [link](https://bootstrap.pypa.io/get-pip.py)
    * Abra o prompt de comando do Windows como admnistrador.
    * Navegue pelo prompt de comando até o diretório onde se encontra o arquivo baixado get-pip<i></i>.py.
    * execute o comando: *python get-pip<i></i>.py* no prompt de comando.
    * Após isso execute o comando: *pip install bitarray*
  * Após isso basta navegar pelo prompt de comando até onde os arquivos código fonte deste projeto se encontram e executar o arquivo main<i></i>.py, escreva no prompt de comando: *python main<i></i>.py*
  * Obs: Verificar se o bitarray instalado foi para o python3 e se está executando o main<i></i>.py pelo python3.
* **Distribuições Linux:**
  * Abra o terminal e verifique se possui o pip instalado, caso não possua utilize o gerenciador de pacotes do seu sistema operacional e instale.
    * Caso seja ubuntu: sudo apt-get install python3-pip
    * Caso seja um derivado archlinux: sudo pacman -S python3-pip
  * Caso esses exemplos não funcionem, pesquise por instalar pip no 'nome do seu sistema operacional'.
  * Após ter o pip instalado digite no terminal: *pip install bitarray*.
  * Após isso basta navegar pelo terminal até onde os arquivos código fonte deste projeto se encontram e executar o arquivo main<i></i>.py, escreva no terminal: *python main<i></i>.py*.
* **Mac:**
  * Para instalar um biblioteca no python 3 em um sistema Mac é necessário ter o xcode instalado, caso não tenha digite no terminal: *xcode-select --install*.
  * Após instale o pip com esse comando no terminal: *sudo easy_install pip*.
  * Com isso instale o bitarray com este comando: *pip install bitarray*
  * Após isso basta navegar pelo terminal até onde os arquivos código fonte deste projeto se encontram e executar o arquivo main<i></i>.py, escreva no terminal: *python main<i></i>.py*.
* **Observação:**  Caso estas instruções não funcionem para você pesquise no google por "Como instalar a biblioteca bitarray no 'nome do sistema operacional em uso' ". Ou visite a página do [bitarrray](https://pypi.org/project/bitarray/) onde há uma explicação de como instalar esta biblioteca diretamente do código fonte.

## 05. Observações ##

Este projeto foi desenvolvido no diretório [simulador_cache](https://github.com/ruanpato/mips/tree/master/simulador_cache/associativeMapping/) dentro repositório [mips](https://github.com/ruanpato/mips/) criado pelo aluno [Ruan Pato](https://github.com/ruanpato), este repositório deixará de ser privado a partir de 08/07/2019 (dd/mm/yyyy).

## 06. Ferramentas utilizadas e Bibliografia ##

* [Python](https://python.org/) - Interpretador Python.
* **Bibliotecas Python:**
  * [bitarrray](https://pypi.org/project/bitarray/) - Uma biblioteca com forma eficiente de representar um array de booleanos.

PATTERSON, David A.; HENNESSY, John L. Organização e projeto de computadores: A interface hardware/sofware. 3. ed. Rio de Janeiro: Elsevier, 2005. ISBN 9788535215212.

## 07. Autores ##

- **[Ruan Pato](https://github.com/ruanpato)** - *Criador do repositório, descrições em README.md e resoução de exercícios e trabalhos*.
- [Guilherme Sabino](https://github.com/fersasil) - *Codificação do projeto**
- [Me. Luciano Lores Caimi](https://github.com/lcaimi) - *Professor*