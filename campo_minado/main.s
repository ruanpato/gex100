# Cabeçalho de registradores salvos usados:
# $s0 = n
# $s1 = n*n
# $s2 = Quantidade de jogadas válidas
# $s3 = 
# $s4 = 
# $s5 = Contador de bombas
# $s6 = matriz_sistema
# $s7 = matriz_usuario
.data
    # Função professor
    semente:		.asciiz		"\nEntre com a semente da funcao Rand: "
    espaco:			.asciiz		" "
    nova_linha:		.asciiz		"\n"
    posicao:		.asciiz		"\nPosicao: "
    salva_S0:		.word		0
    salva_ra:		.word		0
    salva_ra1:		.word		0
    # Função professor
    # Mensagens
    msg_barra_5:            .asciiz "\n  |---------|"
    msg_barra_7:            .asciiz "\n  |-------------|"
    msg_barra_9:            .asciiz "\n  |-----------------|"
    msg_test:               .asciiz "\n----TESTE----\n"
    msg_test_fim_main:      .asciiz "\n----FIM_MAIN----\n"
    msg_seleciona_opc:      .asciiz "\nDigite qual o tamanho que deseja que a matriz tenha\na) 5x5\nb) 7x7\nc) 9x9\n-> "
    msg_jogar_novamente:    .asciiz "\nPara Jogar novamente digite 1 ou para encerrar a execução digite 0\n-> "
    msg_selec_linha:        .asciiz "\nDigite a linha (1 a n):\n-> "
    msg_selec_coluna:       .asciiz "\nDigite a coluna (1 a n):\n-> "
    msg_derrota:            .asciiz "\nVocê Perdeu !\nJogadas antes da bomba: "
    msg_opcao_nao_valida:   .asciiz "\nOpção inválida !\n"
    msg_vitoria:            .asciiz "\nParabéns, você venceu !\n"
    # Vetores(Matrizes)
    qtd_jogadas:            .word       0
    i_pos:                  .word       0
    j_pos:                  .word       0
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
        
        addi    $s2, $zero, 0                           # $s2 é quantidade de jogadas válidas
        jal     opcao_para_n                            # Vai para a 'função' e linka o retorno a esta linha

        la      $a0, matriz_sistema                     # $a0 = matriz_sistema
        add     $a1, $s0, $zero                         # $a1 = n
        jal     insere_bombas                           # Insere a bomba
        jal     calcula_bombas                          # Calcula bombas
        
        jal     menu_jogo                               # Menu jogo

        #jal     print_matriz_usuario
        #jal     print_matriz_sistema
        
        #j       seleciona_jogar_novamente              # Verifica se o usuário deseja jogar novamente    
        #la		$a0, msg_test_fim_main		            # Carrega o endereço do array .asciiz referente a mensagem de selecionar a opção
        #li		$v0, 4                                  # $v0 = 4 Argumento para imprimir array(string) via syscall(MARS)
        #syscall                                        # Imprime a mensagem da seleção da opção



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

