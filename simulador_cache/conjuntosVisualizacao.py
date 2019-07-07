conjuntos = {}

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
    conjunto = int(res[-4:-2], 2)
    if not conjunto in conjuntos:
        conjuntos[conjunto] = []
    #print("{} Endereço de memória: {} Conjunto: {}".format(i, hex(i), conjunto))
    conjuntos[conjunto].append(hex(i))
for i in sorted(conjuntos.keys()):
    print("Conjunto:" ,i,sep='')
    for j in range(0, len(conjuntos[i])):
        print(conjuntos[i][j],end='')
        if((j+1)%4==0 and j != 0):
            print()
        else:
            print(end='- ')
    print()