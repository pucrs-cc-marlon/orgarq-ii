.text
.globl main

main:
	li 	$v0, 13
	la	$a0, filename
	li	$a1, 0
	li	$a2, 0
	syscall
	
	move 	$s6, $v0
	
	#read from file
	li   	$v0, 14       # system call for read from file
	move 	$a0, $s6      # file descriptor 
	la   	$a1, buffer   # address of buffer to which to read
	li   	$a2, 11     # hardcoded buffer length
	syscall            # read from file

	# Close the file 
	li   	$v0, 16       # system call for close file
	move 	$a0, $s6      # file descriptor to close
	syscall            # close file
	
	
	
.data

filename: 	.asciiz 	"/home/marlon/Projetos/Ciência\ da\ Computação/Organização\ e\ Arquitetura de Computadores\ II/Experimentos/read_test.txt"
buffer: 	.space		128
buffer1: 	.asciiz 	"\n"
newline: 	.asciiz 	"\n"
