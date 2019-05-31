'''
    Registradores preservados           |   Registradores Não preservados
        Salvos: $s0~$s7                 |       Temporários: $t0~$t7
    Apontador para pilha: $sp           |       Argumentos: $a0~$a3       
    Endereço de retorno: $ra            |   Valores de retorno: $v0~$v1
Pilha acima do apontador para a pilha   | Pilha abaixo do apontador para pilha
'''
.data
	msgSelectFieldSize: .asciiz "Selecione o tamanho do campo:\na) 5x5\nb) 7x7\nc) 9x9\n-> "
	msgSelectPos:		.asciiz "Selecione uma posição do campo minado:\n-> "
	fieldOption:		.byte
.text
	main:										# "Função main"
		jal menu								# "Chama a função menu"

		# Avisa o sistema que o programa chegou ao fim "como return 0; no final de uma função main em C".
		li $v0, 10								# 
		syscall									# 

	menu:										# "Função Menu"
		# Exibe a mensagem de escolha do tamanho
		li $v0, 4								# 
		la $a0, msgSelectFieldSize				# 
		syscall									# Imprime a mensagem
		
		# Recebe o caractere respectivo ao tamanho selecionado
		li $v0, 8								# 
		la $a0, fieldOption						# 
		li $a1, 1								# 
		syscall									# 
		move $t0, $v0							# 
		
		# Mostra a escolha
		li $v0, 4								# 
		la $a0, fieldOption						# 
		syscall									# 

        # Condicional
        '''
        slt $t3, $s5, $zero                     # Teste se k($s5) é == 0($zero)
        bne $t3, $zero, kEzero                  # Se K == 0 vai para kEzero
        '''

		
		jr $ra									# 