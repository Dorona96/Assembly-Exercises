.data 
Str: .asciiz "hyunDAi aNd Kia. tHe bEST sMartwatChEs"
.text 

.global main
main:
	la $a0,Str 
	jal First_Cap
	
exit:
	li $v0,10
	syscall
	
First_Cap: 
	move $t4,$a0  #pointer to Str	
	move $t0,$a0  #pointer to Str
	li $t2,0 #flag Capital
	bnez $t0, Loop #in case Str null
	j end_First_Cap
Loop:
	lb $t3,0($t0)
	beq $t3,0x0,end_First_Cap
	beq $t3,0x20,next
	beq $t3,0x2E,end_sent
	bge $t3,0x61,letterL #lowecase letter
	bge $t3,0x41, letterC #capital letter
	
next:
	addiu $t0,$t0,1
	j Loop


letterC: #check if need to change to lowercase
	beq $t2,1,lowercase
	li $t2,1
	j next

letterL:#check if need to change to capital
	beq $t2,0,capital
	j next

capital:# change to capital
	li $t2,1
	sub $t3,$t3,0x20
	sb $t3,0($t0)
	j next
	
lowercase:# change to lowercase
	addiu $t3,$t3,0x20
	sb $t3,0($t0)
	j next

end_sent:
	li $t2,0
	j next


end_First_Cap:
	li $v0,4
	move $a0, $t4
	syscall
	jr $ra
	