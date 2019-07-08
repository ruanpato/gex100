import Cell

class MainMemory:
    def __init__(self):
        self.cells = []
        self.blocks = 32
        
        for _ in range(128):
            newCell = Cell.Cell()
            self.cells.append(newCell)
            
    def printAllCells(self):
        for (i, cell) in enumerate(self.cells):
            print("{} - {}:    ".format(i, hex(i)) , end="")
            cell.printCell()

    def printAllCellsMain(self):
        print("|{: ^23s}|{: ^10s}|\n|{: ^9s}|{: ^13s}|{: ^10s}|".format("Posição", "", "Decimal", "Hexadecimal", "Valor"))
        for (i, cell) in enumerate(self.cells):
            print("|{: ^9s}|{: ^13s}|{: ^10s}|".format( self.padronizaEnderecoDec(i), self.padronizaEnderecoHexa(i), cell.getCell()))

    def padronizaEnderecoDec(self, endereco):
        if endereco >= 100:
            return str(endereco)
        elif endereco >= 10:
            return ("0"+str(endereco))
        return ("00"+str(endereco))

    def padronizaEnderecoHexa(self, endereco):
        if endereco < 16:
            try:
                aux = str(hex(endereco)).split("x")
                return str(aux[0]+"x0"+aux[1])
            except:
                return str(hex(endereco))
        return str(hex(endereco))


    def readBlock(self, numBlock):
        startBlock = numBlock * 4
        #startBlock = startBlock - 4

        block = []
        
        block.append(self.cells[startBlock + 0]) # Primeiro Célula
        block.append(self.cells[startBlock + 1]) # Segunda Célula
        block.append(self.cells[startBlock + 2]) # Terceira Célula
        block.append(self.cells[startBlock + 3]) # Quarta Célula
        
        return block
    
    def printBlock(self, numBlock):
        block = self.readBlock(numBlock)
        
        for cell in block:
            cell.printCell()
    
    pass


# A info deve ser uma lista de 4 strings
# Cada string deve conter 8 caracteres em forma de bits
# Ex: '00000000'

    def writeBlock(self, novoBloco, label):
        block = self.readBlock(label)
        
        for i in range(4):
            block[i].writeInCell(novoBloco[i].bits.to01())