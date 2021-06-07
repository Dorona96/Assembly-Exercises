#question 4
#Author: Doron Sharaby
#Date: 19/11/2020

.data
CharStr: .asciiz "AEZKLBXWZXYALKFKWZRYLAKWLQLEK" 
ResultArray: .space 26

msg_ask:.asciiz "\n\nif you want to active one of the mission, please enter number 1-3, else enter e for exit:\n"
msg1: .asciiz "\nThe input is:\n"
msg2: .asciiz "\n\nThe Result Array is:\n"
msg3: .asciiz "\n\nThe most appeared Letter:"
msg4: .asciiz ", The number of occurrences:"
msg5: .asciiz "\n\nThe  letters by their occurrences:\n"
msg6: .asciiz "\n\nThe  new array:\n"
NewL: .asciiz "\n"

.text
.globl main
main:
	li $v0,4
	la $a0,msg1 #The input is
	syscall
	
	li $v0,4
	la $a0,CharStr #"AEZKLBXWZXYALKFKWZRYLAKWLQLEK"
	syscall
	
	
################### mission1 ######################

	li $v0,4
	la $a0,msg2 #The Result Array is:
	syscall
	
	la $a0,CharStr
	la $a1,ResultArray
	
jal char_occurrences

	move $s6,$v0 #ascii value of letter 
	move $s7,$v1 #number of letter occurrences
	
	
###### print 	The most appeared Letter
	li $v0,4
	la $a0,msg3 #The most appeared Letter
	syscall	
	
	li $v0,11   #The letter
	move $a0,$s6 
	syscall	
	
	li $v0,4
	la $a0,msg4 
	syscall	
	
	li $v0,1
	move $a0,$s7	#The number of occurrences
	syscall	



	
##################### #mission2 ################### printing the letter by their occurrences in from result array
	
	li $v0,4 
	la $a0,msg5
	syscall
	
	la $a1, ResultArray
		
jal print_Char_by_occurrences


#######################  #mission3  ################## DELETE (and mission 4 reduction)

	li $v0,4
	la $a0,msg6
	syscall
	
	la $a0,CharStr
	move $a1,$s6 #ascii letter code
	
	jal delete
	

	li $v0,4
	la $a0,CharStr
	syscall
	 
	
########################################################


ask: #working!

	li $v0,4 # new line
	la $a0,msg_ask
	syscall	
	li $v0,5
	syscall
	beq $v0,1,mission1
	beq $v0,2,mission2
	beq $v0,3,mission3

	li $v0,10 #end program
	syscall	
	
mission1:
	li $v0,4
	la $a0,msg2 #The Result Array is:
	syscall
	
	la $a0,CharStr
	la $a1,ResultArray
	
jal char_occurrences

	move $s6,$v0 #ascii value of letter 
	move $s7,$v1 #number of letter occurrences
	
	li $v0,4
	la $a0,msg3 #The most appeared Letter
	syscall	
	
	
	li $v0,11   #The letter
	move $a0,$s6
	syscall	
	
	li $v0,4
	la $a0,msg4 
	syscall	
	
	li $v0,1
	move $a0,$s7	#The number of occurrences
	syscall	

j ask


mission2:
	li $v0,4 
	la $a0,msg5
	syscall
	
	la $a1, ResultArray

jal print_Char_by_occurrences
j ask

mission3:
	li $v0,4
	la $a0,msg6
	syscall
	
	la $a0,CharStr
	move $a1,$s6 #ascii letter code
	
	jal delete
	

	li $v0,4
	la $a0,CharStr
	syscall
jal delete
j ask


#### exit program



##############################################################################################################
#mission1- Working!
###########################################################################################################
char_occurrences:
	addi $sp,$sp,-12
	sw $a0,0($sp)	#save $a0 on stack 
	sw $s0,4($sp)
	sw $s1,8($sp)
	
	
	move $t7,$a1	#pinter to ResultArray[0]
	li $t0,26	#ResultArray length
	move $t3,$a1	#pointer to ResultArray[0]
	li $t1,0	#i=0 for outer loop
	
	move $t2,$a0	#pointer to CharStr[0]
	li $t4,0	#j=0 for inner loop	
	
	li $s0,0
	li $s1,0
