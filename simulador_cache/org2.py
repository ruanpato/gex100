from bitarray import bitarray

def readContentFromMemory():
    
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
cell = Cell()
cache = MemoryCache()

cache.printAllCache()

#print(mainMemory.cells[0].bits)
# mainMemory.printAllCells()
#mainMemory.printBlock(2)

#info = ['00000000', '00000001', '00000010', '00000011']

#mainMemory.writeBlock(2, info)

#print('')

#mainMemory.printBlock(2)

exit(0)

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