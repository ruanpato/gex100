calcula_bombas:
    addi    $t0, $zero, 0                       # Inicia i
    addi    $t1, $zero, 0                       # Inicia j
    addi    $t2, $zero, 0                       # Controla
    addi    $s3, $zero, 0                       # $s3 é o endereço+deslocamento
    addi    $s5, $zero, 0                       # Contador de bombas
    la      $s7, matriz_sistema                 # Endereço
    li      $t9, '9'                            # Valor a ser comparado
    j       loop_calcula_bombas_linhas          # Pula para calcula bombas

    # for i in range(n):
    loop_calcula_bombas_linhas:    
        beq     $t0, $s0, fim_loop_calcula_bombas       # if i == n break

        addi    $sp, $sp, 4                             # Incrementa o stackpointer
        sw      $ra, 0($sp)                             # Salva o endereço de retorno em $sp
        jal     loop_calcula_bombas_colunas             # Vai para colunas
        lw      $ra, 0($sp)                             # Carrega o endereço de retorno em $ra
        addi    $sp, $sp, -4                            # Decrementa o stackpointer
        
        j		loop_calcula_bombas_linhas				# jump to loop_calcula_bombas_linhas
        
        # for j in range(n):
        loop_calcula_bombas_colunas:    beq     $t1, $s0, incrementa_retorna_linhas
            mult	$t0, $s0			                    # $t0 * $s0 == i*n
            mflo	$t2					                    # copy Lo to $t2
            # $t2 = i*n
            add     $t2, $t2, $t1                           # $t2 = (i*n)+j
            sll     $t2, $t2, 2                             # $t2 = ((i*n)+j)*4
            add     $s3, $t2, $s7                           # Endereço+deslocamento
            lw      $t3, 0($s3)                             # Carrega o valor do vetor em um registrador temporario
            beq     $t3, $t9, eh_bomba                      # Verifica se o valor é 9
            
            addi    $sp, $sp, 4                             # Incrementa o stackpointer
            sw      $ra, 0($sp)                             # Salva o endereço de retorno em $sp
            jal     verificando_diagonal_inferior_esquerda  # 
            lw      $ra, 0($sp)                             # Carrega o endereço de retorno em $ra
            addi    $sp, $sp, -4                            # Decrementa o stackpointer

            addi    $sp, $sp, 4                             # Incrementa o stackpointer
            sw      $ra, 0($sp)                             # Salva o endereço de retorno em $sp
            jal     verificando_diagonal_superior_esquerda
            lw      $ra, 0($sp)                             # Carrega o endereço de retorno em $ra
            addi    $sp, $sp, -4                            # Decrementa o stackpointer
            
            addi    $sp, $sp, 4                             # Incrementa o stackpointer
            sw      $ra, 0($sp)                             # Salva o endereço de retorno em $sp
            jal     verificando_acima
            lw      $ra, 0($sp)                             # Carrega o endereço de retorno em $ra
            addi    $sp, $sp, -4                            # Decrementa o stackpointer
            
            addi    $sp, $sp, 4                             # Incrementa o stackpointer
            sw      $ra, 0($sp)                             # Salva o endereço de retorno em $sp
            jal     verificando_esquerda
            lw      $ra, 0($sp)                             # Carrega o endereço de retorno em $ra
            addi    $sp, $sp, -4                            # Decrementa o stackpointer

            addi    $sp, $sp, 4                             # Incrementa o stackpointer
            sw      $ra, 0($sp)                             # Salva o endereço de retorno em $sp
            jal     verificando_direita
            lw      $ra, 0($sp)                             # Carrega o endereço de retorno em $ra
            addi    $sp, $sp, -4                            # Decrementa o stackpointer

            addi    $sp, $sp, 4                             # Incrementa o stackpointer
            sw      $ra, 0($sp)                             # Salva o endereço de retorno em $sp
            jal     verificando_diagonal_inferior_direita
            lw      $ra, 0($sp)                             # Carrega o endereço de retorno em $ra
            addi    $sp, $sp, -4                            # Decrementa o stackpointer
            
            addi    $sp, $sp, 4                             # Incrementa o stackpointer
            sw      $ra, 0($sp)                             # Salva o endereço de retorno em $sp
            jal     verificando_diagonal_superior_direita
            lw      $ra, 0($sp)                             # Carrega o endereço de retorno em $ra
            addi    $sp, $sp, -4                            # Decrementa o stackpointer
            
            addi    $sp, $sp, 4                             # Incrementa o stackpointer
            sw      $ra, 0($sp)                             # Salva o endereço de retorno em $sp
            jal     verificando_abaixo
            lw      $ra, 0($sp)                             # Carrega o endereço de retorno em $ra
            addi    $sp, $sp, -4                            # Decrementa o stackpointer
            
            
            j       incrementa_retorna_colunas              # Volta pro loop

        # if (i-1 >= 0 && j-1 >= 0)
        verificando_diagonal_superior_esquerda:
            addi    $t5, $t0, -1                            # i-1
            addi    $t6, $t1, -1                            # j-1
            slt     $t7, $t5, $zero                         # $t7 recebe 1 se not (i-1 >= 0)
            beq     $t7, $zero, verificando_diagonal_superior_esquerda_1         # Se i-1 >= 0 vai para segunda etapa
            jr		$ra	                        			# jump to target
            verificando_diagonal_superior_esquerda_1:
                slt     $t7, $t6, $zero                     # $t7 recebe 1 se not (j-1 >= 0)
                beq     $t7, $zero, verifica_nove           # Se j-1 >= 0 vai para incrementa
                jr      $ra                                 # 

        # if (i-1 >= 0)
        verificando_acima:
            add     $t6, $t1, $zero                         # j
            addi    $t5, $t0, -1                            # i-1
            slt     $t7, $t5, $zero                         # $t7 recebe 1 se not (i-1 >= 0)
            beq     $t7, $zero, verifica_nove               # Se i-1 >= 0 vai para segunda etapa
            jr      $ra
        
        # if (i+1 <= n && j-1 >=0)
        verificando_diagonal_inferior_esquerda:
            addi    $t5, $t0, 1                             # i+1
            addi    $t6, $t1, -1                            # j-1
            slt     $t7, $t5, $s0                           # $t7 recebe 1 se not (i+1 >= n)
            beq     $t7, $zero, verificando_diagonal_inferior_esquerda_1         # Se i+1 >= n vai para segunda etapa
            jr      $ra
            verificando_diagonal_inferior_esquerda_1:
                slt     $t7, $t6, $zero                     # 1 if j-1 < 0
                bne     $t7, $zero, verifica_nove           # if j-1 >= 0
                jr      $ra

        
        
        # if (i >= 0 && j-1 > 0)
        verificando_esquerda:
            addi    $t5, $t0, 0                             # i
            addi    $t6, $t1, -1                            # j-1
            slt     $t7, $t5, $zero                         # 1 if i < 0 else 0(if i >= 0)
            beq     $t7, $zero, verificando_esquerda_1
            jr      $ra
            verificando_esquerda_1:
                slt     $t7, $zero, $t6                     # 1 if j-1 < 0 else 0(if j >= 0)
                bne     $t7, $zero, verifica_nove
                jr      $ra

        # if (i >= 0 && j+1 < n)
        verificando_direita:
            addi    $t5, $t0, 0                             # i
            addi    $t6, $t1, 1                             # j+1
            slt     $t7, $t5, $zero                         # 1 if i < 0 else 0(if i >= 0)
            beq     $t7, $zero, verificando_esquerda_1
            jr      $ra
            verificando_direita_1:
                slt     $t7, $t6, $s0                         # 1 if j+1 < n else 0(if j >= 0)
                bne     $t7, $zero, verifica_nove
                jr      $ra

        # if (i+1 < n && j+1 < n)
        verificando_diagonal_inferior_direita:
            addi    $t5, $t0, 1                             # i+1
            addi    $t6, $t1, 1                             # j+1
            slt     $t7, $t5, $s0                           # if( (i+1) < n)
            bne     $t7, $zero, verificando_diagonal_inferior_direita_1
            jr      $ra
            verificando_diagonal_inferior_direita_1:
                slt     $t7, $t6, $s0                           # if( (j+1) < n)
                bne     $t7, $zero, verifica_nove
                jr      $ra

        # if (i-1 >= 0 && j+1 < n)
        verificando_diagonal_superior_direita:
            addi    $t5, $t0, -1                                            # i-1
            addi    $t6, $t1, 1                                             # j+1
            slt     $t7, $t5, $zero                                         # if( (i-1) < 0)
            beq     $t7, $zero, verificando_diagonal_superior_direita_1     # if (i-1 >= 0)
            jr      $ra
            verificando_diagonal_superior_direita_1:
                slt     $t7, $t6, $s0                           # if( (j+1) < n)
                bne     $t7, $zero, verifica_nove
                jr      $ra
        
        # if (i+1)
        verificando_abaixo:
            add     $t6, $t1, $zero                         # j
            addi    $t5, $t0, 1                             # i+1
            slt     $t7, $t5, $s0                           # $t7 recebe 1 se (i+1 < n)
            bne     $t7, $zero, verifica_nove               # Se i+1 < n vai para verifica nove
            jr      $ra

        verifica_nove:                              # i = $t5, j = $t6
            mult    $t5, $s0                        # i*n
            mflo    $a0                             # $t5 = i*n
            add     $a1, $a0, $t6                   # $t5 = i*n+j
            
            sll     $t7, $a1, 2                     # $t7 = shift logical left in 2 ($t7 = $t5*4)
            add     $t8, $t7, $s7                   # $t5 = Endereço + deslocamento
            lw      $a1, 0($t8)                     # $t6 = valor(endereço+deslocamento)

            li      $a0, '9'                        # To compare
            beq     $a1, $a0, incrementa_1_valor    # se pos == 9
            jr      $ra

        incrementa_1_valor:
            add     $t8, $t0, $s0                   # $t8 = i*n
            add     $t8, $t0, $t1                   # $t8 = i*n+j
            sll     $t8, $t8, 2                     # $t8 = (i*n+j)*4
            add     $t8, $s7, $t8                   # $t8 = endereço+deslocamento

            li      $a0, '0'
            beq     $s4, $a0, incrementa_para_1
            li      $a0, '1'
            beq     $s4, $a0, incrementa_para_2
            li      $a0, '2'
            beq     $s4, $a0, incrementa_para_3
            li      $a0, '3'
            beq     $s4, $a0, incrementa_para_4
            li      $a0, '4'
            beq     $s4, $a0, incrementa_para_5
            li      $a0, '5'
            beq     $s4, $a0, incrementa_para_6
            li      $a0, '6'
            beq     $s4, $a0, incrementa_para_7
            li      $a0, '7'
            beq     $s4, $a0, incrementa_para_8
            incrementa_para_1:
                li      $s4, '1'
                sw      $s4, 0($t8)
                jr      $ra
            incrementa_para_2:
                li      $s4, '2'
                sw      $s4, 0($t8)
                jr      $ra
            incrementa_para_3:
                li      $s4, '3'
                sw      $s4, 0($t8)
                jr      $ra
            incrementa_para_4:
                li      $s4, '4'
                sw      $s4, 0($t8)
                jr      $ra
            incrementa_para_5:
                li      $s4, '5'
                sw      $s4, 0($t8)
                jr      $ra
            incrementa_para_6:
                li      $s4, '6'
                sw      $s4, 0($t8)
                jr      $ra
            incrementa_para_7:
                li      $s4, '7'
                sw      $s4, 0($t8)
                jr      $ra
            incrementa_para_8:
                li      $s4, '8'
                sw      $s4, 0($t8)
                jr      $ra

        incrementa_retorna_colunas:
            addi    $t1, $t1, 1                             # Incrementa j
            j       loop_calcula_bombas_colunas

        eh_bomba:
            addi    $s5, $s5, 1                             # Aumenta quantidade de bombas
            j       incrementa_retorna_colunas

        incrementa_retorna_linhas:
            addi    $t1, $zero, 0                           # Reseta o j para 0
            addi    $t0, $t0, 1                             # Incrementa a variável de controle (i)
            jr      $ra

    fim_loop_calcula_bombas:
        jr      $ra 