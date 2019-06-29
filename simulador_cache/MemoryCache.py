import Cell

class MemoryCache:
    def __init__(self):
        self.line = []
        #cada linha tem o tamanho de um bloco
        # logo cada linha sera composta de 4 celulas

        for i in range(8):                
            l = [Cell.Cell(), Cell.Cell(), Cell.Cell(), Cell.Cell()]
            self.line.append(l)
    
    def printAllCache(self):
        for l in self.line:
            for cell in l:
                cell.printCell()
                
            print()
            
    pass
