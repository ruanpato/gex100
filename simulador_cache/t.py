conjunto = []

for i in range(32):
    #print("{} = {}".format(i, i % 4))
    deslocamento = bin(i % 4)[2:]
    
    if len(deslocamento) == 1:
        deslocamento = "0" + deslocamento
    
    conjunto.append(deslocamento)

    bits = bin(i)[2:]

    numBits = len(bits)
    
    zeros = ""
    
    if(numBits < 6):
        dif = 6 - numBits
        
        for j in range(dif):
            zeros += "0"
    
    res = zeros + bits + deslocamento
    
    print("{} = {}".format(i, res))
