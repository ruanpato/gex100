from MemoryCache import *
from MainMemory import *

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
    dados = input("Digite os dados que serão armazenados")
    
    adressInteger = int(memoryAdress, 16)
    adressBits = bin(adressInteger)[2:]
    arrayBits = bitarray(adressBits)
    
    # Verificar se esta na memoria cache 
    bloco = memoryCache.isHere(arrayBits)

    # Se não, ler o endereço de memoria na cache
    if bloco == None:
        bloco = memoryCache.leBlocoMemoria(arrayBits, mainMemory)
        
    # Escrever os dados na cache
    
    memoryCache.writeData(arrayBits, dados)
    
    
    pass

def statistics():
    
    pass

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