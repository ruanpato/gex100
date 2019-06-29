import Line

'''
Será utilizado a seguinte lógica para determinar em qual quadro está a linha:
[0,3] = Quadro A
[4,7] = Quadro B
Cada linha será um objeto do tipo Line que possui um rótulo e quatro células
'''

class MemoryCache:
    def __init__(self):
        self.line = []
        #cada linha tem o tamanho de um bloco
        # logo cada linha sera composta de 4 celulas
        for i in range(8):                
            a = Line(i)
            #self.line.append(Line(i))
            pass
    
    def printAllCache(self):
        for l in self.line:
            for cell in l:
                cell.printCell()
                
            print() 
            
    pass