#Leonardo Numbers Program 
.data 
	promptStr: .asciiz "Please enter a nonnegative integer: "	# Create the prompt string 
	printStr: .asciiz ", "						# String to print between each int  
	
.text 
main:
	li $v0, 4							# Print prompt String  
	la $a0, promptStr 
	syscall 
	
	li $v0, 5 							# Read input int and store in input 
	syscall
	
	move $t0, $v0							# Move the input int into t0 
	
	li $t1, 1							# Load the first 2 ints in the sequence into registers 
	li $t2, 1 
	
	bltz $t0, main 							# If input is less than zero, we will ask for a new input that is non negative
	beqz $t0, case1							# If input is 0, branch to case 1 and print the first element of the sequence
	beq  $t0, 1, case2 						# If input is 1, branch to case 2 and print the first 2 elements of the sequence
	bge  $t0, 2, case3						# If input is >= 2, branch to case 3 and run loop  
	
case1:  								# Prints only the first int if input is 0 
	li $v0, 1							# Prep to print int 
	move $a0, $t1							# Load a0 with the first int in sequence
	
	syscall								# Make sure we jump to end after this case 	
	j end 
	
case2: 									# Prints only the first two ints if input is 1
	li $v0, 1							# Prep to print int 
	move $a0, $t1							 
	syscall								# Print first int
	
	li $v0, 4 							# Prep to print string 
	la $a0, printStr
	syscall								# Print string ", "
									
	li $v0, 1							# Prep to second int 
	move $a0, $t2							 
	syscall								# Print second int
	 
	j end 								# Make sure we jump to end after this case 
	
case3:  
	li $v0, 1							# Prep to print int 
	move $a0, $t1							 
	syscall								# Print first int
	
	li $v0, 4 							# Prep to print string 
	la $a0, printStr
	syscall								# Print string ", "
									
	li $v0, 1							# Prep to second int 
	move $a0, $t2							 
	syscall
	
	li $v0, 4 							# Prep to print string 
	la $a0, printStr
	syscall								# Print string ", "
	
	subi $t0, $t0, 2
	loop:
		add  $t3, $t1, $t2					# Add t1 and t2 to get the next result
		addi $t3, $t3, 1					# Add 1 to next result 
		
		li $v0, 1						# Print new int 
		move $a0, $t3 						
		syscall
		
		move $t1, $t2						# Move our last new value into t1 and our newest value to t2 
		move $t2, $t3
		
		li $v0, 4 						# Prep to print string 
		la $a0, printStr
		syscall							# Print string ", "
		
		addi $t4, $t4, 1					# Add 1 to counter register
		slt  $t5, $t4, $t0					# Set t5 to 1 unless our counter has hit t0 
		bne  $t5, $0, loop  
	
	add  $t3, $t1, $t2						# Add t1 and t2 to get the next result
	addi $t3, $t3, 1						# Add 1 to next result 
		
	li $v0, 1							# Print new int 
	move $a0, $t3 						
	syscall	
	
	j end  	 							# Make sure that we jump to the end at the end of the case 
	
end: 	
	li $v0, 10 
	syscall	
