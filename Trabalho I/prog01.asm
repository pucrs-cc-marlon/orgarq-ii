 .text
 .globl  main            

 main:  la $t0,A 
  lw $t0,0($t0)
  la $t1,B  
  lw $t1,0($t1) 
  addu $t0,$t0,$t1 
  la $t2,C  
  sw $t0,0($t2) 
  
  
  
  jr $ra
  
  
  .data
 A: .word 32
 B: .word 0x05
 C: .word 0

