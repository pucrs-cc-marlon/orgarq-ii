# MARS example: Manipulating arrays
# Author:  
# Function: implementa uma funcao que soma dois vetores em um terceiro e retorna o resultado da 
# soma dos elementos dos vetores. Os enderecos dos vetores e da variavel size sao passados como parametros
# atraves dos registradores $a0 a $a3 e o resultado do somatorio eh retornado atraves do registrador $v0

        
        .text                   # Add what follows to the text segment of the program
        .globl  main            # Declare the label main to be a global one
main:
        	la      $a0,V1          # register $t0 contains the address of array V1
        	la	$a1,V2		# register $t1 contains the address of array V2
        	la      $a2,V3          # register $t2 contains the address of array V3
        	la 	$a3,size	# get address of size
        	addiu	$sp, $sp, -4
        	sw	$ra, 0($sp)
        	jal	soma_vet	# chama a subrotina que ira somar os vetores e acumular a soma dos elementos dos vetores
        	addu	$s0, $v0, $zero	# armazena o resultado que a funcao retornou em $s0
        	lw	$ra, 0($sp)
        	jr $ra
        	
soma_vet:	lw      $a3,0($a3)      # register $t1 contains the size of the array
	loop:   blez    $a3,end         # if size is/becomes 0, end of processing
	        lw      $t4,0($a0)      # get array element (V1)
	        lw	$t5,0($a1)	# get array element (V2)
	        addu    $t4,$t4,$t5     # add V1+V2
	        addu	$v0, $v0, $t4	# acumula a soma dos elemntos dos vetores e retorna para o pgm principal
	        sw      $t4,0($a2)      # store the result in V3
	        addiu   $a0,$a0,4       # update array pointer (V1). Remember, 1word=4 memory addresses
	        addiu   $a1,$a1,4       # update array pointer (V2). 
	        addiu   $a2,$a2,4       # update array pointer (V3). 
	        addiu   $a3,$a3,-1      # decrement array size counter
	        j       loop            # continue execution
        
	end:    jr	$ra       

        .data                   # add what follows to the data segment of the program
V1:     .word   0x12 0xff 0x3 0x14 0x878 0x31  0x62 0x10 0x5 0x16 0x20
V2:     .word   0x12 0xff 0x3 0x14 0x878 0x31  0x62 0x10 0x5 0x16 0x20
V3:     .word   0x0  0x0  0x0 0X0  0x0   0x0   0x0  0X0  0x0  0x0  0x0 
                                # Loads the list of ints into successive locations in memory
                                # beginning with location A (i.e. we've initialized an array)
size:   .word   11              # size of the array
