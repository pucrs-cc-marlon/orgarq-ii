# MARS example: Manipulating arrays
# Author:  
# Function: This code adds the value of a constant (const) to each element of an array
#

        
        .text                   # Add what follows to the text segment of the program
        .globl  main            # Declare the label main to be a global one
main:
        la      $t0,array       # register $t0 contains the address of array
        la      $t1,size        # get address of size
        lw      $t1,0($t1)      # register $t1 contains the size of the array
        la      $t2,const       # get address of constant
        lw      $t2,0($t2)      # register $t2 contains the constant to add

# loop:   blez    $t1,end         # if size is/becomes 0, end of processing
  loop:	beq	$t1, $zero, end
        lw      $t3,0($t0)      # get array element
        addu    $t3,$t3,$t2     # add constant
        sw      $t3,0($t0)      # update array
        addiu   $t0,$t0,4       # update array pointer. Remember, 1word=4 memory addresses
        addiu   $t1,$t1,-1      # decrement array size counter
        j       loop            # continue execution
        
end:    jr	$ra       

        .data                   # add what follows to the data segment of the program
array:  .word   0x12 0xff 0x3 0x14 0x878 0x31  0x62 0x10 0x5 0x16 0x20
                                # Loads the list of ints into successive locations in memory
                                # beginning with location A (i.e. we've initialized an array)
size:   .word   11              # size of the array
const:  .word   0x100           # constant to add to each element of the array
