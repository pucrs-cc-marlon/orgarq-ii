# MARS example: Manipulating arrays
# Author:  
# Function: 
#

        
        .text                   # Add what follows to the text segment of the program
        .globl  main            # Declare the label main to be a global one
main:
         la      $t0,array       # register $t0 contains the address of array
         la      $t1,size        # get address of size
         lw      $t1,0($t1)      # register $t1 contains the size of the array
         
loop:	  beq	 $t1, $zero, end
          lw    $t3,0($t0)      # get array element
          
          
          andi  $t3,$t3,1       # test if bit0 = 0 or bit0 = 1
          
          
          beq	 $t3, $zero, par # if bit0=0 "par" else "impair"
          addiu	 $t4, $t4,1	  # update cont_impar
	  j	continua
par:	  addiu	$t5,$t5,1       # update cont-par

continua: addiu   $t0,$t0,4     # update array pointer. Remember, 1word=4 memory addresses
          addiu   $t1,$t1,-1    # decrement array size counter
          j       loop          # continue execution
        
end:      jr	$ra       

        .data                   # add what follows to the data segment of the program
array:  .word   1 2 3 4 5 6 7 8 9 10 11
                                # Loads the list of ints into successive locations in memory
                                # beginning with location A (i.e. we've initialized an array)
size:   .word   11              # size of the array
