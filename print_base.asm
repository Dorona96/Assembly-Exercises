.data 

Array: .word 0x1,0x0ff,0x07,0x0fffff,0x20430066
msg1: .asciiz "\n The max appirence \n"
msg2: .asciiz "\n The index of max \n"
.text
.globl main


main:

	li $a1, 255
	li $a2, 4
	jal print_base

exit:
	li $v0,10
	syscall
	
print_base:
	li $t0,0 #t0=number of digit to print
	li $v0,1 #syscall 11 print char

next_digit:
	addiu $t0,$t0,1 #digit++
	div $a1,$a2
	mfhi $t1  #Hi = $a1 mod $a2
	addiu $sp,$sp,-4
	sw $t1,0($sp)
	mflo $a1 #Lo = $a1/$a2
	bne $a1, $0, next_digit

print_digit:
	lw $a0,0($sp)
	addiu $sp,$sp,4
	syscall
	addiu $t0,$t0,-1
	bne $t0,$0,print_digit
	jr $ra
	
