.text
.globl main

main:
	li 	$v0, 5
	syscall

	move 	$t0, $v0
	
	li 	$v0, 5
	syscall

	move 	$t1, $v0

	addu 	$t2, $t0, $t1

	la	$a0, TEXT1
	li 	$v0, 4
	syscall

	move	$a0, $t0
	li	$v0, 1
	syscall

	la	$a0, TEXT2
	li	$v0, 4
	syscall

	move	$a0, $t1
	li	$v0, 1
	syscall

	la	$a0, TEXT3
	li	$v0, 4
	syscall

	move	$a0, $t2
	li	$v0, 1
	syscall

	li	$v0, 10
	syscall

	

.data

TEXT1:		.asciiz		"A soma de "
TEXT2:		.asciiz		" mais "
TEXT3:		.asciiz		" e igual a "
