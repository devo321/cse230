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
newline: .asciiz "\n"
message1: .asciiz "num1 is: "
message2: .asciiz "num2 is: "
message3: .asciiz "num1+num2 = "
message4: .asciiz "num1-num2 = "

.text
.globl main #Define a global function main

main: 
    lw $t0, num1        #loads num1 into temp register 0
    lw $t1, num2        #loads num2 into temp register 1


    la $a0, message1    #prints 'num1 ='
    li $v0, 4           #
    syscall             #

    move $a0, $t0       #move num from temp register to address register so it can be printed
    li  $v0, 1          #
    syscall             #sycall to print an int

    la $a0, newline     #prints a newline
    li $v0, 4
    syscall

    
    la $a0, message2    #prints 'num2 = '
    li $v0, 4           #
    syscall             #

    move $a0, $t1       #moves num2 from temp register to address register for printing
    li  $v0, 1          #prints num2
    syscall             #prints num2

    la $a0, newline     #print newline
    li $v0, 4
    syscall

    la $a0, message3    #prints 'num1 + num2 = '
    li $v0, 4
    syscall


    add $a1, $t0, $t1   #add num1 to num2
    move $a0, $a1       #moves result of add to address register for printing
    li $v0, 1
    syscall


    la $a0, newline     #print newline
    li $v0, 4
    syscall
    
    la $a0, message4    #prints 'num1-num2 = '
    li $v0, 4
    syscall


    sub $a2, $t0, $t1   #subtract num2 from num1
    move $a0, $a2       #moves result of subtraction to address register for printing
    li $v0, 1
    syscall


    jr  $ra         #return
