# Cabeçalho de registradores salvos usados:
# $s0 = n
# $s1 = n*n
# $s6 = matriz_jogo
# $s7 = matriz_usuario
.data
    # Mensagens
    byte_interrogacao:      .byte '?'
    msg_test:               .asciiz "\n----TESTE----\n"
    msg_test_fim_main:      .asciiz "\n----FIM_MAIN----\n"
    msg_seleciona_opc:      .asciiz "\nDigite qual o tamanho que deseja que a matriz tenha\na) 5x5\nb) 7x7\nc) 9x9\n-> "
    msg_jogar_novamente:    .asciiz "\nPara Jogar novamente digite 1 ou para encerrar a execução digite 0\n-> "
    # Vetores(Matrizes)
    matriz_usuario:         .word 82                # Matriz que o usuário verá
    matriz_sistema:         .word                 # Matriz respectiva ao funcionamento do jogo
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
        jal     preenche_matriz_usuario                 # Preenche a matriz que o usuário vê com ?
        jal     imprime_matriz_usuario                  # Vai para a 'função' e linka o retorno a esta linha
        
        jal     insere_bombas                           # Insere a bomba
        la      $a0, matriz_sistema
        li      $v0, 4
        syscall
        jal     imprime_matriz_sistema

        li      $a1, 0
        lw      $a0, matriz_sistema($a1)
        li      $v0, 11
        syscall

        j       seleciona_jogar_novamente               # Verifica se o usuário deseja jogar novamente    
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
    add     $t1, $zero, $zero                       # Inicializa Variável de controle
    add     $t2, $zero, $zero                       # Inicializa iterador
    addi    $t3, $s1, -1                            # n*n-1
    li      $s5, '?'                                # Carrega um caractere em $s5 (lw = LoadByte)

    j		enquanto_nao_estiver_preenchida		    # jump to enquanto_nao_estiver_preenchida

    enquanto_nao_estiver_preenchida:
        beq     $t1, $t3, fim_preenche_matriz_usuario    # Vai para fim_preenche_matriz_usuario

        sw	    $s5, matriz_usuario($t2)		                         # Coloca o caractere ? na posição i da matriz StoreByte
        addi    $t1, $t1, 1                              # Incrementa a variável de controle
        addi    $t2, $t2, 4                              # Muda a posição do vetor
        
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
    addi    $sp, $sp, 4                             # Incrementa o stackpointer
    sw      $ra, 0($sp)                             # Salva o endereço de retorno em $sp
    addi    $t5, $zero, 1                           # Iterador de loop_chama_imprime_linhas
    addi    $t6, $s0, 1                             # $t6 = n+1
    addi    $s3, $zero, 0                           # Iterator to print all table
    jal     loop_chama_imprime_linhas
    lw      $ra, 0($sp)                             # Carrega o endereço de retorno em $ra
    addi    $sp, $sp, -4                            # Decrementa o stackpointer
    addi    $sp, $sp, 4                             # Incrementa o stackpointer
    sw      $ra, 0($sp)                             # Salva o endereço de retorno em $sp
    jal     loop_imprime_linha_separador
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
            li     $v0, 11                                      # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
            syscall
            jr  $ra                                             # Retorna para onde foi chamado loop_imprime_indices_colunas
    
    loop_chama_imprime_linhas: beq      $t5, $t6, fim_loop_chama_imprime_linhas 
            # Compara se i < n (Quantidade de elementos por linha)
            addi    $sp, $sp, 4                                         # Incementa o stackpointer
            sw      $ra, 0($sp)                                         # Salva o endereço de retorno em $sp
            jal     loop_imprime_linha_separador
            lw      $ra, 0($sp)                                         # Carrega o endereço de retorno em $ra
            addi    $sp, $sp, -4                                        # Decrementa o stackpointer
            addi    $a0, $t0, 1                                         # $a0 = indice_coluna
            
            # Imprime a linha e os caracteres
            add     $a0, $zero, $t5                                        # Contador do loop
            li      $v0, 1                                          # $v0 = 1 Argumento para imprimir inteiro via syscall(MARS)
            syscall
            li      $a0, ' '                                        # Carrega o caractere espaço em $a0
            li      $v0, 11                                         # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
            syscall
            addi    $t2, $zero, 0                                       # $t2 recebe matriz do usuário
            addi    $t0, $zero, 0                                       # i = 0
            #addi    $t1, $s0, -1                                        # $t1 = n-1
            addi    $sp, $sp, 4                                         # Incementa o stackpointer
            sw      $ra, 0($sp)                                         # Salva o endereço de retorno em $sp
            jal     loop_imprime_linha
            lw      $ra, 0($sp)                                         # Carrega o endereço de retorno em $ra
            addi    $sp, $sp, -4                                        # Decrementa o stackpointer
            addi    $a0, $t0, 1                                         # $a0 = indice_coluna

            addi    $t5, $t5, 1
            j loop_chama_imprime_linhas
        fim_loop_chama_imprime_linhas:
            jr $ra

        loop_imprime_linha_separador:
            # Imprime espaço
            li     $a0, ' '                                    # Carrega o caractere espaço em $a0
            li     $v0, 11                                     # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
            syscall
            syscall
            li      $a0, '|'                                        # Carrega o caractere quebra de linha em $a0
            li      $v0, 11                                         # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
            syscall
            addi    $t0, $zero, 1                                   # i = 1
            # Quantidade de caractere - == n+n
            add     $t1, $s0, $s0                                   # n+n
            j       loop_separador
            loop_separador: beq     $t0, $t1, fim_loop_imprime_linha_separador      
                li      $a0, '-'                                            # Carrega o caractere - em $a0
                li      $v0, 11                                             # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
                syscall

                addi    $t0, $t0, 1                                         # incrementa em um o contador
                j       loop_separador

            fim_loop_imprime_linha_separador:
                li      $a0, '|'                                        # Carrega o caractere quebra de linha em $a0
                li      $v0, 11                                         # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
                syscall
                li      $a0, '\n'                                           # Carrega o caractere quebra de linha em $a0
                li      $v0, 11                                             # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
                syscall
                jr      $ra

        loop_imprime_linha: beq     $t0, $s0, fim_loop_imprime_linha
            li      $a0, '|'                                        # Carrega o caractere | em $a0
            li      $v0, 11                                         # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
            syscall
            lw      $a0, matriz_usuario($s3)                        # $teste2 recebe o caractere a ser impresso
            li      $v0, 11                                         # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
            syscall

            addi    $s3, $s3, 4                                     # Incrementa posição no vetor
            addi    $t0, $t0, 1                                     # Incrementa contador
            j loop_imprime_linha

            fim_loop_imprime_linha:
                li      $a0, '|'                                            # Carrega o caractere | em $a0
                li      $v0, 11                                             # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
                syscall
                li      $a0, '\n'                                           # Carrega o caractere quebra de linha em $a0
                li      $v0, 11                                             # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
                syscall
                jr      $ra

