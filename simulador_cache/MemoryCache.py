from Line import *

'''
Será utilizado a seguinte lógica para determinar em qual quadro está a linha:
[0,3] = Quadro A
[4,7] = Quadro B
Cada linha será um objeto do tipo Line que possui um rótulo e quatro células
'''

class MemoryCache:
    def __init__(self):
        self.line = []
        # cada linha tem o tamanho de um bloco
        # logo cada linha sera composta de 4 celulas
        for i in range(8):                
            self.line.append(Line(i))
    
    def printAllCache(self):
        for i, l in enumerate(self.line):
            quadro = None
            
            if i < 4:
                quadro = "A"
            else:
                quadro = "B"
            
            print("Quadro {} - Label: {}".format(quadro, l.label))
            
            for cell in l.line:
                cell.printCell()
                
            print()
    
    '''
    Recebe um array de bits e verifica se o endereço contido nele esta na memoria cache
    Se sim retorna o indice dela
    Se não retorna -1
    '''
    
    def isHere(self, bitArray):
        
        return 5