menu_jogo:
    addi        $t0, $zero, 0                                               # i = 0
    sw          $t0, i_pos                                                  # i_pos = 0
    sw          $t0, j_pos                                                  # j_pos = 0
    addi        $s3, $zero, 0                                               # $s3 = 0
    sub         $s4, $s1, $s5                                               # $s4 = n*n-$s5
    li          $t9, '9'                                                    # 
    la          $s6, matriz_usuario                                         # 
    la          $s7, matriz_sistema                                         # 
    
    addi        $sp, $sp, 4                                                 # Incrementa o stack pointer
    sw          $ra, 0($sp)                                                 # Salva o endereço de retorno no stack pointer
    jal         loop_menu                                                   # Chama o loop_menu e linka a esta linha
    lw          $ra, 0($sp)                                                 # Pega o endereço que havia sido salvo no stack pointer e coloca em $ra
    addi        $sp, $sp, -4                                                # Decremente o stack pointer
    
    jr          $ra                                                         # volta ao $ra
    
    loop_menu:
        lw          $s3, qtd_jogadas                                        # Carrega a quantidade de jogadas e verifica se é igual a total de posições-bombas
        beq         $s3, $s4, fim_vitoria                                   # Se todas as jogadas válidas possíveis foram feitas

        addi        $sp, $sp, 4                                             # Incrementa o stack pointer
        sw          $ra, 0($sp)                                             # Salva o endereço de retorno no stack pointer
        jal         print_matriz_usuario                                    # Chama o loop_menu e linka a esta linha
        lw          $ra, 0($sp)                                             # Pega o endereço que havia sido salvo no stack pointer e coloca em $ra
        addi        $sp, $sp, -4                                            # Decremente o stack pointer
        lw          $s3, qtd_jogadas                                        # Carrega novamente, pois foi usado em print

        la      $a0, msg_selec_linha                                        # Carrega endereço de seleciona msg_selec_linha
        li      $v0, 4                                                      # Chamada para imprimir string
        syscall

        li      $v0, 5                                                      # Chamada para ler inteiro
        syscall

        addi    $t0, $v0, -1                                                # Carrega o valor lido em $t0

        la      $a0, msg_selec_coluna                                       # Carrega endereço de seleciona msg_selec_coluna
        li      $v0, 4                                                      # Chamada para imprimir string
        syscall

        li      $v0, 5                                                      # Chamada para ler inteiro
        syscall

        addi    $t1, $v0, -1                                                # Carrega o valor lido em $v1

        # i == $v0, j == $v1
        addi        $sp, $sp, 4                                             # Incrementa o stack pointer
        sw          $ra, 0($sp)                                             # Salva o endereço de retorno no stack pointer
        jal         verifica_jogada                                         # Chama o loop_menu e linka a esta linha
        lw          $ra, 0($sp)                                             # Pega o endereço que havia sido salvo no stack pointer e coloca em $ra
        addi        $sp, $sp, -4                                            # Decremente o stack pointer

        j       loop_menu                                                   # Retorna pro loop
        
    verifica_jogada:
        sw      $t0, i_pos                                                  # Salva i em i_pos
        sw      $t1, j_pos                                                  # Salva i em j_pos
        mult    $t0, $s0                                                    # i*n
        mflo    $t0                                                         # $v0 = i*n
        add     $t0, $t0, $t1                                               # $t0 = i*n+j
        sll     $t0, $t0, 2                                                 # $t0 = (i*n+j)*4

        la      $s6, matriz_sistema                                         #
        add     $t1, $s6, $t0                                               # Endereço + deslocamento (sistema)
        lw      $t3, 0($t1)                                                 # Load Word (sistema)

        la      $s6, matriz_usuario                                         #
        add     $t2, $s6, $t0                                               # Endereço + deslocamento (usuario)
        lw      $t4, 0($t2)                                                 # Load Word (usuario)

        beq     $t3, $t9, bomba_encerra_jogo                                # Bomba

        lw      $v0, i_pos                                                  # $v0 = i
        lw      $v1, j_pos                                                  # $v0 = j
        
        add     $a1, $zero, 0                                               # Zero erros de posição inválida

        slt     $a0, $s0, $v0                                               # if (n < i)
        add     $a1, $a1, $a0                                               # Incrementa em um caso n < j
        slt     $a0, $v0, $zero                                             # if (i < 0)
        add     $a1, $a1, $a0                                               # Incrementa em um caso n < i

        slt     $a0, $v1, $zero                                             # if (j < 0)
        add     $a1, $a1, $a0                                               # Incrementa em um caso n < j
        slt     $a0, $s0, $v1                                               # if (n < j)
        add     $a1, $a1, $a0                                               # Incrementa em um caso n < i

        bne     $a1, $zero, opcao_nao_valida                                # Caso tente acessar uma posição inválida

        beq     $t3, $t4, opcao_nao_valida                                  # Posição já jogada
        
        addi    $s3, $s3, 1                                                 # Incrementa jogadas válidas
        sw      $s3, qtd_jogadas                                            # Salva o valor incrementado

        sw      $t3, 0($t2)                                                 # Coloca o valor no tabuleiro (usuario)
        beq     $s3, $s4, fim_vitoria                                       # Se todas as jogadas válidas possíveis foram feitas
        jr      $ra                                                         # Volta pro loop

        bomba_encerra_jogo:
            sw      $t1, 0($t2)                                             # Coloca a bomba no tabuleiro

            addi    $s3, $zero, 0                                           # Coloca
            
            addi    $sp, $sp, 4                                             # Incrementa sp
            sw      $ra, 0($sp)                                             # Coloca o valor em sp
            jal     print_matriz_usuario
            lw      $ra, 0($sp)                                             # Pega o valor de sp
            addi    $sp, $sp, -4                                            # Decrementa sp

            addi    $sp, $sp, 4                                             # Incrementa sp
            sw      $ra, 0($sp)                                             # Coloca o valor em sp
            jal     print_matriz_sistema
            lw      $ra, 0($sp)                                             # Pega o valor de sp
            addi    $sp, $sp, -4                                            # Decrementa sp
            
            la      $a0, msg_derrota                                        # Carrega msg
            li      $v0, 4                                                  # Chamada pra imprimir string
            syscall
            
            lw      $a0, qtd_jogadas                                        # $a0 = qtd_jogadas
            li      $v0, 1                                                  # Chamada para imprimir int
            syscall

            li      $a0, '\n'                                               # 
            li      $v0, 11                                                 # Chamada para imprimir caractere
            syscall

            j       exit                                                    # Encerra execução

        opcao_nao_valida:
            la      $a0, msg_opcao_nao_valida                               #
            li      $v0, 4                                                  # Chamada string
            syscall
            j       loop_menu                                               # Volta pro loop

        fim_vitoria:
            la      $a0, msg_vitoria                                        # 
            li      $v0, 4                                                  # Chama string
            syscall
            j       exit

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
    li      $s6, '0'                            # Valor a ser inserido
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

            beq     $t9, $a0, bomba_encontrada                          # if(valor == '9')
            
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

    bomba_encontrada:
        addi    $s5, $s5, 1                                             # Contador de bombas incrementado
        j   incrementa_loop_calcula_bombas_colunas                      # Incrementa

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
        slt     $t7, $t5, $s0                   # i+1 < n ? 1 : 0
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


