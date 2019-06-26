# Cabeçalho de registradores salvos usados:
# $s1 = n
# $s2 = n*n
# $s6 = matriz_jogo
# $s7 = matriz_usuario
.data
    # Mensagens
    byte_interrogacao:      .byte '?'
    msg_test:               .asciiz "\n----TESTE----\n"
    msg_test_fim_main:      .asciiz "\n----FIM_MAIN----\n"
    msg_seleciona_opc:      .asciiz "\nDigite qual o tamanho que deseja que a matriz tenha\na) 5x5\nb) 7x7\nc) 9x9\n-> "
    # Vetores(Matrizes)
    matriz_usuario:         .byte 82
.text
jal		main				                        # jump to main and save position to $ra

main:
    # Seleciona opção #
    la		$a0, msg_seleciona_opc		            # Carrega o endereço do array .asciiz referente a mensagem de selecionar a opção
    li		$v0, 4                                  # $v0 = 4 Argumento para imprimir array(string) via syscall(MARS)
    syscall                                         # Imprime a mensagem da seleção da opção
    # Lê opção
    li		$v0, 12                                 # $v0 = 12 Argumento para ler um caracter
    syscall
    add     $s0, $v0, $zero                         # Salva a entrada em $s0
    
    jal     opcao_para_n                                # Vai para a 'função' e linka o retorno a esta linha
    jal     preenche_matriz_usuario                     # Preenche a matriz que o usuário vê com ?
    jal     imprime_matriz_usuario

    la		$a0, msg_test_fim_main		            # Carrega o endereço do array .asciiz referente a mensagem de selecionar a opção
    li		$v0, 4                                  # $v0 = 4 Argumento para imprimir array(string) via syscall(MARS)
    syscall                                         # Imprime a mensagem da seleção da opção


exit:   li      $v0, 10                             # $v0 = 10 Argumento para encerrar a execução via syscall(MARS)
        syscall                                     # Encerra a execução
 
opcao_para_n:                                       # Pega a opção que será um caracter e converte em um N a=5, b=7, c=9
    # Seleciona opção #
    li      $t0, 'a'                                # Load in $t0 to compare
    beq		$s0, $t0, opc_a	                        # if $s0 == $t0 then opc_a
    li      $t0, 'A'                                # Load in $t0 to compare
    beq		$s0, $t0, opc_a	                        # if $s0 == $t0 then opc_a
    li      $t0, 'b'                                # Load in $t0 to compare
    beq		$s0, $t0, opc_b	                        # if $s0 == $t0 then opc_b
    li      $t0, 'B'                                # Load in $t0 to compare
    beq		$s0, $t0, opc_b	                        # if $s0 == $t0 then opc_b
    li      $t0, 'c'                                # Load in $t0 to compare
    beq		$s0, $t0, opc_c	                        # if $s0 == $t0 then opc_c
    li      $t0, 'C'                                # Load in $t0 to compare
    beq		$s0, $t0, opc_c	                        # if $s0 == $t0 then opc_c

    opc_a:
        addi    $s0, $zero, 5                       # $s0 = 5
        addi    $s1, $zero, 26                      # $s1 = n*n+1
        jr      $ra

    opc_b:
        addi    $s0, $zero, 7                       # $s0 = 7
        addi    $s1, $zero, 50                      # $s1 = n*n+1
        jr      $ra
    opc_c:
        addi    $s0, $zero, 9                       # $s0 = 9
        addi    $s1, $zero, 82                      # $s1 = n*n+1
        jr      $ra

preenche_matriz_usuario:
    la		$s7, matriz_usuario		                # $s7 == matriz_usuario
    add     $t1, $zero, $zero                       # Inicializa Variável de controle
    add     $t2, $zero, $zero                       # Inicializa iterador
    lb      $s5, byte_interrogacao                  # Carrega um caractere em $s5 (lb = LoadByte)

    j		enquanto_nao_estiver_preenchida		    # jump to enquanto_nao_estiver_preenchida

    enquanto_nao_estiver_preenchida:
        slt     $t3, $t1, $s1                           # Se i < n*n então $t2 = 1
        beq     $t3, $zero, fim_preenche_matriz_usuario    # Vai para fim_preenche_matriz_usuario

        sb	    $s5, 0($s7)		                    # Coloca o caractere ? na posição i da matriz StoreByte
        addi    $t1, $t1, 1                         # Incrementa a variável de controle
        addi    $s7, $s7, 1                         # Muda a posição do vetor
        
        j       enquanto_nao_estiver_preenchida     # Volta para o loop

    fim_preenche_matriz_usuario:
        jr      $ra                                 # Retorna para onde foi chamada

imprime_matriz_usuario:
    # Imprime quebra de linha
    li     $a0, '\n'                                    # Carrega o caractere quebra de linha em $a0
    li     $v0, 11                                     # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
    syscall
    # Imprime 3 espaços:
    li     $a0, ' '                                    # Carrega o caractere espaço em $a0
    li     $v0, 11                                     # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
    syscall
    syscall
    syscall

    add     $t0, $zero, $zero                       # Variável de controle

    addi    $sp, $sp, 4                             # Incrementa o stackpointer
    sw      $ra, 0($sp)                             # Salva o endereço de retorno em $sp
    jal     loop_imprime_indices_colunas
    lw      $ra, 0($sp)                             # Carrega o endereço de retorno em $ra
    addi    $sp, $sp, -4                            # Decrementa o stackpointer
    jr      $ra
    
    loop_imprime_indices_colunas:
        # Compara
        slt     $t1, $t0, $s0                              # Se i < n+1 então $t2 = 1
        beq     $t1, $zero, fim_imprime_indices_colunas    # Vai para fim_imprime_indices_colunas
        # Imprime o indice_coluna
        addi    $a0, $t0, 1                                # $a0 = indice_coluna
        li      $v0, 1                                     # $v0 = 1 Argumento para imprimir inteiro via syscall(MARS)
        syscall
        # Imprime espaço
        li     $a0, ' '                                    # Carrega o caractere espaço em $a0
        li     $v0, 11                                     # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
        syscall

        addi    $t0, $t0, 1                                # Incrementa variável de controle
        
        j loop_imprime_indices_colunas

        fim_imprime_indices_colunas:
            li     $a0, '\n'                                    # Carrega o caractere quebra de linha em $a0
            li     $v0, 11                                     # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
            syscall
            jr  $ra                                            # Retorna para onde foi chamado loop_imprime_indices_colunas
    
    loop_imprime_linhas:
        