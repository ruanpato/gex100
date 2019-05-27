#for(x = 0; x < 10; x++)
#    A[x] = B[x] + x;

    .data
    vector_A: .space 40
    #vector_B: .space 40
    vector_B: .word 31, 5, -2, 5, -10, 11, 30, 7, 0, -6
      
    .text
    
    main:
      la $s0, vector_A         # s0 armazena endereço de A[0]
      la $s1, vector_B         # s1 armazena endereço de B[0]
      add $s2, $zero, $zero    # s2 armazena endereço de x
    teste: slti $t0, $s2, 10      # Testa condição de laço
     beq $t0, $zero, fim
      # Prepara o acesso a B[x]
      sll $t1, $s2, 2        # Multplica x por 4
      # add $t1, $s2, $s2    # Multplica x por 2
      # add $t1, $t1, $t1    # Multplica x por 4
      add $t3, $s1, $t1      # Calcula posição de B[x]
      # Acessa B[x]
      lw $t2,0($t3)          # Lê B[x]
      # Soma
      add $t2, $t2, $s2      # faz B[x]+x
    
      # Prepara o acesso a A[x]
      # sll $t1, $s2, 2      # Multiplica x por 4
      # add $t1, $s2, $s2    # Multiplica x por 2
      # add $t1, $s1, $t1    # Multiplica x por 4
      add $t3, $s0, $t1      # Calcula a posição de A[x]
    
      # Escreve em A[x]
      sw $t2, 0($t3)         # Escreve em A[x]
      # Atualiza variável de controle do laço
      addi $s2, $s2, 1       # x = x + 1
      j teste                # Volta para a linha "teste"
     fim: