# Author: Henry Baker 
# Date: 10.23.21
#######################################################################
.data 								      #
	promptStr1: .asciiz "Please enter an integer: "		      #
	promptStr2: .asciiz "Please enter an operation (+,-,*,/): "   #
								      #
	returnStr1: .asciiz "Thank you.	     "			      # 
	overflowMsg: .asciiz "I'm sorry, that would overflow. "       #
	divByZero: .asciiz "I'm sorry, you cannot divide by 0. "      #
								      # 
	equalsStr: .asciiz " = "				      #
	remStr: .asciiz " r "					      #
#######################################################################	
.text
########################################################################################################################################## 
main: 
	li $v0, 4							# Print prompt String  
	la $a0, promptStr1 
	syscall 

	li $v0, 5 							# Read input int and store in input 
	syscall
	
	move $s0, $v0							# Move the input int into s0
	
	li $v0, 4							# Print prompt String  
	la $a0, promptStr2 
	syscall 

	li $v0, 12 							# Read input char and store in input 
	syscall
	
	move $s1, $v0							# Move the input char into s1
	
	li $v0, 4							# Print prompt String  
	la $a0, promptStr1 
	syscall 

	li $v0, 5 							# Read input int and store in input 
	syscall
	
	move $s2, $v0							# Move the input int into s2
	
	li $t0, '+'							# Check what sign and branch accordingly 
	beq $s1, $t0, addition
	
	li $t0, '-'
	beq $s1, $t0, subtraction					 
	
	li $t0, '*'
	beq $s1, $t0, multiplication
	
	li $t0, '/'
	beq $s1, $t0, division 		
########################################################################################################################################## 	
addition:
	
 	move $a0, $s0							# Store 2 inputs to hold onto
 	move $a1, $s2
 	
 	jal addOverflow							# Check for overflow 
 	
 	bgtz $v0, overflowMessage
 	
 	add $s3, $s0, $s2						# Add two numbers together  
 	
 	jal printMsg  							# Print output 
 	
 	j end 
##########################################################################################################################################  	
subtraction:
 	
 	move $a0, $s0							# Store 2 inputs to hold onto
 	move $a1, $s2
 	
        jal subOverflow							# Check for overflow 
 	
 	bgtz $v0, overflowMessage					# If overflow, let user know 
 	
 	sub $s3, $s0, $s2						# Sub two numbers together  
 	
 	jal printMsg 							# Print output
 	
 	j end 
##########################################################################################################################################  	
multiplication:
 	
 	move $a0, $s0							# Store 2 inputs to hold onto
 	move $a1, $s2
 	
 	jal multOverflow						# Check for overflow 
 	
 	mult $s0, $s2							# Mult two numbers together 
 	 
 	mflo $t0							# Grab answer from low 
 		
 	jal printMsg 							# Print output
 	
 	j end
##########################################################################################################################################  	
division: 
 	
 	move $a0, $s0							# Store 2 inputs to hold onto
 	move $a1, $s2
 	
 	beq $0, $s2, divByZeroMsg					# Make sure we aren't dividing by 0 
 	
 	jal divOverflow							# CHeck for overflow 
 	
 	div $s0, $s2							# Div two numbers 
 	  
 	mflo $t0							# Grab result from lo 
 	mfhi $t1							# Grab remainder from hi 
 	
 	jal printMsg							# Print output
 	
 	li $v0, 4 							# Print " r "
 	la $a0, remStr
 	syscall
 	
 	li $v0, 1							# Print remainder 
 	move $a0, $t1 
 	syscall
 	
 	j end  
##########################################################################################################################################  
addOverflow: 
	
	xor $t0, $a0, $a1						# Used code from class to check for overflow 
	bgez $t0, checkSignA
	move $v0, $0
	jr $ra 
	
	checkSignA: 
		
		addu $t0, $a0, $a1
		xor $v0, $t0, $a0 
		srl $v0, $v0, 31
		jr $ra
########################################################################################################################################## 		
subOverflow: 

	xor $t0, $a0, $a1						# Used code from class to check for overflow  
	blez $t0, checkSignS						# (slightly modified for subtraction, blez and subu)
	move $v0, $0
	jr $ra 
	
	checkSignS: 
		
		subu $t0, $a0, $a1
		xor $v0, $t0, $a0 
		srl $v0, $v0, 31
		jr $ra
########################################################################################################################################## 
multOverflow:								# Check for overflow in multiplication 

	multu $a0, $a1 							# Unsigned mult so we can't cause overflow exception
	
	mflo $t0 							# Grab hi and lo 
	mfhi $t1 
	
	sra $t0, $t0, 31						# Grab sign bit from lo 
	bne $t0, $t1, overflowMessage					# If lo's sign doesn't match all of high there was overflow
	jr $ra 								# Otherwise, return to multiply 
########################################################################################################################################## 
divOverflow:

	li $t0, -2147483648						# Load lowest possible, and the -1 for the singular case
	li $t1, -1 							
	beq $a0, $t0, checkBot						# If numerator is 0x80000000 then we will check if denom is -1
	jr $ra
	checkBot: 
		beq $a1, $t1, overflowMessage				# If this is special case we will throw error 
	jr $ra  
########################################################################################################################################## 
overflowMessage: 	

	li $v0, 4							# Print overflow String  
	la $a0, overflowMsg 
	syscall
	
	j end 
########################################################################################################################################## 	
divByZeroMsg: 

	li $v0, 4							# Print divide by 0 String  
	la $a0, divByZero 
	syscall
	
	j end
########################################################################################################################################## 	
printMsg: 
	
	li $v0, 4 							# Print return string 
 	la $a0, returnStr1
 	syscall
 						
 	li $v0, 1							# Print first int
 	move $a0, $s0
 	syscall
 	
 	li $v0, 11 							# Print operator
 	move $a0, $s1
 	syscall
 	
 	li $v0, 1							# Print second int
 	move $a0, $s2
 	syscall 
 	
 	li $v0, 4 							# Print " = "
 	la $a0, equalsStr
 	syscall
 	
 	li $v0, 1							# Print last int
 	move $a0, $t0
 	syscall
 	
 	jr $ra
########################################################################################################################################## 	
end: 	
	li $v0, 10 
	syscall	
########################################################################################################################################## 	