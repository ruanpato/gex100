		.data

txt_tamanho:		.asciiz		"\nEntre com o tamanho do vetor: "
txt_entrada:		.asciiz		"\nEntre com o elemento de indice "
txt_2pontos: 		.asciiz		": "
txt_maior:			.asciiz		"\nMaior valor: "
txt_menor:			.asciiz		"\nIndice do menor valor: "
vetor: 				.space		412   # tamanho m�ximo 100 inteiros

		.text
main:
		add $s2, $zero, $ra		# salva endere�o de retorno
		li	$v0, 4			
		la	$a0, txt_tamanho
		syscall					#Imprime string
		
		li	$v0, 5			
		syscall					# Le tamanho do vetor
		add	$s1, $zero, $v0		# e copia em $s1
		add	$a1, $zero, $v0		# e tamb�m em $a1
		
		la  $t0, vetor
		
		add $t1, $zero, $zero	# Inicializa variavel de controle (contador) do laco $t1
laco:   slt $t2, $t1, $s1		# Se contador < quantidade entra no corpo do la�o
		beq $t2, $zero, fim_leitura # sen�o pula para fim
		
		li	$v0, 4				
		la	$a0, txt_entrada
		syscall					#Imprime string

		li	$v0, 1
		add	$a0, $zero, $t1
		syscall					#Imprime indice
		
		li	$v0, 4
		la	$a0, txt_2pontos
		syscall					#Imprime ":"
		
		li	$v0, 5			
		syscall					#Le elemento do vetor
		
		sw  $v0, 0 ($t0)		#Le armazena na mem�ria em vetor[i]

		addi $t0, $t0, 4		#aponta para a proxima posi��o do vetor
		addi $t1, $t1, 1		#atualiza vari�vel de controle
		j laco					# volta para testar novamente
		
fim_leitura:
		la  $a0, vetor			#coloca endere�o de vetor[0] em $a0; tamanho j� est� em $a1
#		jal maior_menor			# tirar o coment�rio para fazer a chamada da fun��o
		
		add $s0, $zero, $v0		# copia resultados para $s0 e $s1
		add $s1, $zero, $v1

		li	$v0, 4				#imprime texto 
		la	$a0, txt_maior
		syscall

		li	$v0, 1				#imprime maior valor
		move	$a0, $s0
		syscall
		
		li	$v0, 4				#imprime texto 
		la	$a0, txt_menor
		syscall

		li	$v0, 1				#mostra indice do menor valor
		move	$a0, $s1
		syscall

		jr  $s2					#retorna para quem chamou a fun��o main
