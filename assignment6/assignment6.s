###########################################################
# Assignment #: 6
#  Name: Deven Pile
#  ASU email: dpile1@asu.edu
#  Course: CSE/EEE230, MWF 3:05pm
#  Description: User defines how many times program will 
#               loop, array size, and values to compare 
#               array values against
###########################################################


.data

numbers:            .word       0, 0, 0, 0, 0, 0, 0, 0, 0, 0
repeattxt:          .asciiz     "Specify how many times to repeat:\n" 
numbersForArray:    .asciiz     "Specify how many numbers should be stored in the array (at most 10):\n"
enterInt:           .asciiz     "Enter an integer:\n"
enterAnotherInt:    .asciiz     "Enter another integer:\n"
arrayContent:       .asciiz     "Array Content:\n"
newline:            .asciiz     "\n"


.text

.globl main

main:
    la      $s0, numbers                    #s0 holds numbers array addr
    li      $s4, 4
    li      $s5, 10                         #max array length value
    addi    $sp, $sp, 4                 
    sw      $ra, 0($sp)                     #store original return address

    la      $a0, repeattxt
    li      $v0, 4
    syscall

    la      $v0, 5
    syscall
    move    $s7, $v0                        #store num times to repeat in s1

    move    $t0, $zero                      #set t0 to 0 for loop control


    While:
        beq		$t0, $s7, exit	            # if $t0 == $t1 then target

        jal     readArray

        jal     printArray

        jal     modifyArray

        jal     printArray	

        addi	$t0, $t0, 1			# $t0 = $t1 + 1
        					
    j   While

    exit:	
        lw  $ra, 0($sp)	
        jr      $ra			



############################################################################
# Procedure/Function readArray
# Description: asks how many numbers to be entered, reads in integers to fill the array
# parameters: numbers = address of array , $t7 = size
# return value: $v1 = length
# registers to be used: $t7, $t1, $t4 to be used
############################################################################

readArray:                                  

    move    $t1, $zero                      #t1 = array counter

    la      $a0, numbersForArray
    li      $v0, 4
    syscall

    li      $v0, 5
    syscall
    move    $t7, $v0                        #reads how many integers will be stored in the array
    bgt		$t7, $s5, setToTen	            # if $t7 > $s5 then target
    blt     $t7, $zero, setToZero
    j       continue

    setToTen:
        move    $t7, $zero
        addi    $t7, $t7, 10 
        j       continue

    setToZero:
        move $t7, $zero
        j       continue

    continue:
    mult    $t7, $s4
    mflo    $t7
    move    $v1, $t7

    readLoop:

        beq		$t1, $t7, exitReadLoop	# if $t1 == $t7 then exitReadLoop

        la      $a0, enterInt
        li      $v0, 4
        syscall
        

        li      $v0, 5
        syscall
        move    $t4, $v0
				
        
        sw      $t4, numbers($t1)
        addi    $t1, $t1, 4

        j       readLoop
        
        
    

    exitReadLoop:

        jr      $ra




############################################################################
# Procedure/Function modifyArray
# Description: asks for 2 numbers, loops through array, if larger than max, subtracts max from num, if lower than min, adds min to it
# parameters: numbers = address of array , $t7 = size
# return value: n/a
# registers to be used: $s2, $s3, $t1, $t4, $t5, $t6, and $t7 will be used.
############################################################################

modifyArray:                                #asks for 2 numbers, loops through array, if larger than max, subtracts max from num, if lower than min, adds min to it

    move    $t1, $zero                      #t1 used as loop counter
    la      $a0, enterInt
    li      $v0, 4
    syscall

    li      $v0, 5
    syscall
    move    $s2, $v0

    la      $a0, enterAnotherInt
    li      $v0, 4
    syscall

    li      $v0, 5
    syscall
    move    $s3, $v0                        #s2 and s3 hold comparison values

    blt		$s2, $s3, modifyLoop	# if $s2 < $s3 then target
    move    $t4, $s2                        #this happens when s3 < s2
    move    $t6, $s3
    move 	$s2, $t6		
    move    $s3, $t4                        #s3 is max, s2 is min


    modifyLoop:

        beq		$t1, $t7, exitModifyLoop	        # if $t1 == $t7 then exitModifyLoop
        
        lw      $t5, numbers($t1)
        blt     $t5, $s2, less
        bgt		$t5, $s3, greater
        addi    $t1, $t1, 4
        j       modifyLoop

        greater:                            #subtracts max from arry val
            sub		$t5, $t5, $s3	        # $t5 = $t5 - $s3
            sw      $t5, numbers($t1)
            addi    $t1, $t1, 4
            j       modifyLoop
        


        less:                               #add min value to arry val
            add     $t5, $t5, $s2
            sw      $t5, numbers($t1)
            addi    $t1, $t1, 4
            j       modifyLoop


        
    
    exitModifyLoop:

    jr      $ra





############################################################################
# Procedure/Function printArray
# Description: Prints the array 
# parameters: numbers = address of array , $t7 = size
# return value: none, its a print function
# registers to be used: $t1, $t4, and $t7 will be used.
############################################################################
printArray:                                 


    move    $t1, $zero
    
    la      $a0, arrayContent
    li      $v0, 4
    syscall

    printLoop:
        beq		$t1, $t7, exitPrintLoop	# if $t1 == $t7 then exitPrintLoop



        lw      $t4, numbers($t1)

        move    $a0, $t4
        li      $v0, 1
        syscall

        la      $a0, newline
        li      $v0, 4
        syscall

        addi	$t1, $t1, 4     	# $t1 = $t1 + 4       
        j       printLoop
        
    exitPrintLoop:
        
        jr      $ra

    



