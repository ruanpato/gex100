## Jogo campo minado assembly
## syscall http://courses.missouristate.edu/kenvollmar/mars/help/syscallhelp.html
## $s0 opcao (a == 5 || b == 7 || c == 9), $s7 == Matriz usuário, $s6 == Matriz sistema, $s5 contador auxiliar, $s4 contador auxiliar
.data
# Textos
wrd_linha_5:        .asciiz "\n   |---------|"
wrd_linha_7:        .asciiz "\n   |-------------|"
wrd_linha_9:        .asciiz "\n   |-----------------|"
wrd_teste:          .asciiz "\n     |----------|\n>1 |?|?|?|?|?|\n     |----------|\n  2 |?|?|?|?|?|\n     |----------|\n  3 |?|?|?|?|?|\n     |----------|\n  4 |?|?|?|?|?|\n     |----------|\n  5 |?|?|?|?|?|\n     |----------|\n"
wrd_selecOpc:       .asciiz "\nDigite qual o tamanho que deseja que a matriz tenha\na) 5x5\nb) 7x7\nc) 9x9\n-> "
wrd_selecPos:	    .asciiz "\nDigite a linha e coluna para selecionar a posição(separados por um espaço): "
wrd_perdeu:         .asciiz "\nVocê selecionou uma bomba e perdeu!\n"
wrd_confirma_opcao: .asciiz "\n(caso cancele o programa encerra) Você confirma que deseja jogar em um campo de:"
wrd_confirma_aux:   .asciiz "Linha selecionada\n"
barra_n:             .asciiz "\n"
barra:              .asciiz "|"
hifen:              .asciiz "-"
espaco:             .asciiz " "
# Matrizes
matriz_usuario:     .space   82                                                                             # Matriz de caracteres
matriz_jogo:        .space   328                                                                            # Matriz de inteiros
# Vetor
entrada:            .space   9

.text
main:
    # SELECIONA OPÇÃO
    # Imprime a string que pergunta qual a opção a ser selecionada
    li      $v0, 4                          # 4 syscall para imprimir string (li = load immediate)
    la      $a0, wrd_selecOpc               # $a0 = &wrd_selecOpc (la = load address)
    syscall                                 # Imprime $a0 (String)

    # Lê a opção selecionada pelo usuário
    li      $v0, 12                         # 12 syscall para ler caractere (li = load immediate)
    syscall                                 # Lê a opção

    add     $s0, $v0, $zero                 # Salva a opção escolhida em $s0, (leitura de caractere joga ele no $v0)
    # SELECIONA OPÇÃO
    
    
    add     $s5, $zero, $zero               # Inicia o contador auxiliar com zero(será usado para confirmar seleção
    jal		selec_tamanho_matriz     	    # jump to selec_tamanho_matriz and $ra = "this line"
    jal     preenche_matriz_usuario         # jump para Preenche Matriz usuário com (?)
    jal     imprime_matriz_usuario          # Imprime matriz usuário
    j       exit                            # Encerrar programa

exit:   li      $v0, 10                     # Exit
        syscall                             # syscall ExiBigt

