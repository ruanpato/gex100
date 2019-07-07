from MemoryCache import MemoryCache
from MainMemory import MainMemory
import os

from bitarray import bitarray

mainMemory = MainMemory()

memoryCache = MemoryCache()

def readContentFromMemory():
    memoryAdress = input("Digite o endereço de memória em hexa. Ex: 0x12: ")
    memoryAdress = verificaEndereco(memoryAdress, 0)
    adressInteger = int(memoryAdress, 16)
    adressBits = bin(adressInteger)[2:]
    arrayBits = bitarray(adressBits)
    arrayAsString = arrayBits.to01()
    
    # Verificar se esta na cache
    bloco = memoryCache.isHere(arrayBits)

    if bloco == None:
        bloco = memoryCache.leBlocoMemoria(arrayBits, mainMemory)
    
    print("Conteudo lido para a memória com sucesso!")
    
    #ler apenas a celula certa a partir do deslicamento do bloco
    
    celula = bloco.leDeslocamento(arrayAsString[-2:])
    
    print(celula)

def writeContentInMemory():
    memoryAdress = input("Digite o endereço de memória em hexa. Ex: 0x12: ")
    memoryAdress = verificaEndereco(memoryAdress, 0)
    dados = input("Digite os dados que serão armazenados: ")
    bitsDados = verificaEntrada(dados, 0)
    
    adressInteger = int(memoryAdress, 16)
    adressBits = bin(adressInteger)[2:]
    arrayBits = bitarray(adressBits)
    
    # Verificar se esta na memoria cache 
    bloco = memoryCache.isHere(arrayBits)

    # Se não, ler o endereço de memoria na cache
    if bloco == None:
        bloco = memoryCache.leBlocoMemoria(arrayBits, mainMemory)
    
    # Escrever os dados na cache
    memoryCache.writeData(arrayBits, bitsDados)

def findTwoscomplement(valor): 
    n = len(valor) 
  
    # Traverse the valoring to get first  
    # '1' from the last of valoring 
    i = n - 1
    while(i >= 0): 
        if (valor[i] == '1'): 
            break
  
        i -= 1
  
    # If there exists no '1' concatenate 1  
    # at the starting of valoring 
    if (i == -1): 
        return '1'+valor
  
    # Continue traversal after the  
    # position of first '1' 
    k = i - 1
    while(k >= 0): 
          
        # Just flip the values 
        if (valor[k] == '1'): 
            valor = list(valor) 
            valor[k] = '0'
            valor = ''.join(valor) 
        else: 
            valor = list(valor) 
            valor[k] = '1'
            valor = ''.join(valor) 
  
        k -= 1
    valor = complete8Bits(valor)
    # return the modified valoring 
    return valor

def complete8Bits(entrada):
    aux = ''
    i = 8-len(entrada)
    for _ in range(0, i):
        aux+='0'
    aux += entrada
    return aux

def verificaEndereco(entrada, flag):
    if(flag == 1):
        clearConsole()
        entrada = input("Endereço inválido!\nDigite um endereço entre 0x00(dec=0) a 0x7f(dec=127): ")
    try:
        hexa = int(entrada, 16)
        if hexa >= 0x00 and hexa <= 0x7f : # 128 células
            return entrada
        else:
            verificaEndereco(entrada, 1)
    except:
        verificaEndereco(entrada, 1)

def clearConsole():
    os.system('cls' if os.name == 'nt' else 'clear')

def verificaEntrada(entrada, flag):
    if(flag == 1):
        clearConsole()
        entrada = input("Valor inválido!\nDigite um inteiro entre -128 a 127 ou dois caracteres(limite == 8 bits): ")
    try:
        inteiro = int(entrada)
        if inteiro >= -128 and inteiro <= 127 : # 8 bits
            entrada = bin(inteiro)
            entrada = findTwoscomplement(entrada[2:])
            return entrada
        else:
            verificaEntrada(entrada, 1)
    except:
        if len(entrada) > 2:                              # 8 bits
            verificaEntrada(entrada, 1)
        else:
            saida = bin(ord(entrada[0]))
            saida = saida[2:]
            saida += bin(ord(entrada[1]))
            saida = saida.replace('0b', '')
            return saida
            # converter string

def statistics():
    
    pass

clearConsole()
messageInput = "Digite:\n1 - Ler o conteúdo de um endereço de memória\n"
messageInput += "2 - Escrever em um determinado endereço de memória\n"
messageInput += "3 - Estatisticas\n"
messageInput += "4 - Mostrar toda memória principal\n"
messageInput += "5 - Mostrar toda memória cache\n"
messageInput += "6 - Encerrar o programa\n"

#info = ['00000000', '00000001', '00000010', '00000011']

while True:
    option = input(messageInput)
    
    try:
        option = int(option)
    except:
        clearConsole()
        print("Entrada inválida, tente novamente")
        continue

    if option == 1:
        readContentFromMemory()
        
    elif option == 2:
        writeContentInMemory()
        
    elif option == 3:
        statistics()
    elif option == 4:
        mainMemory.printAllCells()
        
    elif option == 5:
        #print all from cache
        memoryCache.printAllCells()        
        pass
    elif option == 6:
        break