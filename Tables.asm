#Generate 	int A[10], B[10], C[10]
#		for (i=1; i < 11; i++) 
#		{
#   		A[i] = i;
#  		B[i] = A[i] * 2;
#  		C[i] = A[i] * 4;
#		}

	#data section
	.data
	A:	.word	0 : 10	#Array A of size 10
	B:	.word	0 : 10	#Array B of size 10
	C:	.word	0 : 10	#Array C of size 10
	size:	.word	10	#size of counter
	#text section
	.text
	la	$a1, A		#load base address of A in a1
	la	$a2, B		#load base address of B in a2
	la	$a3, C		#load base address of C in a3
	la	$t3, size	#load address counter in t3
	lw 	$t3, 0($t3)	#load the value of size i.e. 10 in t3 
	addi 	$t7, $t3, 0	#tranfer the value of size from t3 to t7 
	lw	$t4, 0($a1)	#load A[0] in t4 
	lw	$t5, 0($a2)	#load B[0] in t5
	lw 	$t6, 0($a3)	#load C[0] in t6
	#loop
loop:	addi	$t4, $t4, 1	#Add 1 to t4
	sw 	$t4, 0($a1)	#Store t4 in A[i]
	sll	$t5, $t4, 1	#Multiply the value of t4 by 2 and storing it in t5
	sw	$t5, 0($a2)	#store t5 in B[i]
	sll	$t6, $t4, 2	#Multiply the value of t4 by 4 and store it in t6
	sw	$t6, 0($a3)	#store t6 in C[i]
	addi	$a1, $a1, 4	#increment i to point to A[i+1] 
	addi	$a2, $a2, 4	#increment i to point to B[i+1] 
	addi	$a3, $a3, 4	#increment i to point to C[i+1] 
	addi	$t7, $t7, -1	#decrement counter t7 by 1
	bgtz	$t7, loop	#branch to label loop if value of counter t7 is greater than 0
	#print A[]
	la   	$a0, head	# load address of print heading
      	li   	$v0, 4          # specify Print String service
      	syscall               	# print heading 
      	la	$a0, A		#load address of A[]
	add	$t2, $zero, $t3	#load the size of array in t2
	jal	print		#jump and link from label print
	#print B[]
	la   	$a0, head1      # load address of print heading
      	li   	$v0, 4          # specify Print String service
      	syscall               	# print heading
  	la	$a0, B		#load address of A[]
	jal 	print		#jump and link from label print
	#print C[]
	la   	$a0, head2      # load address of print heading
      	li   	$v0, 4          # specify Print String service
      	syscall              	# print heading
      	la 	$a0, C		#load address of A[]
	jal 	print		#jump and link from label print
	li 	$v0, 10		#system call for exit
	syscall			#exit
	
# subroutine
	#data
      	.data
space:	.asciiz  " "          	# space to insert between numbers
head: 	.asciiz  "\n A[]:"	
head1:	.asciiz  "\n B[]:"	
head2:	.asciiz  "\n C[]:"	
	#text
      	.text
print:	add  $t0, $zero, $a0  	# starting address of array
      	add  $t1, $zero, $t2  	# initialize loop counter to array size
out:  	lw   $a0, 0($t0)      	# load array for syscall
      	li   $v0, 1           	# specify Print Integer service
      	syscall               	# print elements of array
      	la   $a0, space       	# load address of spacer for syscall
      	li   $v0, 4           	# specify Print String service
      	syscall               	# output string
      	addi $t0, $t0, 4      	# increment address
      	addi $t1, $t1, -1     	# decrement loop counter
      	bgtz $t1, out         	# repeat if not finished
      	jr   $ra              	# return
