from random import randint
qntTeste = int(input("Digite a quantidade de testes que deseja: "))
endereco = int('0', 16)
maxEndereco = int('128', 16)
opcao = 2
for i in range(0, qntTeste):
    print(opcao, '\n', (endereco if endereco < maxEndereco else randint(0, 127) ), '\n', randint(-128, 127), sep='')
print(5)
#sai
print(6)