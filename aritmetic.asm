.data 
arr: .ascii "7-5"
msg1: .asciiz "\n result: "
msg2: .asciiz "\n invalid char! "
.text
.global main

main: 
	la $a0,arr
	li $a1,3
	jal aritmetic

aritmetic:
	li $t0,0
	li $v0,4
	la $a0, msg1
	syscall
	la $a0, arr
	syscall
	
	lb $t2,arr($t0)#first digit
	
	lb $t3,arr+1($t0)#operant
	
	lb $t4,arr+2($t0)#second digit
	
	beq $t3,'+',plus
	beq $t3,'-',minus
	j error

plus:
	add $t5, $t2,$t4
	j end
minus:
	sub $t5, $t2,$t4
	j end
	
error:
	li $v0,4
	la $a0, msg2
	syscall
	j end

end:	
	li $v0,4
	la $a0, msg2
	syscall
	li $v0,1
	move $a0, $t5
	syscall
	jr $ra
	
	