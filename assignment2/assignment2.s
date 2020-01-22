###########################################################
# Assignment #: 2
#  Name: Deven Pile
#  ASU email: dpile1@asu.edu
#  Course: CSE/EEE230, MWF 3:05pm
#  Description: Program Displays two numbers and calculates
#               their sum and difference and displays it
###########################################################

#data declarations: declare variable names used in program, storage allocated in RAM

.data

num1: .word 86259
num2: .word 0xB7A
message1: .asciiz "Num 1 is: \n"
message2: .asciiz "Num 2 is: \n"
message3: .asciiz "num1 + num2 = \n"
message3: .asciiz "num1 - num2 = \n"

.text
.globl main #Define a global function main

main: 

    lw  $t0, num1
    lw  $t1, num2

    add $s0 $t0 $t1
    sub $s0 $t0 $t1

    li $v0, 4
    syscall

    jr  $ra         #return