selec_tamanho_matriz:
    addi    $sp, $sp, -4                    # Incrementa em uma posição o stack pointer
    sw      $ra, 0($sp)                     # Salva o $ra da chamada de selec_tamanho_matriz na main em $sp[0]
    jal     confirma_opcao                  # $ra = this_line


    confirma_opcao:
        # CAIXA DE DIALOGO
        la      $t0, wrd_confirma_aux
        la      $t1, wrd_confirma_opcao

        la      $a0, wrd_confirma_opcao     # Carrega a string de confirmar opção para o confirm dialog
        li      $v0, 50                     # 50 é o identificador de chamada do confirm box MARS
        syscall
        # CAIXA DE DIALOGO

        #  t1 = 1, t2 = 2
        li      $t1, 1                      # Carrega zero para comparar com $a0, que é a saida do confirm dialog
        li      $t2, 0                      # Carrega zero para comparar com $a0, que é a saida do confirm dialog
        beq     $a0, $zero, confirm_sim     # Se $a0 = 0 (opção selec foi sim) vai para confirmada_sim
        beq     $a0, $t1, confirm_nao       # Se $a0 = 1 (opção selec foi nao) vai para confirm_nao
        beq     $a0, $t2, confirm_cancel    # Se $a0 = 2 (opção selec foi cancelar) vai para confirm_cancel que encerra a execução do programa

        confirm_sim:
            lw      $ra, 0($sp)                     # Coloca o $ra para dps da chamada de confirma opcao em selec_tamanho_matriz
            jr      $ra                             # Volta para a função selec_tamanho_matriz mais exatamente após a função confirma_opcao 
        confirm_nao:
            # Recebe o novo valor
            li      $v0, 4                          # 4 syscall para imprimir string (li = load immediate)
            la      $a0, wrd_selecOpc               # $a0 = &wrd_selecOpc (la = load address)
            syscall                                 # Imprime $a0 (String)

            li      $v0, 12                         # 12 syscall para ler caractere (li = load immediate)
            syscall                                 # Lê a opção
            # Recebe o novo valor ##
            jr      $ra                             # Volta para confirmar a opção nova.
        confirm_cancel:
            j       exit                            # Encerra a execução do programa.

    li      $t0, 'a'                        # Carrega em $t0 'a' para comparar (load immediate)
    beq		$s0, $t0, opcA              	# se $s0 == 'a'($t0) então
    
    li      $t0, 'A'                        # Carrega em $t0 'A' para comparar (load immediate)
    beq     $s0, $t0, opcA                  # Se $s0 == 'A'($t0) então
    
    li      $t0, 'b'                        # Carrega em $t0 'b' para comparar (load immediate)
    beq     $s0, $t0, opcB                  # Se $s0 == 'b'($t0) então

    li      $t0, 'B'                        # Carrega em $t0 'B' para comparar (load immediate)
    beq     $s0, $t0, opcB                  # Se $s0 == 'B'($t0) então

    li      $t0, 'c'                        # Carrega em $t0 'c' para comparar (load immediate)
    beq     $s0, $t0, opcC                  # Se $s0 == 'c'($t0) então

    li      $t0, 'C'                        # Carrega em $t0 'C' para comparar (load immediate)
    beq     $s0, $t0, opcC                  # Se $s0 == 'C'($t0) então

    opcA:
        li      $s0, 5                      # Carrega em s0 o valor 5 (representando que a matriz é 5 por 5)
        jr		$ra    			            # Volta para main
        
    opcB:
        li      $s0, 7                      # Carrega em s0 o valor 7 (representando que a matriz é 7 por 7)
        jr		$ra    			            # Volta para main

    opcC:
        li      $s0, 9                      # Carrega em s0 o valor 7 (representando que a matriz é 9 por 9)
        jr	    $ra	    		            # Volta para main

preenche_matriz_usuario:
    mult    $s0, $s0                        # n*n (Tamanho da matriz)
    mflo    $t0                             # Atribui a $t0 o valor da multiplicação
    la      $s1, matriz_usuario             # Carrega o vetor matriz auxiliar em $s1
    li      $t1, 0                          # Inicia em zero o indice($t1)

    enquant_preenche_usuario:   slt $t2, $t1, $t0    # Se $t1 < $t0($t0, tamanho da matriz) então $t2 = 1
        beq     $t2, $zero, fim                      # Se for igual a zero volta pra main, caso contrário continua a preencher
        fim:
            jr      $ra                              # Retorno para main
        
        li      $v0, '?'                             # $v0 recebe '?'
        sw      $v0, 0($s1)                          # Insere na posição $s1 o valor ?

        lw      $a0, 0($s1)
        li      $v0, 11
        syscall
        la      $a0, barra_n
        li      $v0, 4
        syscall


        addi    $s1, $s1, 1                          # Incrementa a posição do vetor da matriz auxiliar
        addi    $t1, $t1, 1                          # Incrementa a variável de controle para saída do loop
        j   enquant_preenche_usuario                 # Retorna para o inicio loop (maybe sll)

