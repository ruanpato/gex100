.data
wrd_fim:            .asciiz "\n\n\n\nIsso é o fim\n"
wrd_barra_n:        .asciiz "\n"
wrd_confirma_opcao: .asciiz "\n(caso cancele o programa encerra) Você confirma que deseja jogar em um campo de:"
.text
main:
    addi    $sp, $sp, -4                    # Aloca dois espaços para a pilha
    sw      $ra, 4($sp)                     # Salva o endereço de retorno para a main em 4($sp)
    addi    $s7, $zero, 0                   # Iterações

    la      $t1, wrd_confirma_opcao

    jal     loop


    li      $v0, 4                          # 4 syscall para imprimir string (li = load immediate)
    la      $a0, wrd_fim                  # $a0 = &wrd_seleo fim = load address)
    syscall                                 # Imprime $a0 (String)

exit:   li      $v0, 10                     # Exit
        syscall                             # syscall ExiBigt

loop:
    addi    $s7, $s7, 1                   # aumenta o contador em 1
    li      $v0, 1                        # Syscall para imprimir inteiro
    add     $a0, $s7, $zero               # Coloca em $a0 (Que é o que será impresso) o valor do contador
    syscall
    li      $v0, 4                        # 4 syscall para imprimir string (li = load immediate)
    la      $a0, wrd_barra_n              # $a0 = &wrd_seleo fim = load address)
    syscall                               # Imprime $a0 (String)

    la      $a0, wrd_confirma_opcao       # Carrega a string de confirmar opção para o confirm dialog
    li      $v0, 50                       # 50 é o identificador de confirm box MARS
    syscall


    addi    $t1, $zero, 1                # T1 = 1
    addi    $t2, $zero, 2                # T2 = 2
    beq     $a0, $zero, sim              # Se for sim
    beq     $a0, $t1, nao                # Se for não
    beq     $a0, $t2, cancelar           # Se for cancelar

    sim:
        jr      $ra
    nao:
        j       loop
    cancelar:
        j       exit