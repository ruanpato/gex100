from MemoryCache import *
from MainMemory import *

from bitarray import bitarray

def readContentFromMemory():
    memoryAdress = input("Digite o endereço de memória em hexa. Ex: 0x12: ")
    adressInteger = int(memoryAdress, 16)
    adressBits = bin(adressInteger)[2:]
    arrayBits = bitarray(adressBits)
    
    # Verificar se esta na cache
    a = memoryCache.isHere(arrayBits, mainMemory)
    
    print("Conteudo lido para a memória com sucesso!")
    
    print(a)
    pass

def writeContentInMemory():
    
    pass

def statistics():
    
    pass

messageInput = "Digite:\n1 - Ler o conteúdo de um endereço de memória\n"
messageInput += "2 - Escrever em um determinado endereço de memória\n"
messageInput += "3 - Estatisticas\n"
messageInput += "4 - Mostrar toda memória principal\n"
messageInput += "5 - Mostrar toda memória cache\n"
messageInput += "6 - Encerrar o programa\n"


mainMemory = MainMemory()

memoryCache = MemoryCache()

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