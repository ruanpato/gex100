from Cell import *

class Line:
    def __init__(self, label):
        self.line = [Cell(), Cell(), Cell(), Cell()]
        self.label = label
        self.recentlyUsed = -1 # Just to know don't is used

    def setLabel(self, label):
        self.label = label
    
    def setRecentlyUsed(self, recentlyUsed):
        self.recentlyUsed = recentlyUsed