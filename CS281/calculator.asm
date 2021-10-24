.data 
	promptStr1: .asciiz "Please enter an integer: "
	promptStr2: .asciiz "Please enter an operation (+,-,*,/): "
	
	returnStr1: .asciiz "Thank you.	     "
	overflowMsg: .asciiz "I'm sorry, that would overflow. "
	divByZero: .asciiz "I'm sorry, you cannot divide by 0. "
	
	addStr: .asciiz " + "
	subStr: .asciiz " - "
	multStr: .asciiz " * "
	divStr: .asciiz " / "
	equalsStr: .asciiz " = "
	remStr: .asciiz " r "
	
	# addTest: .asciiz "We are in addition"
	# subTest: .asciiz "We are in subtraction"
	# multTest: .asciiz "We are in multiplication"
	# divTest: .asciiz "We are in division"
	
.text 
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
	
addition:
 
 	# li $v0, 4
 	# la $a0, addTest 
 	# syscall
 	
 	move $a0, $s0
 	move $a1, $s2
 	
 	jal addOverflow
 	
 	bgtz $v0, overflowMessage
 	
 	add $s3, $s0, $s2						# Add two numbers together  
 	
 	li $v0, 4 							# Print return string 
 	la $a0, returnStr1
 	syscall
 						
 	li $v0, 1							# Print first int
 	move $a0, $s0
 	syscall
 	
 	li $v0, 4 							# Print " + "
 	la $a0, addStr
 	syscall
 	
 	li $v0, 1							# Print second int
 	move $a0, $s2
 	syscall 
 	
 	li $v0, 4 							# Print " = "
 	la $a0, equalsStr
 	syscall
 	
 	li $v0, 1							# Print second int
 	move $a0, $s3
 	syscall 
 	
 	j end 
 	
subtraction:
 	
 	# li $v0, 4
 	# la $a0, subTest 
 	# syscall
 	
 	move $a0, $s0
 	move $a1, $s2
 	
        jal subOverflow
 	
 	bgtz $v0, overflowMessage
 	
 	sub $s3, $s0, $s2						# Sub two numbers together  
 	
 	li $v0, 4 							# Print return string 
 	la $a0, returnStr1
 	syscall
 						
 	li $v0, 1							# Print first int
 	move $a0, $s0
 	syscall
 	
 	li $v0, 4 							# Print " - "
 	la $a0, subStr
 	syscall
 	
 	li $v0, 1							# Print second int
 	move $a0, $s2
 	syscall 
 	
 	li $v0, 4 							# Print " = "
 	la $a0, equalsStr
 	syscall
 	
 	li $v0, 1							# Print second int
 	move $a0, $s3
 	syscall
 	
 	j end 
 	
multiplication:
	
	# li $v0, 4
 	# la $a0, multTest 
 	# syscall
 	
 	move $a0, $s0
 	move $a1, $s2
 	
 	jal multOverflow
 	
 	mult $s0, $s2							# Mult two numbers together  
 	mflo $t0
 	
 	
 	li $v0, 4 							# Print return string 
 	la $a0, returnStr1
 	syscall
 						
 	li $v0, 1							# Print first int
 	move $a0, $s0
 	syscall
 	
 	li $v0, 4 							# Print " * "
 	la $a0, multStr
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
 	
 	j end 
 	
division: 

	# li $v0, 4
 	# la $a0, divTest 
 	# syscall
 	
 	move $a0, $s0
 	move $a1, $s2
 	
 	beq $0, $s2, divByZeroMsg
 	
 	jal divOverflow
 	
 	div $s0, $s2							# Div two numbers together  
 	mflo $t0
 	mfhi $t1
 	
 	li $v0, 4 							# Print return string 
 	la $a0, returnStr1
 	syscall
 						
 	li $v0, 1							# Print first int
 	move $a0, $s0
 	syscall
 	
 	li $v0, 4 							# Print " / "
 	la $a0, divStr
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
 	
 	 	
 	li $v0, 4 							# Print " r "
 	la $a0, remStr
 	syscall
 	
 	li $v0, 1							# Print remainder 
 	move $a0, $t1 
 	syscall
 	
 	j end 
 
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
		
subOverflow: 

	xor $t0, $a0, $a1						# Used code from class to check for overflow 
	blez $t0, checkSignS
	move $v0, $0
	jr $ra 
	
	checkSignS: 
		
		subu $t0, $a0, $a1
		xor $v0, $t0, $a0 
		srl $v0, $v0, 31
		jr $ra

multOverflow:

	multu $a0, $a1 
	mflo $t0 
	mfhi $t1 
	sra $t0, $t0, 31
	bne $t0, $t1, overflowMessage
	jr $ra 

divOverflow:

	li $t0, -2147483648
	li $t1, -1 
	beq $a0, $t0, checkBot
	jr $ra
	checkBot: 
		beq $a1, $t1, overflowMessage
	j end 

overflowMessage: 	

	li $v0, 4							# Print prompt String  
	la $a0, overflowMsg 
	syscall
	
	j end 
	
divByZeroMsg: 

	li $v0, 4							# Print prompt String  
	la $a0, divByZero 
	syscall
	
	j end
	
end: 	
	li $v0, 10 
	syscall	
	