#########################
#     Insere Bomba      #
#########################			
#
#Le Numero de bombas (x)
#Le semente (a)
#while (bombas < x) 
#   sorteia linha
#   sorteia coluna
#   le posi��o pos = (L X tam + C) * 4
#   if(pos != 9)
#    	grava posicao pos = 9
#   bombas++  
#	
insere_bombas:
		la	$t0, salva_S0
		sw  $s0, 0($t0)		# salva conteudo de s0 na memoria
		la	$t0, salva_ra
		sw  $ra, 0($t0)		# salva conteudo de ra na memoria
		
		add $t0, $zero, $a0	# salva a0 em t0
		add $t1, $zero, $a1	# salva a1 em t1

		li	$v0, 1
		add $a0, $zero, $a1 #
		syscall		
		
		li	$v0, 4			# 
		la	$a0, nova_linha
		syscall			

verifica_menor_que_5:
		slti $t3, $t1, 5
		beq	 $t3, $0, verifica_maior_que_9
		addi $t1, $0, 5			#se tamanho do matriz_sistema menor que 5 atribui 5
		add  $a1, $0, $t1
verifica_maior_que_9:
		slti $t3, $t1, 9
		bne	 $t3, $0, testa_5
		addi $t1, $0, 9			
		add  $a1, $0, $t1
testa_5:
		addi $t3, $0, 5
		bne  $t1, $t3, testa_7
		addi $t2, $0, 10 # 10 bombas no matriz_sistema 5x5
		j	 pega_semente
