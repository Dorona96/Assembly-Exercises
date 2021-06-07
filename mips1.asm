.data 
Str: .asciiz "ANFRFEWWFREHTGTHWEYETWTTRGETHRFGRGHBGFDHRASGFNG"
Array: .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
.text
.globl main
main:
	
	la $a1, Array
	
	li $v0,4
	la $a0,Str 
	syscall
	jal count_char
	
	li $v0,1
	li $s0,0
printn:
	la $a0,0($a1)
	syscall
	addi $a1,$a1,4
	addi $s0,$s0,1
	bne $s0, 26,printn
exit:
	li $v0, 10 
	syscall
	
count_char:
	addi $sp,$sp,-4
	sw $a0,0($sp)
	
	li $t3, 0 #counter
	li $t0,0 #i=0 array
	move $t2,$a0 #j=0 str
	j inner_loop
	
outer_loop:# 26 iteration each index represent letter A=0,B=1...etc.

	sw $t3,0($t0) #array[i]=counter
	li $v0,4
	move $a0,$a1
	syscall 
	beq $t0,25,end #i=25
	lw $t2,0($sp) #go to the beginning of Str 
	addi $t0,$t0,1 #i++
	li $t3,0 #counter=0
		
		
inner_loop:#str.length iteration

	lb $t1,0($t2)
	addi $t1,$t1,-65 
	beq $t0,$t1,increase_counter #str[j]=i
	
next:	addi $t2, $t2,1 #j++
	beq $t2,$0,outer_loop #end of Str
	j inner_loop

increase_counter:
	addi $t3,$t3,1 #counter++
	j next
	
end:
	lw $a0,0($sp)
	addi $sp,$sp,4
	li $v0,4
	la $a0,Array
	syscall
	jr $ra 
	
	


	