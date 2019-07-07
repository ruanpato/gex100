from Line import Line
from bitarray import bitarray
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
    
    '''
    Recebe um array de bits e verifica se o endereço contido nele esta na memoria cache
    Se sim retorna o indice dela
    Se não retorna -1
    '''
    
    def verifyConjunto(self, label, conjunto):
        #print("Label é {}".format(label))
        #print("Conjunto é {}".format(conjunto))
        
        findB = lambda x: x + 4
        
        quadroA = self.line[conjunto]
        quadroB = self.line[findB(conjunto)]
        
        if quadroA.label == label:
            return quadroA
        elif quadroB == label:
            return quadroB
        else:
            return None
        
        # Conjunto é o 3, ele tem duas possiblidade, verificar o conjunto
        # ja que o conjunto é de 0 a 7, então o 3
        
        pass
    
    def getInfoFromBits(self, bitArray):
        bits = bitArray.to01()
        
        numBits = len(bits)
    
        zeros = ""
        
        if(numBits < 8):
            dif = 7 - numBits
            
            for _ in range(dif):
                zeros += "0"
        
        res = zeros + bits

        #print(int(res[:5], 2))
        #print(res[:5])
        # BBB BB PP DD
        conjunto = int(res[-4:-2], 2)
        label = int(res[ : 5], 2)
        
        
        #print("Conjunto: ", conjunto)
        #print("Label", label)
        
        
        return {
            "label": label,
            "conjunto": conjunto
        }
    
    def isHere(self, bitArray):
        
        info = self.getInfoFromBits(bitArray)

        conjunto = info['conjunto']
        label = info['label']
        # O quadro é uma das linhas da cache
        
        quadro = self.verifyConjunto(label, conjunto)

        if quadro:
            # retorna o quadro em que a informação se encontra
            return quadro
        else:
            return None
        
        pass
    
    def leBlocoMemoria(self, bitArray, mainMemory):
        info = self.getInfoFromBits(bitArray)

        conjunto = info['conjunto']
        label = info['label']
        
        # Se o quadro não estiver na cache é preciso buscar da cache o bloco! 
        bloco = mainMemory.readBlock(label) # NumBlock
        
        # Aqui a estatistica de acertos/Erros entra
        
        
        # LRU VEM AQUI PRA SABER em qual quadro sera escrito a informação MUDANÇAS NA MEMÓRIA #
        # LRU RETORNA QUADRO PARA ESSA FUNÇÃO!
        bloco = self.LRU(mainMemory, conjunto, bloco, label)
        
        return bloco
        
        # Alterar o recently used de ambos os qaudros
        
    
    def escritaRetorno(self, mainMemory, line):
        # Pega a informação da linha e a escreve na memoria
        mainMemory.writeBlock(line.line, line.label)
        pass

    def LRU(self, mainMemory, conjunto, block, label):
        if self.line[conjunto].recentlyUsed < self.line[conjunto + 4].recentlyUsed:
            if self.line[conjunto].updated:
                # Se o bloco foi alterado anteriormente ele precisar ser escrito na memória principal
                # antes de ser reescrito na cache
                self.escritaRetorno(mainMemory, self.line[conjunto])
                self.line[conjunto].updated = False

            # Se o conjunto for o menor utilizado, aumentar o contador dele e associar o bloco ao mesmo
            self.line[conjunto].recentlyUsed = 1
            self.line[conjunto].line = block
            self.line[conjunto].label = label            
            
            # O contador do outro conjunto tem que ser 0
            self.line[conjunto + 4].recentlyUsed = 0
            
            return self.line[conjunto]
        else:
            if self.line[conjunto + 4].updated:
                # Se o bloco foi alterado anteriormente ele precisar ser escrito na memória principal
                # antes de ser reescrito na cache
                self.escritaRetorno(mainMemory, self.line[conjunto + 4])
                self.line[conjunto + 4].updated = False

        # Se o conjunto for o menor utilizado, aumentar o contador dele e associar o bloco ao mesmo
            self.line[conjunto + 4].recentlyUsed = 1
            self.line[conjunto + 4].line = block
            self.line[conjunto + 4].label = label            
            
            # O contador do outro conjunto tem que ser 0
            self.line[conjunto].recentlyUsed = 0
            
            return self.line[conjunto + 4]
        
        
    def writeData(self, arrayBits, dados):
        # Pega o label e o conjunto
        info = self.getInfoFromBits(arrayBits)
        # Convert to string
        stringBits = arrayBits.to01()
        stringBits = stringBits[-2:]
        # Pega o deslocamento
        deslocamento = self.line[0].leDeslocamento(stringBits)
        # Altera o status updated e atribui o valor
        if self.line[info['conjunto']].label == info['label']:
            self.line[info['conjunto']].updated = True
            self.line[info['conjunto']].line[deslocamento].writeInCell(dados)
            self.line[info['conjunto']].recentlyUsed = 1
            self.line[info['conjunto']+4].recentlyUsed = 0
        if self.line[info['conjunto']+4].label == info['label']:
            self.line[info['conjunto']+4].updated = True
            self.line[info['conjunto']+4].line[deslocamento].writeInCell(dados)
            self.line[info['conjunto']].recentlyUsed = 0
            self.line[info['conjunto']+4].recentlyUsed = 1
        # Altera os recentemente usados
        
        #self.line[info['conjunto']].recentlyUsed = 0 if self.line[info['conjunto']+4].recentlyUsed > 0 else 1
    
    def printAllCells(self):
        for i in range(4):
            quadroA = self.line[i]
            quadroB = self.line[i + 4]
            
            self.printAsQuadros(i, quadroA, quadroB)

        pass
    
    def printAsQuadros(self, numeroConjunto, qA, qB):
        print("---Conjunto {}---".format(numeroConjunto + 1))
        print("\nQuadro A")
        
        for (i, cell) in enumerate(qA.line):
            print("Célula {}:".format(i + 1), end=" ")
            cell.printCell()
        
        print("\nQuadro B")
        
        for (i, cell) in enumerate(qB.line):
            print("Célula {}:".format(i + 1), end=" ")
            cell.printCell()
        
        print("\n")

    pass