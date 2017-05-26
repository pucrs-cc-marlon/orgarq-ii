# MARS example: Manipulating arrays
# Author:  
# Function: This code adds the value of a constant (const) to each element of an array
#

        
        .text                   # Add what follows to the text segment of the program
        .globl  main            # Declare the label main to be a global one
main:
        la      $t0,V1          # register $t0 contains the address of array V1
        la	    $t1,V2		# register $t1 contains the address of array V2
        la      $t2,V3          # register $t2 contains the address of array V3
        la 	    $t3,size	# get address of size
        lw      $t3,0($t3)      # register $t1 contains the size of the array
loop:   blez    $t3,end         # if size is/becomes 0, end of processing
        lw      $t4,0($t0)      # get array element (V1)
        lw	    $t5,0($t1)	# get array element (V2)
        addu    $t4,$t4,$t5     # add V1+V2
        sw      $t4,0($t2)      # store the result in V3
        addiu   $t0,$t0,4       # update array pointer (V1). Remember, 1word=4 memory addresses
        addiu   $t1,$t1,4       # update array pointer (V2). 
        addiu   $t2,$t2,4       # update array pointer (V3). 
        addiu   $t3,$t3,-1      # decrement array size counter
        j       loop            # continue execution
        
end:    jr	$ra       

        .data                   # add what follows to the data segment of the program
V1:     .word   0x12 0xff 0x3 0x14 0x878 0x31  0x62 0x10 0x5 0x16 0x20
V2:     .word   0x12 0xff 0x3 0x14 0x878 0x31  0x62 0x10 0x5 0x16 0x20
V3:     .word   0x0  0x0  0x0 0X0  0x0   0x0   0x0  0X0  0x0  0x0  0x0 
                                # Loads the list of ints into successive locations in memory
                                # beginning with location A (i.e. we've initialized an array)
size:   .word   11              # size of the array
