.text   
.globl  main
 main:
 	li 	$v0, 5
	syscall
	
	move	$t2, $v0 
	
	li	$v0, 10
	syscall
	
.data