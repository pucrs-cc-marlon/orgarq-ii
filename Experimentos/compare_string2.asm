.data  
string: .space 20  

write:.asciiz "write the string to compare:"  
match:.asciiz "\nthey match"
nonmatch:.asciiz "\nthey dont match"  
strToCompare: .asciiz "false\n"

.text
.globl main

main:  
    li $v0,4        #loads msg1  
    la $a0,write  
    syscall

    li $v0,8
    la $a0,string
    addi $a1,$zero,20
    syscall          #got string to manipulate

    li $v0,8
    la $a0,match
    addi $a1,$zero,20

    la $a0,string             #pass address of str1  
    la $a1,strToCompare         #pass address of str2  
    jal methodComp      #call methodComp  

    beq $v0,$zero,ok    #check result  
    li $v0,4
    la $a0,nonmatch
    syscall
    j exit
ok:  
    li $v0,4  
    la $a0,match  
    syscall  
exit:  
    li $v0,10  
    syscall  

methodComp:  
    add $t0,$zero,$zero  
    add $t1,$zero,$a0  
    add $t2,$zero,$a1  

loop:  
    lb $t3($t1)         #load a byte from each string  
    lb $t4($t2)  
    beqz $t3,checkt2    #str1 end  
    beqz $t4,missmatch  
    slt $t5,$t3,$t4     #compare two bytes  
    bnez $t5,missmatch  
    addi $t1,$t1,1      #t1 points to the next byte of str1  
    addi $t2,$t2,1  
    j loop  

missmatch:   
    addi $v0,$zero,1  
    j endfunction  
checkt2:  
    bnez $t4,missmatch  
    add $v0,$zero,$zero  

endfunction:  
    jr $ra