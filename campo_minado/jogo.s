## Jogo campo minado assembly
## syscall http://courses.missouristate.edu/kenvollmar/mars/help/syscallhelp.html
## $s0 opcao
.data
# Textos
wrd_selecOpc:   .asciiz "\nDigite qual o tamanho que deseja que a matriz tenha\na) 5x5\nb) 7x7\nc) 9x9\n-> "
wrd_selecPos:	.asciiz "\nDigite a linha e coluna para selecionar a posição(separados por um espaço): "
wrd_perdeu:     .asciiz "\nVocê selecionou uma bomba e perdeu!\n"
barraN:         .asciiz "\n"
barra:          .asciiz "|"
hifen:          .asciiz "-"
espaco:         .asciiz " "
# Matrizes
matriz_aux:     .word   82                                                                                 # Matriz de caracteres
matriz_jogo:    .word   328                                                                                # Matriz de inteiros

.text
main:

    li      $v0, 4                          # 4 syscall para imprimir string (li = load immediate)
    la      $a0, wrd_selecOpc               # $a0 = &wrd_selecOpc (la = load address)
    syscall                                 # Imprime $a0 (String)

    li      $v0, 12                         # 12 syscall para ler caractere (li = load immediate)
    syscall                                 # Lê a opção

    add     $s0, $v0, $zero                 # Salva a opção escolhida em $s0, (leitura de caractere joga ele no $v0)
    
    jal		selec_opcao     				# jump to selec_opcao and $ra = "this line"
    jal     preenche_matriz_aux             # jump para Preenche Matriz usuário com (?)
    jal     imprime_matriz_aux              # Imprime matriz usuário
    j exit                                  # Encerrar programa

exit:   li      $v0, 10                         # Exit
        syscall                                 # syscall Exit

selec_opcao:
    # Maybe a dialog to confirm option                 

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
        li      $s0, 7                      # Carrega em s0 o valor 7 (representando que a matriz é 7 por 7)
        jr	    $ra	    		            # Volta para main

preenche_matriz_aux:
    mult    $s0, $s0                        # n*n (Tamanho da matriz)
    mflo    $t0                             # Atribui a $t0 o valor da multiplicação
    la      $t7, matriz_aux                 # Carrega o vetor matriz auxiliar em $t7
    li      $t1, 0                          # Inicia em zero o indice($t1)

    enquanto_preenche_aux:   slt $t2, $t1, $t0       # Se $t1 < $t0($t0, tamanho da matriz) então $t2 = 1
        beq     $t2, $zero, fim                      # Se for igual a zero volta pra main, caso contrário continua a preencher
        fim:
            jr      $ra                              # Retorno para main
        
        li      $v0, '?'                             # $v0 recebe '?'
        sw      $v0, 0($t7)                          # Insere na posição $t7 o valor ?

        addi    $t7, $t7, 1                          # Incrementa a posição do vetor
        addi    $t1, $t1, 1                          # Incrementa a variável de controle para saída do loop
        j   enquanto_preenche_aux                    # Retorna para o inicio loop

imprime_matriz_aux:
    la      $s7, matriz_aux                 # $s7 é a matriz inicial
    mult    $s0, $s0                        # n*n (Tamanho da matriz)
    mflo    $t0                             # $t0 recebe n*n

    li      $v0, 4                          # 4 para syscall de imprimir string
    la      $a0, barraN                     # Carrega o endereço de barraN em $a0
    syscall                                 # Imprime \n
    li      $v0, 4                          # 4 para syscall de imprimir string
    la      $a0, espaco                     # Carrega o endereço de espaco em $a0
    syscall                                 # Imprime espaço
    syscall                                 # Imprime espaço
    
    li      $t1, 1                          # Inicia o 'i'($t1) em 1

    imp_1_loop: slt $t7, $t1, $t0           # $t7 = ($t1 < $t0 ? 1 : 0)
        li      $v0, 4                      # 4 para syscall de imprimir string
        la      $a0, barraN                 # Carrega o endereço de barraN em $a0
        syscall                             # Imprime \n
        li      $v0, 1                      # 1 para syscall de imprimir inteiro
        add     $a0, $zero, $t1             # $a0 recebe i($t1)
        syscall                             # Imprime o i