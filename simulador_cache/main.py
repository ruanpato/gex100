from MemoryCache import MemoryCache
from MainMemory import MainMemory
import os

from bitarray import bitarray

mainMemory = MainMemory()

memoryCache = MemoryCache()

def readContentFromMemory():
    memoryAdress = input("Digite o endereço de memória em hexa. Ex: 0x12: ")
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
    pass

def writeContentInMemory():
    memoryAdress = input("Digite o endereço de memória em hexa. Ex: 0x12: ")
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
    
    
    pass

def findTwoscomplement(str): 
    n = len(str) 
  
    # Traverse the string to get first  
    # '1' from the last of string 
    i = n - 1
    while(i >= 0): 
        if (str[i] == '1'): 
            break
  
        i -= 1
  
    # If there exists no '1' concatenate 1  
    # at the starting of string 
    if (i == -1): 
        return '1'+str
  
    # Continue traversal after the  
    # position of first '1' 
    k = i - 1
    while(k >= 0): 
          
        # Just flip the values 
        if (str[k] == '1'): 
            str = list(str) 
            str[k] = '0'
            str = ''.join(str) 
        else: 
            str = list(str) 
            str[k] = '1'
            str = ''.join(str) 
  
        k -= 1
  
    # return the modified string 
    return str

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
        pass
    elif option == 6:
        break