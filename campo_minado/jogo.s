## Jogo campo minado assembly
## syscall http://courses.missouristate.edu/kenvollmar/mars/help/syscallhelp.html
## $s0 opcao (a == 5 || b == 7 || c == 9), $s7 == Matriz usuário, $s6 == Matriz sistema, $s5 contador auxiliar
.data
# Textos
wrd_linha5:         .asciiz "   |----------|\n"
wrd_teste:          .asciiz "\n     |----------|\n>1 |?|?|?|?|?|\n     |----------|\n  2 |?|?|?|?|?|\n     |----------|\n  3 |?|?|?|?|?|\n     |----------|\n  4 |?|?|?|?|?|\n     |----------|\n  5 |?|?|?|?|?|\n     |----------|\n"
wrd_selecOpc:       .asciiz "\nDigite qual o tamanho que deseja que a matriz tenha\na) 5x5\nb) 7x7\nc) 9x9\n-> "
wrd_selecPos:	    .asciiz "\nDigite a linha e coluna para selecionar a posição(separados por um espaço): "
wrd_perdeu:         .asciiz "\nVocê selecionou uma bomba e perdeu!\n"
wrd_confirma_opcao: .asciiz "\n(caso cancele o programa encerra) Você confirma que deseja jogar em um campo de:"
wrd_confirma_aux:   .asciiz "Linha selecionada\n"
barraN:             .asciiz "\n"
barra:              .asciiz "|"
hifen:              .asciiz "-"
espaco:             .asciiz " "
# Matrizes
matriz_usuario:     .word   82                                                                             # Matriz de caracteres
matriz_jogo:        .word   328                                                                            # Matriz de inteiros
# Vetor
entrada:            .space   9

.text
main:
    ## Just a tst ##
    #li      $v0, 51
    #la      $a0, wrd_teste
    #li      $a1, 4
    #syscall
    #addi    $t0, $a0, 0
    #li      $v0, 56
    #la      $a0, wrd_confirma_aux
    #add     $a1, $zero, $t0
    #syscall
    ## Just a tst ##

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
        #li      $v0, 4                          # 4 syscall para imprimir string (li = load immediate)
        #la      $a0, wrd_teste                  # $a0 = &wrd_selecOpc (la = load address)
        #syscall                                 # Imprime $a0 (String)

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
    la      $t7, matriz_usuario             # Carrega o vetor matriz auxiliar em $t7
    li      $t1, 0                          # Inicia em zero o indice($t1)

    enquant_preenche_usuario:   slt $t2, $t1, $t0    # Se $t1 < $t0($t0, tamanho da matriz) então $t2 = 1
        beq     $t2, $zero, fim                      # Se for igual a zero volta pra main, caso contrário continua a preencher
        fim:
            jr      $ra                              # Retorno para main
        
        li      $v0, '?'                             # $v0 recebe '?'
        sw      $v0, 0($t7)                          # Insere na posição $t7 o valor ?

        addi    $t7, $t7, 1                          # Incrementa a posição do vetor
        addi    $t1, $t1, 1                          # Incrementa a variável de controle para saída do loop
        j   enquant_preenche_usuario                 # Retorna para o inicio loop

imprime_matriz_usuario:
    la      $s7, matriz_usuario                 # $s7 é a matriz do usuário
    
    li      $t0, 0                              # Inicia o 'i'($t1) em 0
    li      $t1, 2                              # Carrega 2 em li
    ## Loop para fazer a impressão da matriz
    loop_imprime:   slt $t
        li      $v0, 4                          # 4 para syscall de imprimir string
        la      $a0, espaco                     # Carrega o endereço de espaco em $a0
        syscall                                 # Imprime espaço
        syscall                                 # Imprime espaço
        li      $v0, 4                          # 4 para syscall de imprimir string
        la      $a0, barra                      # Carrega o endereço de barra em $a0
        syscall                                 # Imprime barra '|'
        
        j		exit	            			# jump to exit

    nova_linha:                                     # Deve sempre ser chamado com JAL
        # Imprime um \n e dá dois espaços para uma nova linha
        li      $v0, 4                              # 4 para syscall de imprimir string
        la      $a0, barraN                         # Carrega o endereço de barraN em $a0
        syscall                                     # Imprime \n
        li      $v0, 4                              # 4 para syscall de imprimir string
        la      $a0, espaco                         # Carrega o endereço de espaco em $a0
        syscall                                     # Imprime espaço
        syscall                                     # Imprime espaço
        jr      $ra                                 # Retorna para $ra(a linha que o chamou)