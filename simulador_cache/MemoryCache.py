from Line import *

'''
Será utilizado a seguinte lógica para determinar em qual quadro está a linha:
[0,3] = Quadro A
[4,7] = Quadro B
Cada linha será um objeto do tipo Line que possui um rótulo e quatro células.
Os conjuntos podem ser definidos "linhas concatenadas" seguindo o seguinte padrão:
    Quadro A   -    Quadro B
    linha 0    -    linha 4 = Conjunto 0
    linha 1    -    linha 5 = Conjunto 1
    linha 2    -    linha 6 = Conjunto 2
    linha 3    -    linha 7 = Conjunto 3
    Padrão da entrada:
    E = bits do endereço
    C = Conjunto pertencente
    D = Deslocamento dentro do quadro
    EEE EEE CC DD
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
    
    
    
    def LRU(self, label, bloco):
        #ESCREVE SUA Função aqui
        
        pass
    
    '''
    Recebe um array de bits e verifica se o endereço contido nele esta na memoria cache
    Se sim retorna o indice dela
    Se não retorna -1
    '''
    
    def verifyConjunto(self, label, conjunto):
        print("Label é {}".format(label))
        print("Conjunto é {}".format(conjunto))
        
        findB = lambda x: x + 4
        
        quadroA = self.line[conjunto]
        quadroB = self.line[findB(conjunto)]
        
        if quadroA.label == label
            return quadroA
        elif quadroB == label
            return quadroB
        else:
            return false
        
        # Conjunto é o 3, ele tem duas possiblidade, verificar o conjunto
        # ja que o conjunto é de 0 a 7, então o 3
        
        pass
    
    def isHere(self, bitArray, mainMemory):
        number = bitArray.to01()
        
        # verificar o tamanho do número, ele obrigatoriamente tem 8 digitos
        
        tam = len(bitArray)
        
        zeros = ""
        
        if tam < 8:
            dif = 8 - tam
            
            for j in range(dif):
                zeros += "0"
        
        number = zeros + number
        
        print(number)
        
        label = int(number[ : 5], 2)
        conjunto = int(number[-4 : -2], 2)
        
        info = self.verifyConjunto(label, conjunto)

        if info != false:
            # retorna o quadro em que a informação se encontra
            return info

        # Se o quadro não estiver na cache é preciso buscar da cache o bloco! 
        
        bloco = mainMemory.readBlock(numBlock)
        
        # LRU VEM AQUI PRA SABER em qual quadro sera escrito a informação MUDANÇAS NA MEMÓRIA #
        
        # LRU RETORNA QUADRO PARA ESSA FUNÇÃO!
        return self.LRU(label, bloco)