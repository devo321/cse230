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

    bne		$s1, $t0, TwoBeds	                    # if $s1 != 1 then TwoBeds


    #If 1 bed then:
    li      $t0, 8
    bge		$s0, $t0, EightOrMoreOneBed           # if $t0 > 8 then EightOrMore


    #One bed, < 8 days
    li      $t0, 90
    mult	$s0, $t0			# $s0 * $t0 = Hi and Lo registers
    mflo	$t1					# copy Lo to $t1

    #print total
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
        mult    $s0, $t0
        mflo    $t1

        addi    $t2, $t1, -60

        #print total
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
            bge		$s0, $t0, EightOrMoreTwoBeds 
            #Two beds, < 8 beds
            li      $t0, 150

            mult    $s0, $t0
            mflo    $t1


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
            mult    $s0, $t0
            mflo    $t1

            addi	$t2, $t1, -90			# $t1 = $t1 - 90

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


        bedERR:

            la      $a0, bederror
            li      $v0, 4
            syscall

            jr      $ra

        zeroOrLess:

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