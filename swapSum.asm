.data 

Array: .word -1,-2,-3,-4,4,3,2,1
.text
.globl main

main:
	la $a0, Array
	la $a1, 8
jal swapSum

exit:
	li $v0,10
	syscall


#mission
swapSum:
	li $v0,0
	sll $t0,$a1,1
	add $t0,$t0,$a0
	srl $a1,$a1,1 #divide N by 2 
	
	
Loop:
	lw $t1,($a0)
	lw $t2,($t0)
	
	add $v0,$v0,$t1
	add $v0,$v0,$t2
	
	sw $t1,0($t0)
	sw $t2,0($a0)
	
	addiu $a0,$a0,4 #+4 cause words array
	addi $t0,$t0,4
	
	addi $a1,$a1,-1
	bnez $a1,Loop
end:
	jr $ra 