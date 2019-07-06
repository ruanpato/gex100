from Cell import Cell

class Line:
    def __init__(self, label):
        self.line = [Cell(), Cell(), Cell(), Cell()]
        self.label = label
        self.updated = False
        self.recentlyUsed = -1 # Just to know don't is used

    def setLabel(self, label):
        self.label = label
    
    def setRecentlyUsed(self, recentlyUsed):
        self.recentlyUsed = recentlyUsed
        
    def leDeslocamento(desAsBinary):
        deslocamento = int(desAsBinary, 2)
        
        return self.line[deslocamento]