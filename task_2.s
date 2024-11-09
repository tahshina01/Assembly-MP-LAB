;task 2
	AREA MDATA, DATA, READWRITE
	
MAT_A DCD 1,2,3,4,5,6,7,8,9 	;MATRIX A 3*3
MAT_B DCD 1,2,3,4,5,6 			;MATRIX B 3*2
MAT_C DCD 0           			;ANS MATRIX C =MAT_A X MAT_B
	
R_A EQU 3
C_A EQU 3
R_B EQU 3
C_B EQU 2
		
	AREA TEST, CODE, READONLY
		ENTRY
		EXPORT main
main
; INITIALIZE POINTERS TO MATRICES AND DIMENSIONS
	LDR r0, =MAT_A			; ADDRESS OF [0,0] OF MATRIX A
	LDR r1, =MAT_B 			; ADDRESS OF [0,0] OF MATRIX B
	mov r3,#C_A 			; #COLUMNS OF MATRIX A
	mov r4,#R_B 			; #ROWS OF MATRIX B
	mov r12, #0				; INITIALIZE R12

	
	; CHECK IF MULTIPLICATION IS APPLICABLE
	cmp r3, r4					;#C_A == #R_B
	bne not_applicable
	
	; Calling matrix multiplication subroutine
	BL matrix_multiply
stop b stop	

matrix_multiply
	; INITIALIZE POINTERS AND COUNTS
	LDR r7 , =MAT_C			; POINTER TO RESULTANT MATRIX C
	mov r2, #C_B
	lsl r11, r2, #2			;matB jumper	
	mov r10 , #0			;SUM OF THE MULTIPLICATIONS
							;ANSWER STORED
	mov r6, #0				;ROW_A COUNT
	mov r8, #0 				;COL_B COUNT
	mov r9, #0				;COMMON INDEX COUNT
	
inner_loop
	LDR r3, [r0]			;MAT_A ELEMENT
	LDR r4, [r1]			;MAT_B ELEMENT
	mul r3,r3,r4			;MAT_A X MAT_B
	add r10,r10,r3			;SUM+=MAT_A X MAT_B
	add r0,r0,#4			
	add r1,r1,r11		

	add r9, r9, #1
	
	mov r2, #C_A 			
	cmp r9, r2
	beq conditioner_inside	;GOTO NEXT COL_A
	
	b inner_loop

conditioner_inside
	mov r9, #0
	add r8, r8 ,#1
	str r10, [r7]			;STORE ANS MAT_C
	add r7, r7, #4
	mov r10, #0				;INITIALIZE SUM
	mov r2, #C_B
	cmp r8, r2
	bge conditioner_middle	;GOTO NEXT COL_B
	
	mov r2, #C_A
	lsl r2, #2
	sub r0, r0 , r2			; MOVE POINTER BACK TO START OF ROW_A
	
	mov r2, #R_B
	mul r2, r2, r11
	sub r1, r1, r2
	add r1,r1,#4			;take next columns 1st element
	
	b inner_loop

conditioner_middle
	mov r8, #0
	
	add r6, r6, #1
	mov r2, #R_A			
	
	cmp r6, r2
	bge EXIT				;TRAVERSE ENDED
	
	mov r2, #R_B
	mul r2, r2, r11
	sub r1, r1, r2
	
	mov r2, #C_B
	sub r2,r2,#1
	lsl r2, r2, #2
	sub r1, r1 , r2
	
	b inner_loop

EXIT
	bx lr				; Return from subroutine

not_applicable
	LDR r12, =0xFFFFFFFF  	; R12 == 0 MEANS MATRIX MULTIPLICATION IS APPLICABLE, OTHERWISE NOT
	b stop
	
	end
