###########################################################
# Assignment #: 11
#  Name: Deven Pile
#  ASU email: dpile1@asu.edu
#  Course: CSE/EEE230, MWF 3:05pm
#  Description: User enters floating point numbers that
#               are stored in an array then prints the
#               array. This is done again for a second
#               array, and then the two arrays are
#               compared. If a number in the first array
#               is larger than the number in the second
#               array, the numbers are swapped. The 
#               arrays are then printed
###########################################################


.data
# 

array_len:      .word        15
array1:
    .float  0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000
     
array2:        
    .float  0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000, 0.00000      
    

arrayPrompt:    .asciiz     "How many numbers should be stored in the array? (At most 15)\n"
firstArray:     .asciiz     "First Array\n"
secondArray:    .asciiz     "Second Array\n"
enterNum:       .asciiz     "Enter A Number:\n"
array1Content:  .asciiz     "First Array Content\n"
array2Content:  .asciiz     "Second Array Content\n"
array1ContentR: .asciiz     "First Array Result Content\n"
array2ContentR: .asciiz     "Second Array Result Content\n"
return:         .asciiz     "\n"

.text

.globl main


main:
    lw		    $t1, array_len                      #t1 = int arry len
    li          $t3, 4


    
    li          $t0, 0                         #t0 = Count variable
    la          $s1, array1                    #s1 = address of First Array
    la          $s2, array2                    #s2 = address of Second Array

    repeat:
    #Printing the array prompt
    la          $a0, arrayPrompt                    #Print Array Prompt
    li          $v0, 4
    syscall


    #Reads Array size from user, then converts that value into a value useable as an array index

    li          $t3, 4
    li          $v0, 5                              #Read Array Size from User
    syscall

    bgt		$v0, $t1, repeat	                    # if $v0 >= $t1 then target
    	        
    



    move        $s0, $v0                            #Move input value fron v0 to s0
    mult	    $s0, $t3			                # $t0 * $t1 = Hi and Lo registers
    mflo	    $s0					                # copy Lo to $t2
    
    
    #Print the First array Prompt
    la          $a0, firstArray
    li          $v0, 4
    syscall

    #Loop to load array 1 with values
    
    Loop:  
        beq     $t0, $s0, outLoop1	                #if $t0 == $t1 then target

        la      $a0, enterNum
        li      $v0, 4
        syscall

        li      $v0, 6
        syscall

        s.s     $f0, array1($t0)

        addi    $t0, $t0, 4
        
        j Loop

outLoop1:
 move    $t0, $zero                             #Reset Count Variable

    #Print array 1


    la      $a0, firstArray
    li      $v0, 4
    syscall

    PrintLoop1:
        beq     $t0, $s0, printOut1             #Break when index = max value
        
        #Print current index of the array 
        l.s     $f12, array1($t0)               #Load Float from array into f12
        li      $v0, 2
        syscall
        
        #Print a return
        la      $a0, return
        li      $v0, 4
        syscall

        #Add 4 to index counter
        addi    $t0, $t0, 4

        j PrintLoop1

printOut1:

    move    $t0, $zero                             #Reset Count Variable

    la      $a0, secondArray
    li      $v0, 4
    syscall
    #Fill 2nd Array
    Loop2:
        beq     $t0, $s0, outLoop2                  #Break when index = max val
        
        la      $a0, enterNum                       #Print Enter num text
        li      $v0, 4
        syscall

        li      $v0, 6                              #Read Float from user
        syscall

        s.s     $f0, array2($t0)                    #Store user float in array

        addi    $t0, $t0, 4                         #Increment index

        j Loop2

outLoop2:

    move $t0, $zero                                 #Reset Count

    la      $a0, secondArray                        #Print Second Array Text
    li      $v0, 4
    syscall
    
    #Print Array 2
    PrintLoop2:
        beq     $t0, $s0, printOut2                 #Break if equal

        l.s     $f12, array2($t0)                   #Print value from each index
        li      $v0, 2
        syscall

        la      $a0, return                         #Print a return
        li      $v0, 4
        syscall

        addi    $t0, $t0, 4                         #Increment index by 4

        j PrintLoop2

printOut2:
    move    $t0, $zero                              #Reset counter to 0

    compareLoop:
        beq     $t0, $s0, exitCompare               #Break if equal

        l.s     $f2, array1($t0)                    #Load value in array index into f2
        l.s     $f4, array2($t0)                    #Load value in array index into f4
        c.lt.s  $f4, $f2                            #f4 < f2 no break 
        bc1f   skipSwap

        #Standard Swapping Algorithm
        mov.s 	$f6, $f4		                    #Move f4 to "Temp" f6 
        s.s     $f2, array2($t0)                    #Store f2 into array2 at index
        s.s     $f6, array1($t0)                    #Store f6 (previously f4) into array1
        skipSwap:   

        addi    $t0, $t0, 4                         #Increment count by 4

        j compareLoop

exitCompare:

move    $t0, $zero                                  #Reset Counter

#Print Result text
la      $a0, array1ContentR   
li      $v0, 4
syscall


PrintFinal1:
    #Print Result Loop
    beq     $t0, $s0, printoutFinal1                #Break if equal 

        l.s     $f12, array1($t0)                   #Load value from array at index into f12
        li      $v0, 2                              #Print value in f12
        syscall

        la      $a0, return                         #Print return
        li      $v0, 4
        syscall

        addi    $t0, $t0, 4                        #Increment count by 4

        j PrintFinal1


printoutFinal1:

move $t0, $zero                                     #Reset Counter


#Print result 2 text
la      $a0, array2ContentR 
li      $v0, 4
syscall

PrintFinal2:
    beq     $t0, $s0, printoutFinal2                #Break if equal

        l.s     $f12, array2($t0)                   #Load value from array2 at current index
        li      $v0, 2                              #Print loaded value
        syscall

        la      $a0, return                         #Print return line
        li      $v0, 4
        syscall

        addi    $t0, $t0, 4                         #Increment counter by 4

        j PrintFinal2


printoutFinal2:

jr      $ra                                         #End program























        







    




