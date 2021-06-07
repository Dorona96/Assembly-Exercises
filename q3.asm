#solution to question 3 maman 12.
#Author: Doron Sharaby
#ID: 204862197
#Date: 18/11/2020

#This program count the frequency of letters in a string

.data 
msg1: .asciiz "\nPlease enter a number in the range -9999 to +9999:\n"
error_msg: .asciiz "\n illegal number. Please try again in the range -9999 to +9999:\n"
binary_msg: .asciiz "\n The number in binary:\n"
binary_rev_msg: .asciiz "\n The reverse number in binary:\n"
deci_rev_msg: .asciiz "\n The reverse number in decimal:\n"
	
.text
.globl main
main:
	li $v0,4
	la $a0,msg1
	syscall
	li $v0,5
	syscall
	bgt $v0,9999,ERROR
	blt $v0,-9999,ERROR
	move $s0,$v0 #$s0 valid int

#print int in 16 bit
	li $v0,1	#print int
	li $t0,0x8000 #mask 1000 0000 0000 0000
	
ERROR: 
	li $v0,4
	la $a0,error_msg
	syscall	
	li $v0,5
	syscall
	bgt $v0,9999,ERROR
	blt $v0,-9999,ERROR
	move $s0,$v0 #$s0 valid int

#print int in 16 bit
	li $v0,1	#print int
	li $t0,0x8000 #mask 1000 0000 0000 0000
	
P_16_bits:
	and $a0, $s0, $t0 #the mask bit
	beqz $a0, P_digit
	li $a0,1
	
P_digit:
	syscall
	srl $t0,$t0,1 #move mask right
	bnez $t0,P_16_bits
	
	li $v0,11
	li $a0,'\n'
	syscall

#print reverse 16 bits
	li $v0,1
	li $t0,0x0001 #0000 0000 0000 0001 mask
	li $t1, 0x8000 #the reverse mask
	li $t2,0

P_16_R_bits:
	and $a0,$s0,$t0 #$a0 mask bit
	beqz $a0,not_One
	li $a0,1
	or $t2,$t2,$t1

not_One:
	syscall
	sll $t0,$t0,1 #move left mask
	srl $t1,$t1,1
	bnez $t1,P_16_R_bits
	
	li $v0,11
	li $a0,'\n'
	syscall
	
#print decimal
	andi $a0,$t2,0x8000
	beqz $a0,positive
	lui $a0,0xffff
positive:
	or $a0,$a0,$t2
	li $v0,1
	syscall

#the end
	li $v0, 10 
	syscall
