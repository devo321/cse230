###########################################################
# Assignment #: 7
#  Name: Deven Pile
#  ASU email: dpile1@asu.edu
#  Course: CSE/EEE230, MWF 3:05pm
#  Description: User enters a number that is modified
#               by a recusive function Function1
###########################################################

.data

prompt:     .asciiz     "Enter an Integer\n"
solution:   .asciiz     "The solution is: "

.text

.globl main

main:
    addi    $sp, $sp, -8
    sw      $ra, 4($sp)

    la		$a0, prompt
    li      $v0, 4
    syscall
    
    li      $v0, 5
    syscall

    move    $a0, $v0

    jal     Function1           #Call Function1 with value in a0
    move    $s0, $v0
    
    #After Recusion ends

    la      $a0, solution
    li      $v0, 4
    syscall                     #print solution string
    
    move    $a0, $s0            #move s0 to a0
    li      $v0, 1          
    syscall                     #print solution integer

    lw      $ra, 4($sp)         #load ra from stack
    addi    $sp, $sp, 8         #return stack pointer to original position

    jr      $ra                 #return
    


############################################################################
# Procedure/Function Function1
# Description: Recursive function. if $a0 (n) is less than 4, the recursion
#               exits and computes (n*3) - 7. Otherwise the function calls
#               itself with n-4 and multiplies n by the result, then calls
#               itself with n-2 and adds the two together. Afterwards
#               the function subtracts n from the result of the above
#               addition and then adds 2 to the total and returns.
# parameters: $a0 = n 
# return value: $v0 = computed value 
# registers to be used: $t0, $t1, and $t2 will be used.
############################################################################
    Function1:
        addi    $sp, $sp, -12
        sw      $ra, 0($sp)
        sw      $a0, 4($sp)         #store values

        ble     $a0, 4, functExit   #a0 <= 4 goto functExit

        addi    $a0, $a0, -4        # n - 4
        jal     Function1           #recurse function(n-4)

        lw      $a0, 4($sp)         
        mult    $v0, $a0
        mflo    $v0
        sw      $v0, 8($sp)         #multiply n* recursed function(n-4), store in stack

        lw      $a0, 4($sp)
        addi    $a0, $a0 -2
        jal     Function1           #recurse function(n-2)

        lw      $t2, 4($sp)         #t2 = n
        lw      $t0, 8($sp)         #t0 = n*function1(n-4)
        add     $v0, $v0, $t0       #add t0 + t2  (function(n-2) + n*function(n-4))
        sub     $v0, $v0, $t2       #subtract t2 (n) from (function(n-2) + n*function(n-4))
        addi    $v0, $v0 2          #add 2 to (function(n-2) + n*function(n-4) - n)

        #return
        lw      $ra, 0($sp)
        addi    $sp, $sp, 12

        jr      $ra

        functExit:
            li      $t1, 3          #load 3 into t1
            lw      $v0, 4($sp)     #load n into v0

            mult    $v0, $t1        #multiply n by 3
            mflo    $v0     
            addi    $v0, $v0, -7    #subtract 7 from n*3
            
            lw      $ra, 0($sp)     #load return address
            addi    $sp, $sp, 12    #return stack pointer to original position from when the fuction was called

            #return
            jr      $ra


