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
    
    #print("{} = {}".format(i, res))
    #print(int(res[: 6], 2))

    

# 5 digitos mais significativos indica o rotulo
# 01111 111 11 



for i in range(128):
    bits = bin(i)[2:]

    numBits = len(bits)
    
    zeros = ""
    
    if(numBits < 8):
        dif = 7 - numBits
        
        for j in range(dif):
            zeros += "0"
    
    res = zeros + bits

    #print(int(res[:5], 2))
    #print(res[:5])
    # BBB BB PP DD
    print(int(res[-4:-2], 2))
    
    
    #print(ultimos)