Outer_Loop: #outer loop iterate 0-25
	li $t6, 0	#counter
	move $t2,$a0 #pointer to CharStr

Inner_Loop: #inner loop iterate CharStr length
	lb $t5,($t2) #$t5=memory($t2)
	beqz $t5,End_IL #if we at the end of the CharStr
	addi $t5,$t5,-65 #convert ascii to index value
	bne $t1,$t5,Not_Equal 
	addiu $t6,$t6,1 #counter ++
	addiu $t2,$t2,1 #j++
		
Not_Equal: 
	addiu $t2,$t2,1 #j++
	j Inner_Loop

End_IL: #end inner loop
	sb $t6,($a1) #save counter in ResultArray
	li $v0,1	
    	move $a0,$t6
   	syscall	     #print counter
   	lw $a0,0($sp)
   	blt $s1,$t6,update # if $v1<counter we need to update $v1
   	beq $s1,$t6,update
	addiu $t1,$t1,1
	addiu $a1,$a1,1
	blt $t1,$t0,Outer_Loop	
	j end_mission1

update:	
	
   	addi $s0,$t1,65 #the ascii value of the letter
   	addi $s1,$t6,0 #the ascii value of the letter
	addiu $t1,$t1,1
	addiu $a1,$a1,1
	blt $t1,$t0,Outer_Loop	

end_mission1:
	add $v0,$s0,$zero
	add $v1,$s1,$zero
	lw $a0,0($sp)	
	lw $s0,4($sp)
	lw $s1,8($sp)
	
	addi $sp,$sp,12
	
jr $ra	

###########################################################################################################
 #mission2- Working!
###########################################################################################################
print_Char_by_occurrences:
	addi $sp,$sp,-8
	sw $s0,0($sp)
	sw $s1,4($sp)
	
	
	li $t0,26 #array length
	move $t1,$a1 
	li $t2,0 #i=0
	li $s1,0      #index for ascii letter
	li $t7,0 #the letters
	
loop1:		
	lb $t5,($t1)	#get the number of occurrences
	li $t4,0 #number of iterate loop match occurrences
	li $t6,0 #j=0
	add $t4,$t4,$t5
	bgtz $t5,occurrences_loop
	addiu $t1,$t1,1
	addiu $s1,$s1,1
	blt $s1,$t0, loop1
	
occurrences_loop:
	li $t3,65
	add $t3,$s1,$t3 #convert index to ascii letter
	li $v0,11	#print the letter 
	move $a0,$t3
	syscall
	addiu $t6,$t6,1
	blt $t6,$t4, occurrences_loop
	li $v0,4 # new line
	la $a0,NewL
	syscall
	addiu $t1,$t1,1
	addiu $s1,$s1,1
	blt $s1,$t0, loop1

	lw $s0,0($sp)
	lw $s1,4($sp)
	addi $sp,$sp,8
		
jr $ra	

	
###########################################################################################################
 #mission3- working!
###########################################################################################################
delete: 
	addi $sp,$sp,-8
	sw $ra,0($sp)	#save $ra on stack
	sw $s3,4($sp)
	
	move $s3,$a0#pointer to charstr

	move $t6,$a1 #pointer to ascii
	
	
delete_loop:
	lb $t5,($s3)
	beqz $t5,end_M3
	beq $t5,$t6,call
	addiu $s3,$s3,1
	j delete_loop
	
	
call:
jal reduction
addiu $s3,$s3,1
j delete_loop


end_M3:
	lw $ra,0($sp)
	lw $s3,4($sp)
	addi $sp,$sp,8
	jr $ra	
 


###########################################################################################################
 #mission4
###########################################################################################################
reduction: #get in $a0 address of charStr and address of letter to delete
	
	move $t2,$s3 #i=0 , pointer to charstr 
	move $t3,$s3
	addi $t3,$t3,1 #i+1
loop_R:			#move every letter one index back
	lb $t4,($t3)
	beqz $t4,end_M4
	sb $t4,($t2)
	addi $t2,$t2,1
	addi $t3,$t3,1
	j loop_R
	
end_M4:	
sb $zero,($t2)	#coping the null
jr $ra	



