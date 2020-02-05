###########################################################
# Assignment #: 5
#  Name: Deven Pile
#  ASU email: dpile1@asu.edu
#  Course: CSE/EEE230, MWF 3:05pm
#  Description: ADD IN BEFORE SUBMITTING
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

    lw      $t1, numbers_len
    la      $t2, numbers
    li      $s3, 4              #make index a mem addy
    li      $s4, 3              #number to multiply by

    mult    $t1, $s3
    mflo    $t1
      

    #Input Prompt
    la      $a0, startingindx
    li      $v0, 4
    syscall

    li      $v0, 5
    syscall
    move    $s0, $v0            #start indx

    ble     $s0, $zero, settozero 
    mult    $s0, $s3
    mflo    $t6
    j       continue

    settozero:
        move $t6, $zero
        j   continue
        
    continue:

    la      $a0, endindx
    li      $v0, 4
    syscall

    li      $v0, 5
    syscall
    move    $s1, $v0            #s1 = end indx
    mult    $s1, $s3
    mflo    $t5


    la      $a0, enterInt
    li      $v0, 4
    syscall

    li      $v0, 5
    syscall
    move    $s2, $v0            #s2 = compare int

    mult $s2, $s4
    mflo $t3                    #t3 = num to subtract by



    move $t0, $t6

    
    #Loop

    Loop:

        beq     $t0, $t5, exit

        lw      $t6, numbers($t0)

        blt     $t6, $s2, less
        sub     $t7, $t6, $t3

        sw      $t7, numbers($t0)
        addi    $t0, $t0, 4

        j       Loop


        less:
            addi    $t0, $t0, 4
            j       Loop



    exit:

    addi    $t0, $zero, 0

    la      $a0, arrayContent
    li      $v0, 4
    syscall


    PrintLoop:
        beq     $t0, $t1 exitPrint
        lw      $t6, numbers($t0)
        addi    $t0, $t0, 4

        move $a0, $t6
        li $v0, 1
        syscall

        la      $a0, newline
        li      $v0, 4
        syscall

        j PrintLoop

    

    exitPrint:

        jr  $ra





    #Load and store values, another loop is needed to print the values out
 #   Loop:
 #       beq     $s5, $s1, Exit      #exit if s0 = s1
#
 #       blt     $t5, $s2, less      # t5 < $s2 goto less
 #       
 #       
#
#
#
 #       less:
 #           #Jump back to loop start
 #           sll     $s5, $s5, 2
 #           j       Loop
#
#
#
 #   Exit:
 #       PrintLoop:
 #           
#
 #       
 #   end:
 #       jr  $ra


    jr $ra

    





