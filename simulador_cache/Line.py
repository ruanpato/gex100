import Cell

class Line():
    def __init__(self, label):
        self.line = [Cell.Cell(), Cell.Cell(), Cell.Cell(), Cell.Cell()]
        self.label = label