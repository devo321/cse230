###########################################################
# Assignment #: 3
#  Name: Deven Pile
#  ASU email: dpile1@asu.edu
#  Course: CSE/EEE230, MWF 3:05pm
#  Description: This program prompts the user for four
#               inputs. The program then performs
#               addition, subtraction, multiplication, 
#               integer division, and modulo on the 
#               inputted integers. 
###########################################################

#data declarations

.data

message1: .asciiz "Enter a value:\n"
message2: .asciiz "Enter another value:\n"
message3: .asciiz "Enter one more value:\n"
ans1: .asciiz "\nnum3+num4="
ans2: .asciiz "\nnum4-num1="
ans3: .asciiz "\nnum3*num1="
ans4: .asciiz "\nnum1/num2="
ans5: .asciiz "\nnum3 mod num1="
ans6: .asciiz "\n(num3 mod num4)+((num2-21*num1)/5)="

.text
.globl main  #define a global function main

main:

    la      $a0, message1            #display message1
    li      $v0, 4
    syscall

    li      $v0, 5
    syscall
    move    $s0, $v0		        #$v0 = s0    #stores user input into $s0; $s0 = num1

    la      $a0, message2           #display message2
    li      $v0, 4
    syscall

    li      $v0, 5
    syscall
    move    $s1, $v0               #stores user input into $s1; $s1 = num2

    la      $a0, message3
    li      $v0, 4
    syscall

    li      $v0, 5
    syscall
    move    $s2, $v0               #store user input into $s2; $s2 = num3 

    li      $v0, 4
    syscall

    li      $v0, 5
    syscall
    move    $s3, $v0               #store user input into $s3; $s3, num4


    la      $a0, ans1              #load string into a0 and print
    li      $v0, 4
    syscall

    add     $t0, $s2, $s3          #add num3 + num4
    
    li      $v0, 1                  #print 'num3+num4' + ans
    move    $a0, $t0
    syscall

    la      $a0, ans2               #load a0 with string and print
    li      $v0, 4
    syscall

    sub     $t0, $s3, $s0           #subtract num4 - num1

    li      $v0, 1                  #print 'num4-num1' + ans
    move    $a0, $t0
    syscall

    la      $a0, ans3               #load a0 with string and print
    li      $v0, 4
    syscall

    mult	$s2, $s0		        # $s2 * s1 = Hi and Lo registers
    mflo	$t0					    # copy Lo to $t0

    li      $v0, 1                  #print num3*num1 = ans
    move    $a0, $t0
    syscall

    
    la      $a0, ans4
    li      $v0, 4
    syscall
    
    div	    $s0, $s1			    # s0 / $s1
    mflo	$t0					    # $t2 = floors0 / $t1) 
    
    li      $v0, 1                  #print num1/num2 = ans
    move    $a0, $t0
    syscall  

    la      $a0, ans5
    li      $v0, 4
    syscall

    div		$s2, $s0			    # $s2 / s0
    mfhi	$t0				        #mfhi = mod
    
    li      $v0, 1
    move    $a0, $t0
    syscall

    la      $a0, ans6
    li      $v0, 4
    syscall

    div		$s2, $s3		        # $s2 / s3
    mfhi	$t0       			    #mod num3 % num4

    li      $s4, 21                 #multiply num1 * 21
    mult    $s0, $s4
    mflo    $t1

    sub     $t2, $s1, $t1           #subtract num2 - (21 * num1)

    li      $s5, 5                  #load 5 into $s5

    div		$t2, $s5                #divide (num2 - 21 * num1) / 5
    mflo    $t4

    add $t5, $t0, $t4 			    #add (num3 % num4) + ((num2 - 21 * num1) / 5)
    
    li $v0, 1
    move $a0, $t5
    syscall

    jr $ra

    

    

