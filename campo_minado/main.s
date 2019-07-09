# Cabeçalho de registradores salvos usados:
# $s0 = n
# $s1 = n*n
# $s5 = número de posições sem bomba
# $s6 = matriz_sistema
# $s7 = matriz_usuario
.data
    # Mensagens
    msg_barra_5:            .asciiz "\n  |---------|"
    msg_barra_7:            .asciiz "\n  |-------------|"
    msg_barra_9:            .asciiz "\n  |-----------------|"
    msg_test:               .asciiz "\n----TESTE----\n"
    msg_test_fim_main:      .asciiz "\n----FIM_MAIN----\n"
    msg_seleciona_opc:      .asciiz "\nDigite qual o tamanho que deseja que a matriz tenha\na) 5x5\nb) 7x7\nc) 9x9\n-> "
    msg_jogar_novamente:    .asciiz "\nPara Jogar novamente digite 1 ou para encerrar a execução digite 0\n-> "
    # Vetores(Matrizes)
    matriz_usuario:         .word '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?'              # Matriz que o usuário verá
    matriz_sistema:         .word '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'              # Matriz respectiva ao funcionamento do jogo
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
        
        jal     opcao_para_n                            # Vai para a 'função' e linka o retorno a esta linha

        jal     insere_bombas                           # Insere a bomba
        jal     calcula_bombas                          # 
        jal     print_matriz_usuario
        jal     print_matriz_sistema
        
        #j       seleciona_jogar_novamente               # Verifica se o usuário deseja jogar novamente    
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
        addi    $s1, $zero, 25                      # $s1 = n*n+1
        jr      $ra

    opc_b:
        addi    $s0, $zero, 7                       # $s0 = 7
        addi    $s1, $zero, 49                      # $s1 = n*n
        jr      $ra
    opc_c:
        addi    $s0, $zero, 9                       # $s0 = 9
        addi    $s1, $zero, 81                      # $s1 = n*n
        jr      $ra                                 # Retorna para onde foi chamada



seleciona_jogar_novamente:
    la      $a0, msg_jogar_novamente                                        # carrega o endereço da mensagem em a0
    li      $v0, 4                                                          # Syscall para imprimir string
    syscall
    li      $v0, 5                                                          # Syscall para ler inteiro
    syscall
    beq     $v0, $zero, exit                                                # Se a opção for zero chama função que encerra a execução
    j       main                                                            # Se não for igual vai para main

insere_bombas_aux:
    addi    $t0, $zero, 0                                                  # $t0 == i = 0
    li      $t9, '9'                                                        # 9 é uma bomba
    addi    $t0, $zero, 0                                                   # $t0 == i = 0
    li      $t1, 5                                                          # compara se é 5
    beq     $t1, $s0, matriz_5_aux                                              # Se for igual vai para função que insere na de 5
    li      $t1, 7                                                          # compara se é 7
    beq     $t1, $s0, matriz_7_aux                                              # Se for igual vai para função que insere na de 7
    li      $t1, 9                                                          # compara se é 9
    beq     $t1, $s0, matriz_9_aux                                              # Se for igual vai para função que insere na de 9

    matriz_5_aux:
        addi    $t0, $zero, 0                                                  # $t0 == i = 0
        sw      $t9, matriz_usuario($t0)
        addi    $t0, $t0, 24                        # 4(word)*6(positions)
        sw      $t9, matriz_usuario($t0)
        addi    $t0, $t0, 24                        # 4(word)*6(positions)
        sw      $t9, matriz_usuario($t0)
        addi    $t0, $t0, 24                        # 4(word)*6(positions)
        sw      $t9, matriz_usuario($t0)
        addi    $t0, $t0, 24                        # 4(word)*6(positions)
        sw      $t9, matriz_usuario($t0)
        j		fim_loop_insere_bombas_aux				# jump to 
    matriz_7_aux:
        addi    $t0, $zero, 0                                                  # $t0 == i = 0
        sw      $t9, matriz_usuario($t0)
        addi    $t0, $t0, 32                        # 4(word)*8(positions)
        sw      $t9, matriz_usuario($t0)
        addi    $t0, $t0, 32                        # 4(word)*8(positions)
        sw      $t9, matriz_usuario($t0)
        addi    $t0, $t0, 32                        # 4(word)*8(positions)
        sw      $t9, matriz_usuario($t0)
        addi    $t0, $t0, 32                        # 4(word)*8(positions)
        sw      $t9, matriz_usuario($t0)
        addi    $t0, $t0, 32                        # 4(word)*8(positions)
        sw      $t9, matriz_usuario($t0)
        addi    $t0, $t0, 32                        # 4(word)*8(positions)
        sw      $t9, matriz_usuario($t0)
        j		fim_loop_insere_bombas_aux				# jump to 
    matriz_9_aux:
        addi    $t0, $zero, 0                                                  # $t0 == i = 0
        sw      $t9, matriz_usuario($t0)
        addi    $t0, $t0, 40                        # 4(word)*10(positions)
        sw      $t9, matriz_usuario($t0)
        addi    $t0, $t0, 40                        # 4(word)*10(positions)
        sw      $t9, matriz_usuario($t0)
        addi    $t0, $t0, 40                        # 4(word)*10(positions)
        sw      $t9, matriz_usuario($t0)
        addi    $t0, $t0, 40                        # 4(word)*10(positions)
        sw      $t9, matriz_usuario($t0)
        addi    $t0, $t0, 40                        # 4(word)*10(positions)
        sw      $t9, matriz_usuario($t0)
        addi    $t0, $t0, 40                        # 4(word)*10(positions)
        sw      $t9, matriz_usuario($t0)
        addi    $t0, $t0, 40                        # 4(word)*10(positions)
        sw      $t9, matriz_usuario($t0)
        addi    $t0, $t0, 40                        # 4(word)*10(positions)
        sw      $t9, matriz_usuario($t0)
        j		fim_loop_insere_bombas_aux				# jump to 
    fim_loop_insere_bombas_aux:
        jr $ra # Volta para $ra