seleciona_jogar_novamente:
    la      $a0, msg_jogar_novamente                                        # carrega o endereço da mensagem em a0
    li      $v0, 4                                                          # Syscall para imprimir string
    syscall
    li      $v0, 5                                                          # Syscall para ler inteiro
    syscall
    beq     $v0, $zero, exit                                                # Se a opção for zero chama função que encerra a execução
    j       main                                                            # Se não for igual vai para main

insere_bombas:
    li      $t9, '9'                                                          # 9 é uma bomba
    addi    $t0, $zero, 0                                                   # $t0 == i = 0
    addi    $t1, $zero, 5                                                   # compara se é 5
    beq     $t1, $s0, matriz_5                                              # Se for igual vai para função que insere na de 5
    addi    $t1, $zero, 7                                                   # compara se é 7
    beq     $t1, $s0, matriz_7                                              # Se for igual vai para função que insere na de 7
    addi    $t1, $zero, 9                                                   # compara se é 9
    beq     $t1, $s0, matriz_9                                              # Se for igual vai para função que insere na de 9
    matriz_5:
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
        jr		$ra                                     					# Volta para $ra

menu_jogo:
    addi        $t0, $zero, 0                                               # i = 0
    addi        $sp, $sp, 4                                                 # Incrementa o stack pointer
    sw          $ra, 0($sp)                                                 # Salva o endereço de retorno no stack pointer
    jal         loop_menu                                                   # Chama o loop_menu e linka a esta linha
    lw          $ra, 0($sp)                                                 # Pega o endereço que havia sido salvo no stack pointer e coloca em $ra
    addi        $sp, $sp, -4                                                # Decremente o stack pointer
    jr          $ra                                                         # volta ao $ra
    loop_menu:

