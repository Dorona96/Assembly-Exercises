.data 
buf: .ascii "xabvfrqwertyqqqwaquu"
buf1: .space 20
msg1: .asciiz "\n The number of identical char in a row is: "

.text
.global main

main:
	jal answer
	
exit: 
	li $v0,10	
	syscall

answer:
	li $t0,0
	li $t2,0 #counter==0
	
Loop:
	lb $t3,buf($t0)
	lb $t4,buf+1($t0)
	beq $t3,$t4,equals
	bgt $t3,$t4,plus
	j minus
	
equals:
	addiu $t2,$t2, 1 #counter++
	li $t6,'='
	j update

minus:
	li $t6,'-'
	j update

plus:
	li $t6,'+'
	j update

update:
	sb $t6,buf1($t0)
	addiu $t0,$t0,1
	bne $t0,19,Loop
	j end_answer
	
end_answer:
	li $v0,4
	la $a0,buf1
	syscall
	
	la $a0,msg1
	syscall
	li $v0,1
	move $a0,$t2
	syscall
	jr $ra
