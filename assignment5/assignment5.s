###########################################################
# Assignment #: 5
#  Name: Deven Pile
#  ASU email: dpile1@asu.edu
#  Course: CSE/EEE230, MWF 3:05pm
#  Description: Modifies an array between two user
#               determined indexes and compares the values
#               stored in the array between those indexes
#               to a user determined integer. If the value
#               in that index of the array is greater than
#               the integer value its being compared to
#               the number stored in that index will have
#               three times the value of the integer its
#               being compared against subtracted from it
#               and then be stored back into the array at
#               the same index.
#
#               The updated array is then printed at the
#               end of the program
###########################################################

.data 

numbers_len:    .word       12
numbers:        .word       45, -6, 23, -7, 15, -17, 11, -4, 23, -26, 2, 19

startingindx:   .asciiz     "Enter a starting index:\n"
endindx:        .asciiz     "Enter an ending index:\n"
enterInt:       .asciiz     "Enter an integer:\n"
arrayContent:   .asciiz     "Result Array Content:\n"
newline:         .asciiz     "\n"

.text
.globl main

main:

    lw      $t1, numbers_len                #load numbers_len value from .data into $t1
    la      $t2, numbers                    #load numbers array from .data into $t2
    li      $s3, 4                          #load 4 into $s3 for use in converting index numbers into memory addresses
    li      $s4, 3                          #load 3 into $s4 to multiply by the user inputted integer by 3 for subrating from array value if it is less than the number before it was multiplied by 3

    mult    $t1, $s3                        #multiply value stored in $t1 by 4 to reflect memory address
    mflo    $t1                             #store multiplied value back into $t1 for use later in the program
      

    #Input Prompt
    la      $a0, startingindx               #Load ascii value stored in startingindx into $a0
    li      $v0, 4                          #load $v0 with 4 to print the ascii value stored in $a0
    syscall                                 #system call to print the ascii value stored in $a0

    li      $v0, 5                          #load $v0 with 5 to read an int from the keyboard
    syscall                                 #system call to read an int from the keyboard
    move    $s0, $v0                        #move user input value into $s0 for use later in the program

    ble     $s0, $zero, settozero           #break to settozero if start index is <= 0
    mult    $s0, $s3                        #multiply start index value by 4 to reflect memory address value
    mflo    $t6                             #store multiplication result in $t6
    j       continue                        #jump to continue label

    settozero:                              #label that is jumped to if starting index <= 0
        move $t6, $zero                     #set $t6 to zero
        j   continue                        #jump to continue label

    continue:                               #label to jump to after comparison statement

    la      $a0, endindx                    #Load ascii value stored in endindx into $a0
    li      $v0, 4                          #load $v0 with 4 to print the ascii value stored in $a0
    syscall                                 #system call to print the ascii value stored in $a0

    li      $v0, 5                          #load $v0 with 5 to read an int from the keyboard
    syscall                                 #system call to read an int from the keyboard
    move    $s1, $v0                        #move user input value into $s1 for use later in the program
    mult    $s1, $s3                        #multiply user input value by 4 as to reflect the memory address of that index
    mflo    $t5                             #store multiplied value into $t5 for use later in the program 


    la      $a0, enterInt                   #Load ascii value stored in enterInt into $a0
    li      $v0, 4                          #load $v0 with 4 to print the ascii value stored in $a0
    syscall                                 #system call to print the ascii value stored in $a0

    li      $v0, 5                          #load $v0 with 5 to read an int from the keyboard
    syscall                                 #system call to read an int from the keyboard
    move    $s2, $v0                        #move user input value into $s2 for use later in the program

    mult $s2, $s4                           #Mulitplies the compare integer by 3 to be used later for subtracting from the value pulled from the array by the loop
    mflo $t3                                #store multiplied value into $t3



    move $t0, $t6                           #store value in $t6 into $t0; $t0 is the counter variable


    Loop:                                   #Lable for the loop

        beq     $t0, $t5, exit              #If the index ==  end index, exit program

        lw      $t6, numbers($t0)           #load value at current index into $t6   

        blt     $t6, $s2, less              #If current number is less than compare number, branch to less
        sub     $t7, $t6, $t3               #If current number is greater than compare number, subtract 3 times
                                            #the compare number from the current number

        sw      $t7, numbers($t0)           #store value back into array at its original index
        addi    $t0, $t0, 4                 #increment counter variable
    
        j       Loop                        #Jump to top of loop


        less:
            addi    $t0, $t0, 4             #Increment counter variable
            j       Loop                    #jump to loop begining 



    exit:                                   #exit point for first loop

    addi    $t0, $zero, 0                   #reset counter to 0

    la      $a0, arrayContent               #load ascii value in arrayContent into $a0        
    li      $v0, 4                          #load 4 into $v0 to print an ascii value 
    syscall                                 #system call to print ascii value stored in $a0


    PrintLoop:                              #Loop to print modified array
        beq     $t0, $t1 exitPrint          #if counter reaches end of the array size, jump to exitPrint
        lw      $t6, numbers($t0)           #load value from current index
        addi    $t0, $t0, 4                 #incrememnt index var

        move $a0, $t6                       #move current value to $a0 register for printing
        li $v0, 1                           #load 1 into $v0 to print an integer 
        syscall                             #system call to print the value of $a0 

        la      $a0, newline                #Print a newline
        li      $v0, 4                      #load 4 into $v0 to print the ascii value stored in $a0
        syscall                             #system call to print the ascii value in $a0

        j PrintLoop                         #jump to top of loop

    

    exitPrint:                              #end of the program

        jr  $ra                             #jump to return address

    





