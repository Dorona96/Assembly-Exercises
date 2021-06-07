.data 

Array: .word 0x1,0x0ff,0x07,0x0fffff,0x20430066
msg1: .asciiz "\n The max appirence \n"
msg2: .asciiz "\n The index of max \n"
.text
.globl main

main:
	la $a0,Array
	li $a1, 5
	
jal bit_count
	add $s0,$0,$v0
	add $s1,$0,$v1
	li $v0,4
	la $a0,msg1
	syscall
	li $v0,1
	move $a0,$s0
	syscall
	li $v0,4
	la $a0,msg2
	syscall
	li $v0,1
	move $a0,$s1
	syscall

exit:
	li $v0,10
	syscall

########################	
bit_count:
	li $t1,0  #i=0
	li $t5,0
	li $t6,0 #max 1 bits counter
	li $t7,0 #index of max 1 bits counter
	move $t0, $a0
	
	
OL: #outer loop
	bgt $t5,$t6,update_max
	lw $t2,0($t0)
	li $t5,0 #1 - counter 
	
IL: #inner loop	
	and $t3,$t2,1
	beq $t3,1,update_counter
next_IL:
	srl $t2,$t2,1
	bnez $t2,IL
#next outer loop
	addiu $t0,$t0,4
	addiu $t1,$t1,1
	bne $t1,$a1,OL
	j end_bit_count
	
update_counter:
	addiu $t5,$t5,1
	j next_IL
	
update_max:
	add $t6,$0,$t5
	addi $t7,$t1,-1
	lw $t2,($t0)
	li $t5,0 #1 - counter 
	j IL
	
end_bit_count:
	add $v0,$0,$t6 #max counter
	add $v1,$0,$t7 
	jr $ra