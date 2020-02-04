###########################################################
# Assignment #: 4
#  Name: Deven Pile
#  ASU email: dpile1@asu.edu
#  Course: CSE/EEE230, MWF 3:05pm
#  Description: Computes the price of someones hotel stay
#               based off of the number of beds they need
#               and the number of days the client is
#               staying
###########################################################


.data 

message1: .asciiz "Please enter a number of days that you will be staying:\n"
message2: .asciiz "Please enter a number of beds needed for a hotel room:\n"
message3: .asciiz "Please enter 1 or 2:\n"
totalPrice: .asciiz "Your total price: "
dollars: .asciiz " dollars for "
days:   .asciiz " days\n"
bederror: .asciiz "Sorry, we have only one or two beds per room."


.text
.globl main

main:
    #Lines print the input prompts and recieve input data
    la      $a0, message1
    li      $v0, 4
    syscall

    li      $v0, 5
    syscall
    move    $s0, $v0
    
    la      $a0, message2                           #Num of days
    li      $v0, 4
    syscall
    la      $a0, message3
    syscall

    li      $v0, 5
    syscall
    move    $s1, $v0                                #Num beds

    li      $t0, 1
    li      $t1, 2
    blt     $s1, $t0, bedERR                        #if num beds < 1 goto bedERR
    bgt     $s1, $t1, bedERR                        #if num beds > 2 got  bedERR
    ble     $s0, $zero, zeroOrLess                  #if days <= 0, goto zeroOrLess

    bne		$s1, $t0, TwoBeds	                    # if num beds != 1, goto Twobeds


    #If 1 bed then:
    li      $t0, 8
    bge		$s0, $t0, EightOrMoreOneBed             # if $t0 > 8 then EightOrMore


    #One bed, < 8 days
    li      $t0, 90
    mult	$s0, $t0			                    #Multiplies number of days by 90
    mflo	$t1					                    #Store result

    #Following lines print the output statement
    la      $a0, totalPrice
    li      $v0, 4
    syscall

    li      $v0, 1
    move    $a0, $t1
    syscall

    la      $a0, dollars
    li      $v0, 4
    syscall

    li      $v0, 1
    move    $a0, $s0
    syscall

    la      $a0, days
    li      $v0, 4
    syscall
    

    jr      $ra

    
        
    

    #One bed, 8 or more days
    EightOrMoreOneBed:    
        li      $t0, 90                 
        mult    $s0, $t0                            #Multiplies number of days by 90
        mflo    $t1                                 #Store result

        addi    $t2, $t1, -60                       #subtract discount of $60 from total

        #Following lines print the output statement
        la      $a0, totalPrice
        li      $v0, 4
        syscall
        
        li      $v0, 1
        move    $a0, $t2
        syscall

        la      $a0, dollars
        li      $v0, 4
        syscall

        li      $v0, 1
        move    $a0, $s0
        syscall

        la      $a0, days
        li      $v0, 4
        syscall

        jr      $ra

    
    
    #If two beds
    TwoBeds:     

            li      $t0, 8         
            bge		$s0, $t0, EightOrMoreTwoBeds    #if num of days > 8 && two beds goto EightOrMoreTwoBeds     
            #Two beds, < 8 days
            li      $t0, 150

            mult    $s0, $t0                        #multiplies number of days by 150
            mflo    $t1                             #store result                             

            #Following lines print the output statement
            la      $a0, totalPrice
            li      $v0, 4
            syscall

            li      $v0, 1
            move    $a0, $t1
            syscall

            la      $a0, dollars
            li      $v0, 4
            syscall

            li      $v0, 1
            move    $a0, $s0
            syscall

            la      $a0, days
            li      $v0, 4
            syscall

            jr      $ra

    #Two beds, eight or more days
    EightOrMoreTwoBeds:      

            li      $t0, 150    
            mult    $s0, $t0                        #Multiplies number of days by 150
            mflo    $t1                             #stores result

            addi	$t2, $t1, -90			        #subtracts discount of 90 from total price

            #Following lines print the output statement
            la		$a0, totalPrice
            li      $v0, 4
            syscall

            li      $v0, 1
            move    $a0, $t2
            syscall

            la      $a0, dollars
            li      $v0, 4
            syscall

            li      $v0, 1
            move    $a0, $s0
            syscall

            la      $a0, days
            li      $v0, 4
            syscall

            jr      $ra


        bedERR:                                     #Executes if theres an incorrect number of beds entered

            #Following lines prints the bed error message
            la      $a0, bederror
            li      $v0, 4
            syscall

            jr      $ra

            zeroOrLess:                             #Executes if 0 days or less are entered

            #Following lines print the output statement
            la      $a0, totalPrice
            li      $v0, 4
            syscall

            move    $a0, $zero
            li      $v0, 1
            syscall

            la      $a0, dollars
            li      $v0, 4
            syscall

            move    $a0, $s0
            li      $v0, 1
            syscall

            la      $a0, days
            li      $v0, 4
            syscall

            jr      $ra

    jr  $ra