testa_7:
		addi $t3, $0, 7
		bne  $t1, $t3, testa_9
		addi $t2, $0, 20 # 20 bombas no matriz_sistema 7x7
		j	 pega_semente
testa_9:
		addi $t3, $0, 9
		bne  $t1, $t3, else_qtd_bombas
		addi $t2, $0, 40 # 40 bombas no matriz_sistema 9x9
		j	 pega_semente
else_qtd_bombas:
		addi $t2, $0, 25 # seta para 25 bomas no else		
pega_semente:
		jal SEED
		add $t3, $zero, $zero # inicia contador de bombas com 0
INICIO_LACO:
		beq $t2, $t3, FIM_LACO
		
		add $a0, $zero, $t1 # carrega limite para %
		jal PSEUDO_RAND
		add $t4, $zero, $v0	# pega linha sorteada e coloca em t4
   		jal PSEUDO_RAND
		add $t5, $zero, $v0	# pega coluna sorteada e coloca em t5

################ imprime valores na tela (para debug somente)
	
#		li	$v0, 4			# mostra linha sorteada
#		la	$a0, posicao
#		syscall
#		li	$v0, 1
#		add $a0, $zero, $t4 #linha
#		syscall
#
#		add $a0, $zero, $t5 #coluna
#		syscall
#		
#		li	$v0, 4			# mostra coluna sorteada
#		la	$a0, espaco
#		syscall
#		li	$v0, 1		
#		add $a0, $zero, $t3 #linha
#		syscall
		
#######################	
	
		mult $t4, $t1
		mflo $t4
		add  $t4, $t4, $t5  # calcula (L * tam) + C
		add  $t4, $t4, $t4  # multtiplica por 2
		add  $t4, $t4, $t4  # multtiplica por 4
		add	 $t4, $t4, $t0	# calcula Base + deslocamento
		lw	$t5, 0($t4)		# Le posicao de memoria LxC

		
		#addi $t6, $zero, 9
        li   $t6, '9'
		beq  $t5, $t6, PULA_ATRIB
		sw   $t6, 0($t4)
		addi $t3, $t3, 1		
PULA_ATRIB:
		j	INICIO_LACO
FIM_LACO:


#		la   $a0, matriz_sistema
#		addi $a1, $zero, 7
#		jal MOSTRA_matriz_sistema	
		
		la	$t0, salva_S0
		lw  $s0, 0($t0)		# recupera conteudo de s0 da mem�ria
		la	$t0, salva_ra
		lw  $ra, 0($t0)		# recupera conteudo de ra da mem�ria		
		jr $ra
		



SEED:
	li	$v0, 4			# lendo semente da funcao rand
	la	$a0, semente
	syscall
	li	$v0, 5		#
	syscall
	add	$a0, $zero, $v0	# coloca semente de bombas em a0
	bne  $a0, $zero, DESVIA
	lui  $s0,  1		# carrega semente 100001
 	ori $s0, $s0, 34465	# 
	jr $ra	
DESVIA:
	add	$s0, $zero, $a0		# carrega semente passada em a0
	jr $ra
	


#
#fun��o que gera um n�mero randomico
#
 #int rand1(int lim) {
 # static long a = 100001; 
 #a = (a * 125) % 2796203; 
 #return ((a % lim) + 1); 
 #} // 
  
PSEUDO_RAND:
	addi $t6, $zero, 125  	# carrega 125
	lui  $t5,  42			# carrega fator: 2796203
	ori $t5, $t5, 43691 	#-
	
	mult  $s0, $t6			# a * 125
	mflo $s0				# a = (a * 125)
	div  $s0, $t5			# a % 2796203
	mfhi $s0				# a = (a % 2796203)
	div  $s0, $a0			# a % lim
	mfhi $v0                # v0 = a % lim
	jr $ra
	
### RAND PROFESSOR