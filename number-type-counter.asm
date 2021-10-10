#Dmitriy, Grushin

.data
	sentinelPrompt: .asciiz "Enter the sentinel value (may not be 0): "
	numberPrompt: 	.asciiz "\nEnter a number: " 
	posNums:		.asciiz "\nSum of positive numbers: "
	negNums:		.asciiz "\nSum of negative numbers: "
	thereWere:		.asciiz "\nThere were "
	posAmount:		.asciiz " positive numbers"
	negAmount:		.asciiz " negative numbers"
	zerosAmount:	.asciiz "\nZero(s): "
	morePosNums: 	.asciiz "\nThere were more positive numbers"
	moreNegNums: 	.asciiz "\nThere were more negative numbers"
	moreZeroNums: 	.asciiz "\nThere were more zeros"
.text

main:
# [ Initializing Values... ]
li, $t0, 0 # int sumPos 	 = 0;
li, $t1, 0 # int sumNeg 	 = 0;
li, $t2, 0 # int counterPos  = 0;
li, $t3, 0 # int counterNeg  = 0;
li, $t4, 0 # int counterZer0 = 0;

# [ cout << sentinelPrompt ]
li $v0, 4
la $a0, sentinelPrompt
syscall

# [ cin >> sentinel ]
li $v0, 5
syscall
move $t5, $v0 # [ sentinel = $t5 ]


while:
	# [ cout << numberPrompt ]
	li $v0, 4
	la $a0, numberPrompt
	syscall
	
	# [ cin >> number ]
	li $v0, 5
	syscall

	beq $v0, $t5, exit # Loop Condition while (number != sentinel) { ... }
	bgtz $v0, ifGreaterThanZero # [ sumPos += number ] && [ counterPos++ ]
	bltz $v0, ifLessThanZero	# [ sumNeg += number ] && [ counterNeg++ ]
	beqz $v0, ifEqualZero		# [ counterZero++ ]
	
	j while
exit:

# [ cout << posNums ]
li $v0, 4
la $a0, posNums
syscall
#[ cout << sumPos ]
li $v0, 1
move $a0, $t0
syscall

# [ cout << negNums ]
li $v0, 4
la $a0, negNums
syscall
#[ cout << sumNeg ]
li $v0, 1
move $a0, $t1
syscall

# [ cout << negNums ]
li $v0, 4
la $a0, thereWere
syscall
#[ cout << sumNeg ]
li $v0, 1
move $a0, $t2
syscall
li $v0, 4
la $a0, posAmount
syscall

# [ cout << negNums ]
li $v0, 4
la $a0, thereWere
syscall
# [ cout << sumNeg ]
li $v0, 1
move $a0, $t3
syscall
li $v0, 4
la $a0, negAmount
syscall

# [ cout << negNums ]
li $v0, 4
la $a0, zerosAmount
syscall
# [ cout << sumNeg ]
li $v0, 1
move $a0, $t4
syscall

bgt $t2, $t3, morePos # [ if ( t2 > t3 ) { goto: morePos } ]
bgt $t3, $t2, moreNeg # [ if ( t3 > t2 ) { goto: moreNeg } ]

ifGreaterThanZero:
	add $t0, $t0, $v0	# [ sumPos += number ]
	addi $t2, $t2, 1	# [ counterPos++     ]
	j while
	
ifLessThanZero:
	add $t1, $t1, $v0	# [ sumNeg += number ]
	addi $t3, $t3, 1 	# [ counterNeg++     ]
	j while
	
ifEqualZero:
	addi $t4, $t4, 1 # [ counterZero++ ]
	j while
	
morePos:
	bgt $t4, $t2, moreZeros # [ if ( t4 > t2 ) { goto: moreZeros } ]

	# [ cout << morePosNums ]
	li $v0, 4
	la $a0, morePosNums
	syscall

	# END
	li $v0, 10
	syscall

moreNeg:
	bgt $t4, $t3, moreZeros # [ if ( t4 > t3 ) { goto: moreZeros } ]
	
	# [ cout << moreNegNums ]
	li $v0, 4
	la $a0, moreNegNums
	syscall
	
	# END
	li $v0, 10
	syscall
	
moreZeros:
	# [ cout << moreZeroNums ]
	li $v0, 4
	la $a0, moreZeroNums
	syscall

	# END
	li $v0, 10
	syscall
	




