	AREA test, CODE
		ENTRY
		EXPORT main
roll DCD 5,6,7,8,9,10,11,12
main

	ADR R5,roll
	MOV R11, #0
	MOV R2, #8
	MOV R0, #0 ;store first index address
	MOV R1, #7 ;store last index address
	
	LDR R3, [R5,R0,LSL #2]	;get the value at first index
	LDR R4, [R5,R1,LSL #2]	;get the value at last index
		
SUM
	CMP R0, #7	;CHECK IF INDEX REACHED THE LAST ONE
	BGT EXIT	;IF INDEX EXCCEED TO LAST ONE EXIT
	LDR R6, [R5,R0,LSL #2]	;LOAD EACH VALUE
	ADDS R11, R6, R11	;SUM THE VALUES
	ADD R0,R0,#1	;INCREASE THE INDEX
	B SUM	
EXIT
	MOV R0, #0
	MOV R2, #7
REVERSE
	CMP R0, R2
	BGE OUT
	LDR R7, [R5,R0,LSL #2]
	LDR R8, [R5,R2,LSL #2]
	STR R7, [R5,R2,LSL #2]
	STR R8, [R5,R0,LSL #2]
	LDR R9, [R5,R0,LSL #2]
	LDR R10, [R5,R2,LSL #2]
	ADD R0, R0, #1
	SUB R2, R2, #1

	B REVERSE
OUT
	MOV R0, #0
	MOV R2, #7
	LDR R7, [R5,R0,LSL #2]
	LDR R8, [R5,R2,LSL #2]

Stop B Stop
  END