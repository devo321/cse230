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

#num1: .word
#num2: .word
#num3: .word
#num4: .word
message1: .asciiz "\nEnter a value: "
message2: .asciiz "\nEnter another value: "
message3: .asciiz "\nEnter one more value: "
ans1: .asciiz "\nnum3+num4= "
ans2: .asciiz "\nnum4-num1= "
ans3: .asciiz "\nnum3*num1= "
ans4: .asciiz "\nnum1/num2= "
ans5: .asciiz "\nnum3 mod num1= "
ans6: .asciiz "\n(num3 mod num4)+((num2 - 21 * num1) / 5)= "

.text
.globl main  #define a global function main

main:

    la $a0, message1
    li $v0, 4
    syscall

    li $v0, 5
    syscall
    move $a0, $v0
    li $v0, 1
    syscall
    


    jr $ra




