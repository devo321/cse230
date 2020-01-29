###########################################################
# Assignment #: 2
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

num1: .word
num2: .word
num3: .word
num4: .word
message1: .asciiz "Enter a value:"
message2: .asciiz "Enter another value:"
message3: .asciiz "Enter one more value:"
ans1: .asciiz "num3+num4="
ans2: .asciiz "num4-num1="
ans3: .asciiz "num3*num1="
ans4: .asciiz "num1/num2="
ans5: .asciiz "num3 mod num1="
ans6: .asciiz "(num3 mod num4)+((num2 - 21 * num1) / 5)="



