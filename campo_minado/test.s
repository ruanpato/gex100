# Cabeçalho de registradores salvos usados:
# $s0 = n
# $s1 = n*n
# $s6 = matriz_jogo
# $s7 = matriz_usuario
.data
    # Mensagens
    msg_barra_5:            .asciiz "\n  |---------|"
    msg_barra_7:            .asciiz "\n  |-------------|"
    msg_barra_9:            .asciiz "\n  |-----------------|"
    msg_vetor_0:            .asciiz "\nVetor 0: "
    msg_vetor_1:            .asciiz "\nVetor 1: "
    msg_test:               .asciiz "\n----TESTE----\n"
    msg_test_fim_main:      .asciiz "\n----FIM_MAIN----\n"
    msg_seleciona_opc:      .asciiz "\nDigite qual o tamanho que deseja que a matriz tenha\na) 5x5\nb) 7x7\nc) 9x9\n-> "
    msg_jogar_novamente:    .asciiz "\nPara Jogar novamente digite 1 ou para encerrar a execução digite 0\n-> "
    # Vetores(Matrizes)
    vetor_0:                .word 324              # Matriz que o usuário verá
    vetor_1:                .word 324              # Matriz respectiva ao funcionamento do jogo
.text

main:
    li      $s0, '#' 
    li      $s1, 84

    jal     preenche_vetor_0
    jal     preenche_vetor_1
    jal     le_vetor_0
    jal     le_vetor_1

    li      $v0, 10                             # $v0 = 10 Argumento para encerrar a execução via syscall(MARS)
    syscall  

le_vetor_0: # $a0 == max
    addi    $t0, $zero, 0       # Control register
    addi    $t1, $zero, 0       # Iterator vetor_0
    la      $t2, vetor_0        # $t2 addres of vetor_0
    la      $a0, msg_vetor_0
    li      $v0, 4
    syscall
    j       loop_le_vetor_0

    loop_le_vetor_0:
        beq     $t0, $s1, fim_loop_le_vetor_0

        addi    $t0, $t0, 1
        sll     $t1, $t0, 2
        add     $t3, $t1, $t2
        
        lw      $a0, 0($t3)
        li      $v0, 11
        syscall
        li      $a0, ' '
        li      $v0, 11
        syscall

        j   loop_le_vetor_0

    fim_loop_le_vetor_0:
        li      $a0, '\n'
        li      $v0, 11
        syscall
        jr      $ra

preenche_vetor_0: # $s1 == max
    addi    $t0, $zero, 0       # Control register
    addi    $t1, $zero, 0       # Iterator vetor_0
    la      $t2, vetor_0        # $t2 addres of vetor_0

    j       loop_preenche_vetor_0

    loop_preenche_vetor_0:
        beq     $t0, $s1, fim_loop_preenche_vetor_0

        addi    $t0, $t0, 1
        sll     $t1, $t0, 2
        add     $t3, $t1, $t2
        
        sw      $s0, 0($t3)

        j   loop_preenche_vetor_0

    fim_loop_preenche_vetor_0:
        jr      $ra

le_vetor_1: # $a0 == max
    addi    $t0, $zero, 0       # Control register
    addi    $t1, $zero, 0       # Iterator vetor_1
    la      $t2, vetor_1        # $t2 addres of vetor_1
    la      $a0, msg_vetor_1
    li      $v0, 4
    syscall
    j       loop_le_vetor_1

    loop_le_vetor_1:
        beq     $t0, $s1, fim_loop_le_vetor_1

        addi    $t0, $t0, 1
        sll     $t1, $t0, 2
        add     $t3, $t1, $t2
        
        lw      $a0, 0($t3)
        li      $v0, 11
        syscall
        li      $a0, ' '
        li      $v0, 11
        syscall

        j   loop_le_vetor_1

    fim_loop_le_vetor_1:
        li      $a0, '\n'
        li      $v0, 11
        syscall
        jr      $ra

preenche_vetor_1: # $a0 == max
    addi    $t0, $zero, 0       # Control register
    addi    $t1, $zero, 0       # Iterator vetor_1
    la      $t2, vetor_1        # $t2 addres of vetor_1

    j       loop_preenche_vetor_1

    loop_preenche_vetor_1:
        beq     $t0, $s1, fim_loop_preenche_vetor_1

        addi    $t0, $t0, 1
        sll     $t1, $t0, 2
        add     $t3, $t1, $t2
        
        sw      $s0, 0($t3)

        j   loop_preenche_vetor_1

    fim_loop_preenche_vetor_1:
        jr      $ra