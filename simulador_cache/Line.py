from Cell import Cell

class Line:
    def __init__(self, label):
        self.line = [Cell(), Cell(), Cell(), Cell()]
        self.label = -1
        self.updated = False
        self.recentlyUsed = -1 # Just to know don't is used

    def setLabel(self, label):
        self.label = label
    
    def setRecentlyUsed(self, recentlyUsed):
        self.recentlyUsed = recentlyUsed
        
    def leDeslocamento(self, desAsBinary):
        deslocamento = int(desAsBinary, 2)
        return deslocamento
        #return self.line[deslocamento]