imprime_matriz_sistema:
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
    addi    $s3, $zero, 4                           # $t2 indice da matriz do usuario

    addi    $sp, $sp, 4                             # Incrementa o stackpointer
    sw      $ra, 0($sp)                             # Salva o endereço de retorno em $sp
    jal     loop_imprime_indices_colunas_s
    lw      $ra, 0($sp)                             # Carrega o endereço de retorno em $ra
    addi    $sp, $sp, -4                            # Decrementa o stackpointer
    addi    $sp, $sp, 4                             # Incrementa o stackpointer
    sw      $ra, 0($sp)                             # Salva o endereço de retorno em $sp
    addi    $t5, $zero, 1                           # Iterador de loop_chama_imprime_linhas_s
    addi    $t6, $s0, 1                             # $t6 = n+1
    jal     loop_chama_imprime_linhas_s
    lw      $ra, 0($sp)                             # Carrega o endereço de retorno em $ra
    addi    $sp, $sp, -4                            # Decrementa o stackpointer
    addi    $sp, $sp, 4                             # Incrementa o stackpointer
    sw      $ra, 0($sp)                             # Salva o endereço de retorno em $sp
    jal     loop_imprime_linha_separador_s
    lw      $ra, 0($sp)                             # Carrega o endereço de retorno em $ra
    addi    $sp, $sp, -4                            # Decrementa o stackpointer
    jr      $ra
    
    loop_imprime_indices_colunas_s:
        # Compara
        slt     $t1, $t0, $s0                              # Se i < n+1 então $t2 = 1
        beq     $t1, $zero, fim_imprime_indices_colunas_s    # Vai para fim_imprime_indices_colunas_s
        # Imprime o indice_coluna
        addi    $a0, $t0, 1                                # $a0 = indice_coluna
        li      $v0, 1                                     # $v0 = 1 Argumento para imprimir inteiro via syscall(MARS)
        syscall
        # Imprime espaço
        li     $a0, ' '                                    # Carrega o caractere espaço em $a0
        li     $v0, 11                                     # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
        syscall

        addi    $t0, $t0, 1                                # Incrementa variável de controle
        
        j loop_imprime_indices_colunas_s

        fim_imprime_indices_colunas_s:
            li     $a0, '\n'                                    # Carrega o caractere quebra de linha em $a0
            li     $v0, 11                                      # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
            syscall
            jr  $ra                                             # Retorna para onde foi chamado loop_imprime_indices_colunas_s
    
    loop_chama_imprime_linhas_s: beq      $t5, $t6, fim_loop_chama_imprime_linhas_s 
            # Compara se i < n (Quantidade de elementos por linha)
            addi    $sp, $sp, 4                                         # Incementa o stackpointer
            sw      $ra, 0($sp)                                         # Salva o endereço de retorno em $sp
            jal     loop_imprime_linha_separador_s
            lw      $ra, 0($sp)                                         # Carrega o endereço de retorno em $ra
            addi    $sp, $sp, -4                                        # Decrementa o stackpointer
            addi    $a0, $t0, 1                                         # $a0 = indice_coluna
            
            # Imprime a linha e os caracteres
            add     $a0, $zero, $t5                                        # Contador do loop
            li      $v0, 1                                          # $v0 = 1 Argumento para imprimir inteiro via syscall(MARS)
            syscall
            li      $a0, ' '                                        # Carrega o caractere espaço em $a0
            li      $v0, 11                                         # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
            syscall
            addi    $t0, $zero, 0                                       # i = 0
            #addi    $t1, $s0, -1                                        # $t1 = n-1
            addi    $sp, $sp, 4                                         # Incementa o stackpointer
            sw      $ra, 0($sp)                                         # Salva o endereço de retorno em $sp
            jal     loop_imprime_linha
            lw      $ra, 0($sp)                                         # Carrega o endereço de retorno em $ra
            addi    $sp, $sp, -4                                        # Decrementa o stackpointer
            addi    $a0, $t0, 1                                         # $a0 = indice_coluna

            addi    $t5, $t5, 1
            j loop_chama_imprime_linhas_s
        fim_loop_chama_imprime_linhas_s:
            jr $ra

        loop_imprime_linha_separador_s:
            # Imprime espaço
            li     $a0, ' '                                    # Carrega o caractere espaço em $a0
            li     $v0, 11                                     # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
            syscall
            syscall
            li      $a0, '|'                                        # Carrega o caractere quebra de linha em $a0
            li      $v0, 11                                         # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
            syscall
            addi    $t0, $zero, 1                                   # i = 1
            # Quantidade de caractere - == n+n
            add     $t1, $s0, $s0                                   # n+n
            j       loop_separador_s
            loop_separador_s: beq     $t0, $t1, fim_loop_imprime_linha_separador_s      
                li      $a0, '-'                                            # Carrega o caractere - em $a0
                li      $v0, 11                                             # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
                syscall

                addi    $t0, $t0, 1                                         # incrementa em um o contador
                j       loop_separador_s

            fim_loop_imprime_linha_separador_s:
                li      $a0, '|'                                        # Carrega o caractere quebra de linha em $a0
                li      $v0, 11                                         # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
                syscall
                li      $a0, '\n'                                           # Carrega o caractere quebra de linha em $a0
                li      $v0, 11                                             # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
                syscall
                jr      $ra

        loop_imprime_linha_s: beq     $t0, $s0, fim_loop_imprime_linha
            li      $a0, '|'                                        # Carrega o caractere | em $a0
            li      $v0, 11                                         # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
            syscall
            lw      $a0, matriz_sistema($s3)                        # $teste2 recebe o caractere a ser impresso
            li      $v0, 11                                         # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
            syscall

            addi    $s3, $s3, 4                                     # Incrementa posição no vetor
            addi    $t0, $t0, 1                                     # Incrementa contador
            j loop_imprime_linha_s

            fim_loop_imprime_linha_s:
                li      $a0, '|'                                            # Carrega o caractere | em $a0
                li      $v0, 11                                             # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
                syscall
                li      $a0, '\n'                                           # Carrega o caractere quebra de linha em $a0
                li      $v0, 11                                             # $v0 = 11 Argumento para imprimir caractere via syscall(MARS)
                syscall
                jr      $ra