insere_bombas:
    addi    $t0, $zero, 0                                                  # $t0 == i = 0
    li      $t9, '9'                                                        # 9 é uma bomba
    addi    $t0, $zero, 0                                                   # $t0 == i = 0
    li      $t1, 5                                                          # compara se é 5
    beq     $t1, $s0, matriz_5                                              # Se for igual vai para função que insere na de 5
    li      $t1, 7                                                          # compara se é 7
    beq     $t1, $s0, matriz_7                                              # Se for igual vai para função que insere na de 7
    li      $t1, 9                                                          # compara se é 9
    beq     $t1, $s0, matriz_9                                              # Se for igual vai para função que insere na de 9

    matriz_5:
        addi    $t0, $zero, 0                                                  # $t0 == i = 0
        sw      $t9, matriz_sistema($t0)
        addi    $t0, $t0, 24                        # 4(word)*6(positions)
        sw      $t9, matriz_sistema($t0)
        addi    $t0, $t0, 24                        # 4(word)*6(positions)
        sw      $t9, matriz_sistema($t0)
        addi    $t0, $t0, 24                        # 4(word)*6(positions)
        sw      $t9, matriz_sistema($t0)
        addi    $t0, $t0, 24                        # 4(word)*6(positions)
        sw      $t9, matriz_sistema($t0)
        j		fim_loop_insere_bombas				# jump to 
    matriz_7:
        addi    $t0, $zero, 0                                                  # $t0 == i = 0
        sw      $t9, matriz_sistema($t0)
        addi    $t0, $t0, 32                        # 4(word)*8(positions)
        sw      $t9, matriz_sistema($t0)
        addi    $t0, $t0, 32                        # 4(word)*8(positions)
        sw      $t9, matriz_sistema($t0)
        addi    $t0, $t0, 32                        # 4(word)*8(positions)
        sw      $t9, matriz_sistema($t0)
        addi    $t0, $t0, 32                        # 4(word)*8(positions)
        sw      $t9, matriz_sistema($t0)
        addi    $t0, $t0, 32                        # 4(word)*8(positions)
        sw      $t9, matriz_sistema($t0)
        addi    $t0, $t0, 32                        # 4(word)*8(positions)
        sw      $t9, matriz_sistema($t0)
        j		fim_loop_insere_bombas				# jump to 
    matriz_9:
        addi    $t0, $zero, 0                                                  # $t0 == i = 0
        sw      $t9, matriz_sistema($t0)
        addi    $t0, $t0, 40                        # 4(word)*10(positions)
        sw      $t9, matriz_sistema($t0)
        addi    $t0, $t0, 40                        # 4(word)*10(positions)
        sw      $t9, matriz_sistema($t0)
        addi    $t0, $t0, 40                        # 4(word)*10(positions)
        sw      $t9, matriz_sistema($t0)
        addi    $t0, $t0, 40                        # 4(word)*10(positions)
        sw      $t9, matriz_sistema($t0)
        addi    $t0, $t0, 40                        # 4(word)*10(positions)
        sw      $t9, matriz_sistema($t0)
        addi    $t0, $t0, 40                        # 4(word)*10(positions)
        sw      $t9, matriz_sistema($t0)
        addi    $t0, $t0, 40                        # 4(word)*10(positions)
        sw      $t9, matriz_sistema($t0)
        addi    $t0, $t0, 40                        # 4(word)*10(positions)
        sw      $t9, matriz_sistema($t0)
        j		fim_loop_insere_bombas				# jump to 
    fim_loop_insere_bombas:
        jr $ra # Volta para $ra

