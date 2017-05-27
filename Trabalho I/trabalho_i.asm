.text
.globl main

main:
	jal openFile
	j endProgram

openFile:
	# Open file for for reading purposes
	li $v0, 13          	# syscall 13 - open file
	la $a0, file_loc        # passing in file name
	li $a1, 0               # set to read mode
	li $a2, 0               # mode is ignored
	syscall
	bltz $v0, openError     # if $v0 is less than 0, there is an error found
	move $s0, $v0           # else save the file descriptor

	# Read input from file
	li $v0, 14          	# syscall 14 - read filea
	move $a0, $s0           # sets $a0 to file descriptor
	la $a1, buffer          # stores read info into buffer
	li $a2, 1024            # hardcoded size of buffer
	syscall
	bltz $v0, readError     # if error it will go to read error
	move $s4, $v0		# Movendo a quantidade de caracteres para $s4

	#Close the file 
	li   $v0, 16       # system call for close file
	move $a0, $s0      # file descriptor to close
	syscall            # close file
	
	# la      $s2, buffer
	# la	$s3, word_cmd
	li 	$t1, 0
	li 	$t2, 0
	j loopEachChar
	
printLines:
	li 	$v0, 4		# carrega a operação 4 (imprimir no console) para o syscall
	la 	$a0, buffer		# imprimir o que está no buffer
	syscall
	jr   $ra

printEachChar:
	li 	$v0, 11		# carrega a operação 4 (imprimir no console) para o syscall
	
	add     $t2, $t2, 1
	la      $t0, buffer($t2)   #loading value
	lb      $a0, ($t0)
	# beq 	$a0, 0x20, printEachChar
	syscall
	
	bnez     $a0, printEachChar
	jr $ra

loopEachChar:
	la      $t0, buffer($t2)   #loading value
	lb      $t3, ($t0)	  # Carrega o valor do ponteiro de $t0 para $t3
	beqz	$t3, endProgram
	# la      $t0, buffer($s2)   # Carrega o ponteiro do buffer de acordo com a posição do contador no buffer em $t0
	
	add     $t2, $t2, 1		  # Contador do buffer principal
	bne 	$t3, 0x20, addChar
	
	bnez	$t3, loopEachChar
	
	# li 	$v0, 11		# carrega a operação 4 (imprimir no console) para o syscall
	# syscall
	# jr   	$ra

addChar:
	la      $t6, word_cmd($t1) 
	sb 	$t3, ($t6)                # else store current character in the buffer  
	add 	$t1, $t1, 1               # same for finalStr pointer
	# add     $s3, $s3, 1
	# add     $s2, $s2, 1		  # Contador do buffer principal
	# lb      $t3, ($s3)	  	  # Carrega o valor do ponteiro de $t0 para $t3
	add     $t4, $t2, 1
	la      $t0, buffer($t4)   #loading value
	lb	$t5, ($t0)
	beq 	$t5, 0x20, printWord
	j loopEachChar

printWord:
	li 	$v0, 4			# carrega a operação 4 (imprimir no console) para o syscall
	la 	$a0, word_cmd		# imprimir o que está no buffer
	syscall
	
	li 	$t1, 0
	j clearWord

clearWord:
	la      $t6, word_cmd($t1)
	sb 	$zero, ($t6) 
	add 	$t1, $t1, 1
	la      $t6, word_cmd($t1)
	lb	$t7, ($t6)
	bnez	$t7, clearWord
	
	li 	$t4, 0
	li 	$t1, 0
	j loopEachChar


methodComp:
    	add 	$t0,$zero,$zero  
    	add 	$t1,$zero,$a0  
    	add 	$t2,$zero,$a1  

openError:
	la $a0, openErrorMsg
	li $v0, 4
	syscall
	
	j endProgram

readError:
	la $a0, readErrorMsg
	li $v0, 4
	syscall
	
	j endProgram

endProgram:
	li $v0, 10
	syscall

.data
	# note: when launching from commandline, test.asm should be within the same folder as Mars.jar
	file_loc: 	.asciiz 	"/home/marlon/Projetos/Ciência\ da\ Computação/Organização\ e\ Arquitetura de Computadores\ II/Trabalho\ I/prog01.asm" 
	buffer: 	.space 		1024 	# buffer of 1024
	new_line: 	.asciiz 	"\n"  	# where would I actually use this?
	word_cmd:	.space		256	# Espaço destinado para armazenar a palavra codigo

	# error strings
	readErrorMsg: 	.asciiz 	"\nError in reading file\n"
	openErrorMsg: 	.asciiz 	"\nError in opening file\n"
	
	instrucoes:	.asciiz		"addu"
