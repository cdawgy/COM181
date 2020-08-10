## Name of Program:		    Version number:	0.01            Date last changed: 10/08/2020
## Name of Author: Conor Loughran
## Description of Program: Display array to user and allow user to manipulate data within the array based on menu.

.data
    ## Array set up
    array:	.word 0x00, 0x33, 0x44, 0x88, 0x56, 0x45, 0x56, 0x41, 0x00, 0x33, 0x44, 0x88, 0x56, 0x45, 0x56, 0x41, 0x00, 0x33, 0x44, 0x88, 0x56, 0x25, 0x58, 0x51, 0x03, 0x33, 0x24, 0x83, 0x52, 0x72, 0x16, 0x73, 0x85, 0x45, 0x47, 0x86, 0x36, 0x43, 0x52, 0x41, 0x74, 0x32, 0x04, 0x28, 0x26, 0x23, 0x46, 0x46, 0x06, 0x33, 0x34, 0x23, 0x21, 0x53, 0x15, 0x47, 0x77, 0x38, 0x41, 0x89, 0x58, 0x42, 0x51, 0x40, 0x86, 0x53, 0x40, 0x58, 0x36, 0x67, 0x53, 0x71, 0x03, 0x33, 0x74, 0x01, 0x89, 0x45, 0x12, 0x86, 0x60, 0x93, 0x42, 0x34, 0x66, 0x41, 0x51, 0x22, 0x60, 0x73, 0x41, 0x48, 0x46, 0x55, 0x52, 0x21, 0x00, 0x33, 0x64, 0x48, 0x66, 0x95, 0x53, 0x01, 0x03, 0x03, 0x24, 0x18, 0x16, 0x42, 0x53, 0x12, 0x40, 0x27, 0x47, 0x38, 0x56, 0x33, 0x58, 0x49, 0x09, 0x33, 0x04, 0x31, 0x34, 0x02, 0x22, 0x32
    arraylength:	.word 0x80

    ## Menu options
    option1: .asciiz "1) Display entire array.\n"
    option2: .asciiz "2) Print largest and smallest number in array\n"
    option3: .asciiz "3) Swap largest and smaller number in array\n"
    option4: .asciiz "4) Smooth array\n"
    option5: .asciiz "5) Reverse order of the array\n"

    ## User feedback
    input: .asciiz "\n Select function: "
    breakLine: .asciiz "\n"
    finish: .asciiz "Would you like to try another function? (1=yes, 2=no)\n"
    largestNumber: .asciiz "The largest number is: "
    smallestNumber: .asciiz "The smallest number is: "

    ## Function constants
    li $s6, 0       # Smallest num
    li $s7, 10      # Largest num

.globl main
.text

main:
    ## Array address and loop values
    la $t0, array           # Load the address of the array in t0
    lw $t1, arraylength     # Using load word gets the value of arraylength and stores it in t6
    li $t2, 0               # Store value zero in t2

    ## Branch comparison values
    li $s1, 1
    li $s2, 2
    li $s3, 3
    li $s4, 4
    li $s5, 5

    ##### PRINT MENU #####

    ## Print menu option one
    li $v0, 4           # System call code for printing string
    la $a0, option1     # $address of string to print
    syscall

    ## Print menu option two
    li $v0, 4 
    la $a0, option2 
    syscall

    ## Print menu option three
    li $v0, 4 
    la $a0, option3 
    syscall

    ## Print menu option four
    li $v0, 4 
    la $a0, option4 
    syscall

    ## Print menu option five
    li $v0, 4 
    la $a0, option5 
    syscall

    ## Get user to select function
    li $v0, 4       # System call code for printing string
    la $a0, input   # $address of string to print
    syscall         # perform system call to print the message

    li $v0, 5       # Read user input
    syscall         # perform syscall to take user input and store in $v0 register
    move $s0, $v0   # move value from $v0 to $s1 so it isnt over written
    

    ##### Functions #####

    # These branch equals functions will send the user to the correct code block

    beq $s0, $s1, func1
    beq $s0, $s2, func2
    beq $s0, $s3, func3
    beq $s0, $s4, func4
    beq $s0, $s5, func5
    
func1:
    beq $t2, $t1, end   # If t2 equals t2 then jump to end function

    ## Print value of array at given index
    lw $a0, ($t0)
    li $v0, 1
    syscall

    li $v0, 4 
    la $a0, breakLine 
    syscall

    addi $t2, $t2, 1    # Increment counter $t2
    addi $t0, $t0, 4    # Advance array pointer

    j func1             # Jump to the start of func1 and execute again

############## Function 2 ##############
func2:
    beq $t2, $t1, func2Finish # If t2 equals t2 then jump to end function

    ## Store value of pointed array value in t4
    lw $a0, ($t0)
    move $t4, $a0           # $t4 is the current array value that we are comparing against

    bgt $s7, $t4, lessThan
    returnPoint:
    blt $s6, $t4, greaterThan

    addi $t2, $t2, 1        # Increment counter $t7
    addi $t0, $t0, 4        # Advance array pointer

    j func2 # Jump to the start of func1 and execute again

greaterThan:
    move $s6, $t4
    j returnPoint

lessThan:
    move $s7, $t4
    j returnPoint

func2Finish:
    li $v0, 4 
    la $a0, smallestNumber 
    syscall

    li $v0, 1
    move $a0, $s6
    syscall

    li $v0, 4 
    la $a0, breakLine 
    syscall

    li $v0, 4 
    la $a0, largestNumber 
    syscall

    li $v0, 1
    move $a0, $s7
    syscall

    li $v0, 4 
    la $a0, breakLine 
    syscall

    j end

########################################

############## Function 3 ##############
func3:
    j end

########################################

############## Function 4 ##############
func4:
    beq $t2, $t1, end       # If t2 equals t2 then jump to end function
    beq $t2, 0, firstNum    # Skip the first number for smoothing

    ## Constants
    li $s5, 4              # 25% denominator
    li $s4, 2              # 50% denominator
    li $s3, 100             # 100 multiplier

    ## Let $t3 and $t5 be before and after numbers and $t4 be current

    ## Previous number
    sub $t3, $t0, 4     #
    lw $a0, ($t3)       #
    move $t3, $a0       #
    div $t3, $s5        # Get 25% of value
    mflo $t3            #
    
    
    
    ## Current Number   #
    lw $a0, ($t0)       #
    move $t4, $a0       #
    div $t4, $s4        # Get 50% of value
    mflo $t4            #
    

    ## Next number
    addi $t5, $t0, 4    #
    lw $a0, ($t5)       #
    move $t5, $a0       #
    div $t5, $s5        # Get 25% of value
    mflo $t5            #

    ## Add all values together
    add $t6, $t3, $t4
    add $t6, $t6, $t5

    sw $t6, 0($t0) # Load new smoothed value into array

    funcFourReturn:

    addi $t2, $t2, 1        # Increment counter $t7
    addi $t0, $t0, 4        # Advance array pointer

    j func4                 # Jump to the start of func1 and execute again

firstNum:
    j funcFourReturn

########################################

func5:
    j end

end:
    ## Ask user if they would like to use another function before quitting
    li $v0, 4
    la $a0, finish
    syscall
    ##
    li $v0, 5
    syscall
    move $t3, $v0
    ##
    beq $t3, 1, main

    ## Terminate program using system call code 10
    li $v0, 10
    syscall