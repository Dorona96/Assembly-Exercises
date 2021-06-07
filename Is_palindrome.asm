.data 
Str1: .asciiz "AXYZWw"
Str2: .asciiz "abcdcba"

.text
.globl main
main:
	la $a1, Str1
	li $a2, 7

jal Is_palindrome
exit:
	li $v0, 10 
	syscall
	
Is_palindrome:
	li $t0,0 #i=0
	move $t6,$a1 #j=$a2
	add $t6,$t6,$a2
	li $t5,'Y'
	addi $t6,$t6,-1
	move $t1, $a1 #pointer to Str
	j Loop

Next: 
	addiu $t1,$t1,1
	addi $t6,$t6,-1	 	 
Loop:
	bgt $t1,$t6,print_res
	lb $t3,($t1)
	lb $t4,($t6)
	beq $t5,'N',print_char
	bne $t3,$t4,No

print_char:
	li $v0,11
	move $a0,$t3
	syscall
	beq $t1,$t6, print_res
	move $a0,$t4
	syscall
	j Next

No:
	li $t5, 'N'
	j print_char
	
print_res:
	li $v0,11
	move $a0,$t5
	syscall
	
	
end:
	jr $ra