menu_jogo:
    addi        $t0, $zero, 0                                               # i = 0
    addi        $sp, $sp, 4                                                 # Incrementa o stack pointer
    sw          $ra, 0($sp)                                                 # Salva o endereço de retorno no stack pointer
    jal         loop_menu                                                   # Chama o loop_menu e linka a esta linha
    lw          $ra, 0($sp)                                                 # Pega o endereço que havia sido salvo no stack pointer e coloca em $ra
    addi        $sp, $sp, -4                                                # Decremente o stack pointer
    jr          $ra                                                         # volta ao $ra
    loop_menu:

print_matriz_usuario:
    # Imprime quebra de linha
    li     $a0, '\n'                                        # Carrega o caractere quebra de linha em $a0
    li     $v0, 11                                          # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
    syscall
    # Imprime 2 espaços para os indices:
    li     $a0, ' '                                         # Carrega o caractere espaço em $a0
    li     $v0, 11                                          # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
    syscall
    syscall

    addi    $t0, $zero, 0                                   # Variável de controle (i)
    addi    $t1, $zero, 0                                   # Variável de controle (j)
    la      $s7, matriz_usuario                             # Endereço da matriz
    addi    $t3, $zero, 0                                   # Shift logical left
    addi    $t4, $zero, 0                                   # Endereço da matriz + shift left

    addi    $sp, $sp, 4                                     # Incrementa pilha
    sw      $ra, 0($sp)                                     # Armazena endereço de retorno no topo da pilha
    jal     print_indices_coluna_matriz_usuario             # Chama função
    lw      $ra, 0($sp)                                     # Carrega o endereço de retorno do topo da pilha em $ra
    addi    $sp, $sp, -4                                    # Decrementa pilha

    addi    $sp, $sp, 4                                     # Incrementa pilha
    sw      $ra, 0($sp)                                     # Armazena endereço de retorno no topo da pilha
    jal     print_linha_separador_matriz_usuario            # Chama função
    lw      $ra, 0($sp)                                     # Carrega o endereço de retorno do topo da pilha em $ra
    addi    $sp, $sp, -4                                    # Decrementa pilha

    addi    $sp, $sp, 4                                     # Incrementa pilha
    sw      $ra, 0($sp)                                     # Armazena endereço de retorno no topo da pilha
    jal     print_linhas_matriz_usuario                     # Chama função
    lw      $ra, 0($sp)                                     # Carrega o endereço de retorno do topo da pilha em $ra
    addi    $sp, $sp, -4                                    # Decrementa pilha

    jr      $ra                                             # Retorna para o endereço em $ra
    
    print_linhas_matriz_usuario:
        addi    $t1, $zero, 0                                    # j = 0
        mult    $s0, $t0                                         # n*i
        mflo    $s3                                              # $s3 = n*i
        beq     $t0, $s0, fim_print_linhas_matriz_usuario        #
        # Imprime quebra de linha
        li      $a0, '\n'                                        # Carrega o caractere quebra de linha em $a0
        li      $v0, 11                                          # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
        syscall
        # Imprime indice linha
        addi    $a0, $t0, 1                                      # $a0 recebe o valor de linha (i)
        li      $v0, 1                                           # $v0 = 1 Argumento para imprimir inteiro via syscall(MARS)
        syscall
        # Imprime espaço
        li      $a0, ' '                                         # Carrega o caractere espaço em $a0
        li      $v0, 11                                          # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
        syscall
        # Imprime barra
        li      $a0, '|'                                         # Carrega o caractere barra em $a0
        li      $v0, 11                                          # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
        syscall

        addi    $sp, $sp, 4                                     # Incrementa pilha
        sw      $ra, 0($sp)                                     # Armazena endereço de retorno no topo da pilha
        jal     print_valores_matriz_usuario                    # Chama função
        lw      $ra, 0($sp)                                     # Carrega o endereço de retorno do topo da pilha em $ra
        addi    $sp, $sp, -4                                    # Decrementa pilha

        addi    $sp, $sp, 4                                     # Incrementa pilha
        sw      $ra, 0($sp)                                     # Armazena endereço de retorno no topo da pilha
        jal     print_linha_separador_matriz_usuario            # Chama função
        lw      $ra, 0($sp)                                     # Carrega o endereço de retorno do topo da pilha em $ra
        addi    $sp, $sp, -4                                    # Decrementa pilha
        
        addi    $t0, $t0, 1                                      # Incrementa i

        j       print_linhas_matriz_usuario                      # Volta pro loop

    print_valores_matriz_usuario:
        beq     $t1, $s0, fim_print_valores_matriz_usuario       # j == n

        add     $t4, $t1, $s3                                    # $t4 = j+(i*n)

        sll     $t4, $t4, 2                                      # Shift logical left
        add     $t4, $s7, $t4                                    # $t4 = endereço+deslocamento
        addi    $t1, $t1, 1                                      # Incrementa j em 1

        lw      $a0, 0($t4)                                      # Carrega o valor em $a0
        li      $v0, 11                                          # Chamada para imprimir caractere
        syscall
        # Imprime barra
        li      $a0, '|'                                         # Carrega o caractere barra em $a0
        li      $v0, 11                                          # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
        syscall
        j       print_valores_matriz_usuario                     # Retorna pro loop
    
        fim_print_valores_matriz_usuario:
            jr      $ra                                          # Retorna pro endereço de chamada em $ra

    fim_print_linhas_matriz_usuario:
        jr      $ra                                              # Retorna pro endereço de chamada em $ra

    print_indices_coluna_matriz_usuario:
        li     $a0, ' '                                         # Carrega o caractere espaço em $a0
        li     $v0, 11                                          # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
        syscall
        addi    $a0, $t0, 1                                     # Indice a ser impresso
        li      $v0, 1                                          # Chamada para imprimir inteiro
        syscall
        addi    $t0, $t0, 1                                     # Incrementa indice
        bne     $t0, $s0, print_indices_coluna_matriz_usuario   # Retorna ao loop
        add     $t0, $zero, $zero                               # Volta o valor de $t0 para 0
        jr      $ra                                             # Volta para o endereço de retorno

    print_linha_separador_matriz_usuario:
        li      $a0, 5                                      # Carrega 5 em $a0 para comparação
        beq     $a0, $s0, print_linha_separador_tamanho_5   # Se for igual a 5 o tamanho da matriz chama função
        li      $a0, 7                                      # Carrega 7 em $a0 para comparação
        beq     $a0, $s0, print_linha_separador_tamanho_7   # Se for igual a 7 o tamanho da matriz chama função        
        li      $a0, 9                                      # Carrega 9 em $a0 para comparação
        beq     $a0, $s0, print_linha_separador_tamanho_9   # Se for igual a 9 o tamanho da matriz chama função

