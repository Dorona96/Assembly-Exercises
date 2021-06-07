.data 
WORD: .ascii "Bad1"
msg1: .asciiz "Not a Char!\n"
msg2: .asciiz "the sum of word is: "
.text
.global main

main: 
	la $a0,WORD
	li $a1,4
	jal sum_word

exit:
	li $v0, 10 
	syscall
	
sum_word:
	move $t0, $a0
	li $t1,0 #i=0
	li $t2,0 #sum

loop:
	lb $t3, 0($t0)
	blt $t3,65, not_char
	bgt $t3,122, not_char
	ble $t3,90,capital
	bge $t3,97,lowercase
	j not_char
next:	
	addiu $t0,$t0,1
	addiu $t1,$t1,1
	bne $t1,$a1,loop
	j end
	
	
not_char:
	li $v0,4
	la $a0,msg1
	syscall
	j next

capital:
	addi $t4,$t3,-64
	add $t2,$t2,$t4
	j next

lowercase:
	addi $t4,$t3,-96
	add $t2,$t2,$t4
	j next

end:
	li $v0,4
	la $a0,msg2
	syscall
	
	li $v0,1
	move $a0,$t2
	syscall
	
	jr $ra

