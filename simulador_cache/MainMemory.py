import Cell

class MainMemory:
    def __init__(self):
        self.cells = []
        self.blocks = 32
        
        for _ in range(128):
            newCell = Cell.Cell()
            self.cells.append(newCell)
            
    def printAllCells(self):
        for cell in self.cells:
            cell.printCell()

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
            block[i].writeInCell(novoBloco[i])