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
    j       loop_calcula_bombas_linhas          # Pula para o loop calcula bombas linhas

    loop_calcula_bombas_linhas:
        beq     $t0, $s0, encerra_calculo                               # if (i == n) break 
        mult    $t0, $s0                                                # i*n
        mflo    $t3                                                     # $t3 = i*n
        j		loop_calcula_bombas_colunas		                        # jump to loop_calcula_bombas_colunas
        
        loop_calcula_bombas_colunas:
            beq     $t1, $s0, incrementa_loop_calcula_bombas_linhas     # if (j == n)

            addi    $t4, $t3, $t1                                       # (i*n)+j
            sll     $t4, $t4, 2                                         # ((i*n)+j)*4
            li      $s6, '0'                                            # Valor a ser inserido
            addi    $s3, $s7, $t4                                       # Endereço + Deslocamento
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

    # if(i >= 0 && j-1 >= 0)
    verifica_esquerda:
        addi    $t5, $t0, 0                         # i
        addi    $t6, $t1, -1                        # j-1
        slt     $t7, $t5, $zero                     # i < 0 ? 1 : 0
        beq     $t7, $zero, verifica_esquerda_1     # Se i >= 0
        jr      $ra                                 # Return;
        verifica_esquerda_1:
            slt     $t7, $t6, $zero                 # j-1 < 0 ? 1 : 0
            beq     $t7, $zero, verifica_nove       # Se i-1 >= 0
            jr      $ra                             # Return;

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
    verifica_diagonal_inferior_esquerda:
        addi    $t5, $t0, -1                    # i-1
        addi    $t6, $t1, -1                    # j-1
        slt     $t7, $t5, $zero                 # i-1 < 0 ? 1 : 0
        beq     $t7, $zero, verifica_diagonal_inferior_esquerda_1   # Se i-1 >= 0
        jr      $ra                             # Return;
        verifica_diagonal_inferior_esquerda_1:
            slt     $t7, $t6, $zero             # j-1 < 0 ? 1 : 0
            beq     $t7, $zero, verifica_nove   # Se j-1 >= 0
            jr      $ra                         # Return;
    
    # if(i+1 < n && j-1 >= 0)
    verifica_diagonal_superior_esquerda:
        addi    $t5, $t0, 1                     # i+1
        addi    $t6, $t1, -1                    # j-1
        slt     $t7, $t5, $s0                   # i+1 < n ? 1 : 0
        bne     $t7, $zero, verifica_diagonal_superior_esquerda_1   # Se i+1 < n
        jr      $ra                             # Return;
        verifica_diagonal_superior_esquerda_1:
            slt     $t7, $t6, $zero             # j-1 < 0 ? 1 : 0
            beq     $t7, $zero, verifica_nove   # Se j-1 >= 0
            jr      $ra                         # Return;

    # if(i-1 >= 0 && j+1 < n)
    verifica_diagonal_inferior_direita:
        addi    $t5, $t0, -1                    # i-1
        addi    $t6, $t1, 1                     # j+1
        slt     $t7, $t5, $zero                 # i-1 < 0 ? 1 : 0
        beq     $t7, $zero, verifica_diagonal_inferior_direita_1   # Se i-1 >= 0
        jr      $ra                             # Return;
        verifica_diagonal_inferior_direita_1:
            slt     $t7, $t6, $s0               # j+1 < n ? 1 : 0
            beq     $t7, $zero, verifica_nove   # Se j+1 < n
            jr      $ra                         # Return;

    # if(i+1 < n && j+1 < n)
    verifica_diagonal_superior_direita:
        addi    $t5, $t0, 1                     # i+1
        addi    $t6, $t1, 1                     # j+1
        slt     $t7, $t5, $zero                 # i+1 < n ? 1 : 0
        bne     $t7, $zero, verifica_diagonal_superior_direita_1   # Se j+1 < n
        jr      $ra                             # Return;
        verifica_diagonal_superior_direita_1:
            slt     $t7, $t6, $s0               # j+1 < n ? 1 : 0
            bne     $t7, $zero, verifica_nove   # Se j+1 < n
            jr      $ra                         # Return;

    verifica_nove:
        add     $t7, $t5, $t6                   # i*n+j
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