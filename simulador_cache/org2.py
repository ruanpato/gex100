from bitarray import bitarray

class Cell:
    def __init__(self):
        self.bits = bitarray('00000000') #Array de 8 bits 
    
    def printCell(self):
        print(self.bits.to01())
    
    def writeInCell(self, bitsAsString):
        self.bits = bitarray(bitsAsString)

class MainMemory:
    def __init__(self):
        self.cells = []
        self.blocks = 32
        
        for i in range(128):
            newCell = Cell()
            self.cells.append(newCell)
            
    def printAllCells(self):
        for cell in self.cells:
            cell.printCell()

    def readBlock(self, numBlock):
        endBlock = numBlock * 4
        #startBlock = endBlock - 4

        block = []
        
        block.append(self.cells[endBlock - 4]) # Primeiro Célula
        block.append(self.cells[endBlock - 3]) # Segunda Célula
        block.append(self.cells[endBlock - 2]) # Terceira Célula
        block.append(self.cells[endBlock - 1]) # Quarta Célula
        
        return block
    
    def printBlock(self, numBlock):
        block = self.readBlock(numBlock)
        
        for cell in block:
            cell.printCell()
    
    pass

    # A info deve ser uma lista de 4 strings
    # Cada string deve conter 8 caracteres em forma de bits
    # Ex: '00000000'
    def writeBlock(self, numBlock, info):
        block = self.readBlock(numBlock)
        
        for i in range(4):
            block[i].writeInCell(info[i])


class MemoryCache:
    def __init__(self):
        self.line = []
        #cada linha tem o tamanho de um bloco
        # logo cada linha sera composta de 4 celulas

        for i in range(8):                
            l = [Cell(), Cell(), Cell(), Cell()]
            self.line.append(l)
    
    def printAllCache(self):
        for l in self.line:
            for cell in l:
                cell.printCell()
                
            print()
            
    pass

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