print_matriz_sistema:
    # Imprime quebra de linha
    li     $a0, '\n'                                        # Carrega o caractere quebra de linha em $a0
    li     $v0, 11                                          # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
    syscall
    # Imprime 2 espaços para os indices:
    li     $a0, ' '                                         # Carrega o caractere espaço em $a0
    li     $v0, 11                                          # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
    syscall
    syscall

    addi    $t0, $zero, 0                                   # Variável de controle (i)
    addi    $t1, $zero, 0                                   # Variável de controle (j)
    la      $s7, matriz_sistema                             # Endereço da matriz
    addi    $t3, $zero, 0                                   # Shift logical left
    addi    $t4, $zero, 0                                   # Endereço da matriz + shift left

    addi    $sp, $sp, 4                                     # Incrementa pilha
    sw      $ra, 0($sp)                                     # Armazena endereço de retorno no topo da pilha
    jal     print_indices_coluna_matriz_sistema             # Chama função
    lw      $ra, 0($sp)                                     # Carrega o endereço de retorno do topo da pilha em $ra
    addi    $sp, $sp, -4                                    # Decrementa pilha

    addi    $sp, $sp, 4                                     # Incrementa pilha
    sw      $ra, 0($sp)                                     # Armazena endereço de retorno no topo da pilha
    jal     print_linha_separador_matriz_sistema            # Chama função
    lw      $ra, 0($sp)                                     # Carrega o endereço de retorno do topo da pilha em $ra
    addi    $sp, $sp, -4                                    # Decrementa pilha

    addi    $sp, $sp, 4                                     # Incrementa pilha
    sw      $ra, 0($sp)                                     # Armazena endereço de retorno no topo da pilha
    jal     print_linhas_matriz_sistema                     # Chama função
    lw      $ra, 0($sp)                                     # Carrega o endereço de retorno do topo da pilha em $ra
    addi    $sp, $sp, -4                                    # Decrementa pilha

    jr      $ra                                             # Retorna para o endereço em $ra
    
    print_linhas_matriz_sistema:
        addi    $t1, $zero, 0                                    # j = 0
        mult    $s0, $t0                                         # n*i
        mflo    $s3                                              # $s3 = n*i
        beq     $t0, $s0, fim_print_linhas_matriz_sistema        #
        # Imprime quebra de linha
        li      $a0, '\n'                                        # Carrega o caractere quebra de linha em $a0
        li      $v0, 11                                          # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
        syscall
        # Imprime indice linha
        addi    $a0, $t0, 1                                      # $a0 recebe o valor de linha (i)
        li      $v0, 1                                           # $v0 = 1 Argumento para imprimir inteiro via syscall(MARS)
        syscall
        # Imprime espaço
        li      $a0, ' '                                         # Carrega o caractere espaço em $a0
        li      $v0, 11                                          # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
        syscall
        # Imprime barra
        li      $a0, '|'                                         # Carrega o caractere barra em $a0
        li      $v0, 11                                          # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
        syscall

        addi    $sp, $sp, 4                                     # Incrementa pilha
        sw      $ra, 0($sp)                                     # Armazena endereço de retorno no topo da pilha
        jal     print_valores_matriz_sistema                    # Chama função
        lw      $ra, 0($sp)                                     # Carrega o endereço de retorno do topo da pilha em $ra
        addi    $sp, $sp, -4                                    # Decrementa pilha

        addi    $sp, $sp, 4                                     # Incrementa pilha
        sw      $ra, 0($sp)                                     # Armazena endereço de retorno no topo da pilha
        jal     print_linha_separador_matriz_sistema            # Chama função
        lw      $ra, 0($sp)                                     # Carrega o endereço de retorno do topo da pilha em $ra
        addi    $sp, $sp, -4                                    # Decrementa pilha
        
        addi    $t0, $t0, 1                                      # Incrementa i

        j       print_linhas_matriz_sistema                      # Volta pro loop

    print_valores_matriz_sistema:
        beq     $t1, $s0, fim_print_valores_matriz_sistema       # j == n

        add     $t4, $t1, $s3                                    # $t4 = j+(i*n)

        sll     $t4, $t4, 2                                      # Shift logical left
        add     $t4, $s7, $t4                                    # $t4 = endereço+deslocamento
        addi    $t1, $t1, 1                                      # Incrementa j em 1

        lw      $a0, 0($t4)                                      # Carrega o valor em $a0
        li      $v0, 11                                          # Chamada para imprimir caractere
        syscall
        # Imprime barra
        li      $a0, '|'                                         # Carrega o caractere barra em $a0
        li      $v0, 11                                          # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
        syscall
        j       print_valores_matriz_sistema                     # Retorna pro loop
    
        fim_print_valores_matriz_sistema:
            jr      $ra                                          # Retorna pro endereço de chamada em $ra

    fim_print_linhas_matriz_sistema:
        jr      $ra                                              # Retorna pro endereço de chamada em $ra

    print_indices_coluna_matriz_sistema:
        li     $a0, ' '                                         # Carrega o caractere espaço em $a0
        li     $v0, 11                                          # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
        syscall
        addi    $a0, $t0, 1                                     # Indice a ser impresso
        li      $v0, 1                                          # Chamada para imprimir inteiro
        syscall
        addi    $t0, $t0, 1                                     # Incrementa indice
        bne     $t0, $s0, print_indices_coluna_matriz_sistema   # Retorna ao loop
        add     $t0, $zero, $zero                               # Volta o valor de $t0 para 0
        jr      $ra                                             # Volta para o endereço de retorno

    print_linha_separador_matriz_sistema:
        li      $a0, 5                                      # Carrega 5 em $a0 para comparação
        beq     $a0, $s0, print_linha_separador_tamanho_5   # Se for igual a 5 o tamanho da matriz chama função
        li      $a0, 7                                      # Carrega 7 em $a0 para comparação
        beq     $a0, $s0, print_linha_separador_tamanho_7   # Se for igual a 7 o tamanho da matriz chama função        
        li      $a0, 9                                      # Carrega 9 em $a0 para comparação
        beq     $a0, $s0, print_linha_separador_tamanho_9   # Se for igual a 9 o tamanho da matriz chama função

