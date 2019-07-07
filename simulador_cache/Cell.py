from bitarray import bitarray

class Cell:
    def __init__(self):
        self.bits = bitarray('00000000') #Array de 8 bits 
    
    def printCell(self):
        print(self.bits.to01())

    def getCell(self):
        return self.bits.to01()
    
    def writeInCell(self, bitsAsString):
        self.bits = bitarray(bitsAsString)