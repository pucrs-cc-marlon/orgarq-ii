main:
sub $sp, $sp, 4 # allocate memory in stack to strore 4 bytes
sw  $ra, ($sp)      # save return address to stack
# Get file name from user
jal getFileName
# Open file in read mode
la  $a0, szFilename
li  $a1, 0  # open for reading
jal fopen
# Save file handler
la  $a0,    hFile
sw  $v0, ($a0)
######### MAIN INTERPRETER CODE ###########

la  $a0, hFile
lw  $a0, ($a0)  # $a0 = file handler
la  $a1, line       # $a1 = address of line
li  $a3, 255        # $a3 = length of line
jal readLine

la  $a0, line
jal puts

# try to read next line

la  $a0, hFile
lw  $a0, ($a0)  # $a0 = file handler
la  $a1, line       # $a1 = address of line
li  $a3, 255        # $a3 = length of line
jal readLine

la  $a0, line
jal puts
lw  $ra, ($sp)      # get return address from stack
addi    $sp, $sp, 4 # clear reserved bytes
jr $ra

getFileName:
sub $sp, $sp, 4 # allocate memory in stack to strore 4 bytes
sw  $ra, ($sp)      # save return address to stack
# display message
la  $a0, szEnterFilename
jal puts
#############
# get filename from console
la  $a0, szFilename
li  $a1, 16
jal gets
###############
la  $a0, szFilename
li  $a1, 10
li  $a2, 0
jal strrep
###############
lw  $ra, ($sp)      # get return address from stack
addi    $sp, $sp, 4 # clear reserved bytes
jr  $ra         # return to caller

# Open file for reading
# $a0 - address of filename
# $a1 - mode (flags are 0: read, 1: write)
# Return value: $v0 - file handler
fopen:
    li  $v0, 13                  # system call for open file
    li  $a2, 0                  # mode is ignored
    syscall                             # open a file (file descriptor returned in $v0)
    jr  $ra

# Reads one line from file
# $a0: file handler
# $a1: address of line
# $a3: line length
# Return value:
#   $v0 : number of characters read (0 if EOF, negative if error)
readLine:
    li  $t0, 0  # we will store here total bytes read before \n
rl_read:
    li  $a2, 1  # max number of character to read
    li  $v0, 14 # code to read from file
    syscall     # read from file
    add     $t0, $t0, $v0
    lb  $t1, ($a1)
    beq $t1, 13, rl_end
    beq $t1, 10, rl_end
    beq  $t1, $zero, rl_end
    or  $t1, $t1, 0x20
    sb  $t1, ($a1)
    addi    $a1, $a1, 1
    j   rl_read
rl_end:
    sb  $zero, ($a1)
    jr  $ra

# Read string from console
# $a0 - address of line
# $a1 - length of line
gets:
    li  $v0, 8
    syscall
    jr  $ra

puts:
    li $v0, 4
    syscall
    li $v0, 11
    li $a0, 10
    syscall
    jr $ra

strrep:
    lb $t0, ($a0)
    beq $t0, $zero, strrep_end
    bne $t0, $a1, strrep_next
    sb $a2, ($a0)
strrep_next:
    addiu $a0, $a0, 1
    b strrep
strrep_end:
    jr $ra

.data
hFile: .word 0
szEnterFilename: .asciiz "Enter filename: "
szFilename: .space 80
line: .space 255