import Cell

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