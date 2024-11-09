	AREA MDATA, DATA, READWRITE
	
ARRAY DCD 5,6,7,8,9,10,11,12,13
	;5  6  7
	;8  9  10
	;11 12 13
	
R EQU 3
C EQU 3
		
		
	AREA TEST, CODE, READONLY
		ENTRY
		EXPORT main
main
	LDR r0 ,=ARRAY ;address of [0,0]
	MOV r1 ,#R ;#no of row
	MOV r2 ,#C ;#no of column

	 ;OFFSET = 4 * ROW + COL 
	 ;ACCESS ELEMENTS FROM ARRAY
	 
	 ;R7 SHOWS THE ACCESSED VALUES IN ARRAY

	MOV r3 ,#0 			;ROW INDEX 
	MOV r5 ,#0 			;COL INDEX
	MOV r4 ,#4
	MUL r4 ,r4 ,r1 			;R4 = R0W * 4
	MOV r8 ,r0   			;R8=address of [0,0]
	SUB r8 ,r8 ,r4			;R8=address of [0,0]-4
	
NEXT_ROW
	ADD r3 ,#0
	CMP r3 ,r1 				;IF ROW_COUNT>NO OF ROWS						
	BEQ EXIT 				;EXIT CODE
	ADD r8 ,r8 ,r4 			;R8=address of [ROW_COUNT,0]
	MOV r5 ,#0				;SET COL INDEX TO 0
	
TRAVERSE
	CMP r5 ,r2					;IF COL_COUNT>NO OF COLMS								
	BEQ NEXT_ROW				;GO TO NEXT ROW
	LDR r7 ,[r8 ,r5 ,LSL #2] 	;R7 =VALUE AT ARRAY [R8,R5]
	ADD r5 ,r5 ,#1				;INCREASE COL INDEX
	
	B TRAVERSE
	
	;5  6  7
	;8  9  10
	;11 12 13
	
EXIT
	
	
STOP B STOP	
	END