print_linha_separador_tamanho_5:
    la      $a0, msg_barra_5                                    # Carrega o endereço de msg_barra_5 em $a0
    li      $v0, 4                                              # Chamada para imprimir string
    syscall
    jr      $ra                                                 # Volta para o endereço de retorno em $ra

print_linha_separador_tamanho_7:
    la      $a0, msg_barra_7                                    # Carrega o endereço de msg_barra_7 em $a0
    li      $v0, 4                                              # Chamada para imprimir string
    syscall
    jr      $ra                                                 # Volta para o endereço de retorno em $ra

print_linha_separador_tamanho_9:
    la      $a0, msg_barra_9                                    # Carrega o endereço de msg_barra_9 em $a0
    li      $v0, 4                                              # Chamada para imprimir string
    syscall
    jr      $ra                                                 # Volta para o endereço de retorno em $ra

calcula_bombas:
    addi    $t0, $zero, 0                       # Inicia i
    addi    $t1, $zero, 0                       # Inicia j
    addi    $t2, $zero, 0                       # 
    addi    $t3, $zero, 0                       # 
    addi    $t4, $zero, 4                       # $t4 == 4
    addi    $s3, $zero, 0                       # $s3 é o endereço+deslocamento
    addi    $s5, $zero, 0                       # Contador de bombas
    la      $s7, matriz_sistema                 # Endereço
    li      $t9, '9'                            # Valor a ser comparado
    li      $s6, '0'                                            # Valor a ser inserido
    j       loop_calcula_bombas_linhas          # Pula para o loop calcula bombas linhas

    loop_calcula_bombas_linhas:
        beq     $t0, $s0, encerra_calculo                               # if (i == n) break 
        mult    $t0, $s0                                                # i*n
        mflo    $t3                                                     # $t3 = i*n
        j		loop_calcula_bombas_colunas		                        # jump to loop_calcula_bombas_colunas
        
        loop_calcula_bombas_colunas:
            beq     $t1, $s0, incrementa_loop_calcula_bombas_linhas     # if (j == n)

            add     $t4, $t3, $t1                                       # (i*n)+j
            sll     $t4, $t4, 2                                         # ((i*n)+j)*4
            add     $s3, $s7, $t4                                       # Endereço + Deslocamento
            lw      $a0, 0($s3)                                         # Carrega o valor em $a0

            beq     $t9, $a0, incrementa_loop_calcula_bombas_colunas    # if(valor == '9')
            
            #### Verificações ####

            addi    $sp, $sp, 4                                         # Incrementa Stack Pointer
            sw      $ra, 0($sp)                                         # Salva $ra no topo de $sp
            jal     verifica_acima                                      # 
            lw      $ra, 0($sp)                                         # Carrega $ra do topo em $sp
            addi    $sp, $sp, -4                                        # Incrementa Stack Pointer

            addi    $sp, $sp, 4                                         # Incrementa Stack Pointer
            sw      $ra, 0($sp)                                         # Salva $ra no topo de $sp
            jal     verifica_abaixo                                     # 
            lw      $ra, 0($sp)                                         # Carrega $ra do topo em $sp
            addi    $sp, $sp, -4                                        # Incrementa Stack Pointer

            addi    $sp, $sp, 4                                         # Incrementa Stack Pointer
            sw      $ra, 0($sp)                                         # Salva $ra no topo de $sp
            jal     verifica_esquerda                                   # 
            lw      $ra, 0($sp)                                         # Carrega $ra do topo em $sp
            addi    $sp, $sp, -4                                        # Incrementa Stack Pointer

            addi    $sp, $sp, 4                                         # Incrementa Stack Pointer
            sw      $ra, 0($sp)                                         # Salva $ra no topo de $sp
            jal     verifica_direita                                    #
            lw      $ra, 0($sp)                                         # Carrega $ra do topo em $sp
            addi    $sp, $sp, -4                                        # Incrementa Stack Pointer

            addi    $sp, $sp, 4                                         # Incrementa Stack Pointer
            sw      $ra, 0($sp)                                         # Salva $ra no topo de $sp
            jal     verifica_diagonal_inferior_esquerda                 #
            lw      $ra, 0($sp)                                         # Carrega $ra do topo em $sp
            addi    $sp, $sp, -4                                        # Incrementa Stack Pointer

            addi    $sp, $sp, 4                                         # Incrementa Stack Pointer
            sw      $ra, 0($sp)                                         # Salva $ra no topo de $sp
            jal     verifica_diagonal_inferior_direita                  # 
            lw      $ra, 0($sp)                                         # Carrega $ra do topo em $sp
            addi    $sp, $sp, -4                                        # Incrementa Stack Pointer

            addi    $sp, $sp, 4                                         # Incrementa Stack Pointer
            sw      $ra, 0($sp)                                         # Salva $ra no topo de $sp
            jal     verifica_diagonal_superior_esquerda                 # 
            lw      $ra, 0($sp)                                         # Carrega $ra do topo em $sp
            addi    $sp, $sp, -4                                        # Incrementa Stack Pointer

            addi    $sp, $sp, 4                                         # Incrementa Stack Pointer
            sw      $ra, 0($sp)                                         # Salva $ra no topo de $sp
            jal     verifica_diagonal_superior_direita                  # 
            lw      $ra, 0($sp)                                         # Carrega $ra do topo em $sp
            addi    $sp, $sp, -4                                        # Incrementa Stack Pointer

            sw      $s6, 0($s3)                                         # Store new value
            li      $s6, '0'
            j       incrementa_loop_calcula_bombas_colunas

    # if(i-1 >= 0)
    verifica_acima:
        addi    $t5, $t0, -1                        # i-1
        addi    $t6, $t1, 0                         # j
        slt     $t7, $t5, $zero                     # i-1 < 0 ? 1 : 0
        beq     $t7, $zero, verifica_nove           # Se i-1 >= 0
        jr      $ra                                 # Return;

    # if(i+1 < n)
    verifica_abaixo:
        addi    $t5, $t0, 1                         # i+1
        addi    $t6, $t1, 0                         # j
        slt     $t7, $t5, $s0                       # i+1 < n ? 1 : 0
        bne     $t7, $zero, verifica_nove           # Se i+1 < n
        jr      $ra                                 # Return;

    # if(j-1 >= 0)
    verifica_esquerda:
        addi    $t5, $t0, 0                         # i
        addi    $t6, $t1, -1                        # j-1
        slt     $t7, $t6, $zero                     # j-1 < 0 ? 1 : 0
        beq     $t7, $zero, verifica_nove           # Se i-1 >= 0
        #slt     $t7, $t5, $zero                     # i < 0 ? 1 : 0
        #beq     $t7, $zero, verifica_esquerda_1     # Se i >= 0
        jr      $ra                                 # Return;
        #verifica_esquerda_1:
        #    slt     $t7, $t6, $zero                 # j-1 < 0 ? 1 : 0
        #    beq     $t7, $zero, verifica_nove       # Se i-1 >= 0
        #    jr      $ra                             # Return;

    # if(i < n && j+1 < n)
    verifica_direita:
        addi    $t5, $t0, 0                         # i
        addi    $t6, $t1, 1                         # j+1
        slt     $t7, $t0, $s0                       # i < n ? 1 : 0
        bne     $t7, $zero, verifica_direita_1      # Se i < n
        jr      $ra                                 # Return;
        verifica_direita_1:
            slt     $t7, $t6, $s0                   # j+1 < n ? 1 : 0
            bne     $t7, $zero, verifica_nove       # Se j+1 < n
            jr      $ra                             # Return;
    
    # if(i-1 >= 0 && j-1 >= 0)
    verifica_diagonal_superior_esquerda:
        addi    $t5, $t0, -1                    # i-1
        addi    $t6, $t1, -1                    # j-1
        slt     $t7, $t5, $zero                 # i-1 < 0 ? 1 : 0
        beq     $t7, $zero, verifica_diagonal_superior_esquerda_1   # Se i-1 >= 0
        jr      $ra                             # Return;
        verifica_diagonal_superior_esquerda_1:
            slt     $t7, $t6, $zero             # j-1 < 0 ? 1 : 0
            beq     $t7, $zero, verifica_nove   # Se j-1 >= 0
            jr      $ra                         # Return;
    
    # if(i+1 < n && j-1 >= 0)
    verifica_diagonal_inferior_esquerda:
        addi    $t5, $t0, 1                     # i+1
        addi    $t6, $t1, -1                    # j-1
        slt     $t7, $t5, $s0                   # i+1 < n ? 1 : 0
        bne     $t7, $zero, verifica_diagonal_inferior_esquerda_1   # Se i+1 < n
        jr      $ra                             # Return;
        verifica_diagonal_inferior_esquerda_1:
            slt     $t7, $t6, $zero             # j-1 < 0 ? 1 : 0
            beq     $t7, $zero, verifica_nove   # Se j-1 >= 0
            jr      $ra                         # Return;

    # if(i-1 >= 0 && j+1 < n)
    verifica_diagonal_superior_direita:
        addi    $t5, $t0, -1                    # i-1
        addi    $t6, $t1, 1                     # j+1
        slt     $t7, $t5, $zero                 # i-1 < 0 ? 1 : 0
        beq     $t7, $zero, verifica_diagonal_superior_direita_1   # Se i-1 >= 0
        jr      $ra                             # Return;
        verifica_diagonal_superior_direita_1:
            slt     $t7, $t6, $s0               # j+1 < n ? 1 : 0
            bne     $t7, $zero, verifica_nove   # Se j+1 < n
            jr      $ra                         # Return;

    # if(i+1 < n && j+1 < n)
    verifica_diagonal_inferior_direita:
        addi    $t5, $t0, 1                     # i+1
        addi    $t6, $t1, 1                     # j+1
        slt     $t7, $t5, $zero                 # i+1 < n ? 1 : 0
        bne     $t7, $zero, verifica_diagonal_inferior_direita_1   # Se j+1 < n
        jr      $ra                             # Return;
        verifica_diagonal_inferior_direita_1:
            slt     $t7, $t6, $s0               # j+1 < n ? 1 : 0
            bne     $t7, $zero, verifica_nove   # Se j+1 < n
            jr      $ra                         # Return;

    verifica_nove:
        mult    $t5, $s0                        # i*n
        mflo    $t7                             # t7 = i*n
        add     $t7, $t7, $t6                   # i*n+j
        sll     $t7, $t7, 2                     # (i*n+j)*4
        add     $t7, $s7, $t7                   # Endereço+Deslocamento
        lw      $t8, 0($t7)                     # t8 verifica se possui um 9 na posição
        beq     $t9, $t8, verifica_insercao     # Vai para inserção
        jr      $ra                             # Return;

    verifica_insercao:
        li      $a0, '0'                        # load 0 to compare
        beq     $a0, $s6, incrementa_1          # $s6 vira '1'
        li      $a0, '1'                        # load 0 to compare
        beq     $a0, $s6, incrementa_2          # $s6 vira '2'
        li      $a0, '2'                        # load 0 to compare
        beq     $a0, $s6, incrementa_3          # $s6 vira '3'
        li      $a0, '3'                        # load 0 to compare
        beq     $a0, $s6, incrementa_4          # $s6 vira '4'
        li      $a0, '4'                        # load 0 to compare
        beq     $a0, $s6, incrementa_5          # $s6 vira '5'
        li      $a0, '5'                        # load 0 to compare
        beq     $a0, $s6, incrementa_6          # $s6 vira '6'
        li      $a0, '6'                        # load 0 to compare
        beq     $a0, $s6, incrementa_7          # $s6 vira '7'
        li      $a0, '7'                        # load 0 to compare
        beq     $a0, $s6, incrementa_8          # $s6 vira '8'
        jr      $ra
        incrementa_1:
            li      $s6, '1'                    # $s6 == 1
            jr      $ra                         # Return;
        incrementa_2:
            li      $s6, '2'                    # $s6 == 1
            jr      $ra                         # Return;
        incrementa_3:
            li      $s6, '3'                    # $s6 == 1
            jr      $ra                         # Return;
        incrementa_4:
            li      $s6, '4'                    # $s6 == 1
            jr      $ra                         # Return;
        incrementa_5:
            li      $s6, '5'                    # $s6 == 1
            jr      $ra                         # Return;
        incrementa_6:
            li      $s6, '6'                    # $s6 == 1
            jr      $ra                         # Return;
        incrementa_7:
            li      $s6, '7'                    # $s6 == 1
            jr      $ra                         # Return;
        incrementa_8:
            li      $s6, '8'                    # $s6 == 1
            jr      $ra                         # Return;
    incrementa_loop_calcula_bombas_linhas:
        addi    $t1, $zero, 0                   # j = 0;
        addi    $t0, $t0, 1                     # i++;
        j       loop_calcula_bombas_linhas      # Volta para o loop

    incrementa_loop_calcula_bombas_colunas:
        addi    $t1, $t1, 1                     # j++;
        j       loop_calcula_bombas_colunas     # Volta para o loop

    encerra_calculo:
        jr      $ra                             # Volta para $ra