.data
array: .byte 0x3,0x56,0x67,0xee,0x7,0xfe,0xF 

# 1 byte = 8 bits
.text
.globl main
main:

	la $a0, array
	li $a1, 7
	jal Triple_1_bit
	
print:
	li v0,4
	move $a0,$v0
	syscall
	move $a0,$v1
	syscall
		
Triple_1_bit:

	li $t2,0 #max count
	li $t6,0 #index
	li $t3,0 #counter
	move $t0,$a0 #i=0 
	li $t4,7 #mask 111
	
	
outer_loop:
	lb $t1,0($t0)
	
inner_loop:
	and $t7,$t4,$t1
	beq $t7,7,counter
	
in_next:#i++
	srl $t1,$t1,1
	beqz $t1,out_next
	
out_next: #j++
	addiu $t0,$t0,1
	bne $t0,$a1,outer_loop
	j end
	
max_counter: #update max counter
	add $t2,$0,$t3
	add $t6,$0,$t0
	j in_next
	
counter:
	addiu $t3,$t3,1
	bgt $t3,$t2,max_counter
	j in_next
	
end:
	add $v0,$0,$t3
	add $v1,$0,$t6
	jr $ra	
	
