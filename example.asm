.data 
Str: .asciiz "ANFRFEWWFREHTGTHWEYETWTTRGETHRFGRGHBGFDHRASGFNG"
Array: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.text
.globl main

main:
	addi $s1,$0,4
	addi $s0,$0,1
lp:
	sll $s0,$s0,1
	addi $s1,$s1,1
	slt $t0,$s0,$zero
	beq $t0,$zero,lp

sof:
	li $v0,1
	move $a0, $s1
	syscall