imprime_matriz_usuario:
    la      $s7, matriz_usuario                 # $s7 é a matriz do usuário
    li      $s4, 0                              # Inicia o 'i'($s5) em 0
    mult    $s0, $s0                            # Multiplica nxn para ter o tamanho da matriz
    mflo    $s5                                 # $s5 == N

    addi    $sp, $sp, 4                         # Incrementa a pilha
    sw      $ra, 0($sp)                         # Coloca o endereço de retorno na pilha
    jal     imprime_linha_matriz                # Chama imprime_linha_matriz
    lw      $ra, 0($sp)                         # Carrega o endereço de retorno que está no topo da pilha

    sw      $ra, 0($sp)                         # Coloca o endereço de retorno na pilha
    addi    $sp, $sp, 4                         # Incrementa o topo da pilha para o loop salvar seu $ra
    jal     loop_imprime_usuario                # Chama loop_imprime_usuario
    addi    $sp, $sp, -4                        # Decrementa o loop para pegar o $ra da chamada de imprime_matriz_usuario
    lw      $ra, 0($sp)                         # Carrega o endereço de retorno que está no topo da pilha

    ## Loop para fazer a impressão da matriz
    loop_imprime_usuario:   slt     $t7, $s4, $s5       # i < N
        beq     $t7, $zero, fim_loop_imprime            # Se !(i < N) vai para fim_loop_imprime
        sw      $ra, 0($sp)                             # Salva o $ra no topo da pilha
        addi    $sp, $sp, 4                             # Incrementa o topo da pilha para o loop salvar seu $ra
        jal     nova_linha                              # Chama nova_linha e linka $ra
        addi    $sp, $sp, -4                            # Decrementa o loop para pegar o $ra da chamada de imprime_matriz_usuario
        lw      $ra, 0($sp)                             # Carrega o endereço do topo da pilha em $ra

        nova_linha:                                     # Deve sempre ser chamado com JAL
            # Imprime um \n um espaço número 
            li      $v0, 4                              # 4 para syscall de imprimir string
            la      $a0, barra_n                         # Carrega o endereço de barra_n em $a0
            syscall                                     # Imprime \n

            li      $v0, 4                              # 4 para syscall de imprimir string
            la      $a0, espaco                         # Carrega o endereço de espaco em $a0
            syscall                                     # Imprime espaço

            add     $a0, $t0, 1                         # Coloca o valor da linha a ser impressa incrementado
            li      $v0, 1                              # Chamada para imprimir Integer
            syscall                                     # Imprime o inteiro

            li      $v0, 4                              # 4 para syscall de imprimir string
            la      $a0, espaco                         # Carrega o endereço de espaco em $a0
            syscall                                     # Imprime espaço

            sw      $ra, 0($sp)                         # Salva o $ra no topo da pilha
            addi    $sp, $sp, 4                         # Incrementa o topo da pilha para o loop salvar seu $ra
            jal     loop_imprime_caracteres             # Chama a função para imprimir os caracteres
            addi    $sp, $sp, -4                        # Decrementa o loop para pegar o $ra da chamada de imprime_matriz_usuario
            lw      $ra, 0($sp)                         # Carrega o endereço do topo da pilha em $ra

            sw      $ra, 0($sp)                         # Coloca o endereço de retorno na pilha
            jal     imprime_linha_matriz                # Chama imprime_linha_matriz
            lw      $ra, 0($sp)                         # Carrega o endereço de retorno que está no topo da pilha

            loop_imprime_caracteres:
                sw      $ra, 0($sp)                     # Salva $ra no topo da pilha

                li      $v0, 4                          # Chamada para imprimir string
                la      $a0, barra                      # Carrega o endereço de barra em $a0
                syscall

                li      $v0, 1                          # Chamada para imprimir char
                lw      $a0, 0($s7)                     # $s7 é a matriz
                syscall
            jr      $ra                                 # Retorna para $ra(a linha que o chamou)
        fim_loop_imprime:
            jr      $ra                                 # Retorna para $ra(a linha que o chamou)
        

imprime_linha_matriz:
    li      $t5, 5      # Carrega 5 em $t5 para comparação
    li      $t7, 7      # Carrega 7 em $t7 para comparação
    li      $t9, 9      # Carrega 9 em $t9 para comparação

    beq     $s0, $t5, imprime_tamanho_5 # Compara se o n é igual a 5
    beq     $s0, $t7, imprime_tamanho_7 # Compara se o n é igual a 7
    beq     $s0, $t9, imprime_tamanho_9 # Compara se o n é igual a 9
    
    imprime_tamanho_5:
        li      $v0, 4              # Para imprimir string
        la      $a0, wrd_linha_5    # Carrega a wrd_linha_5
        syscall
        jr      $ra                 # Volta para onde imprime_linha_matriz foi chamada
    imprime_tamanho_7:
        li      $v0, 4              # Para imprimir string
        la      $a0, wrd_linha_7    # Carrega a wrd_linha_7
        syscall
        jr      $ra                 # Volta para onde imprime_linha_matriz foi chamada
    imprime_tamanho_9:
        li      $v0, 4              # Para imprimir string
        la      $a0, wrd_linha_9    # Carrega a wrd_linha_9
        syscall
        jr      $ra                 # Volta para onde imprime_linha_matriz foi chamada


som_bomba:              # Deve ser chamada com JAL
    li	    $a0, 127	# Pitch
    li	    $a1, 1000	# Millisconds
    li	    $a2, 127	# Instrument
    li	    $a3, 125	# Volume
    la	    $v0, 31		# Play MIDI
    syscall
    jr      $ra

som_acerto:             # Deve ser chamada com JAL
    li	    $a0, 60		# Pitch
    li	    $a1, 1000	# Millisconds
    li	    $a2, 98		# Instrument
    li	    $a3, 100	# Volume
    la	    $v0, 31		# Play MIDI
    syscall
    jr      $ra