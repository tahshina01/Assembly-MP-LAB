		AREA 	test, CODE,READONLY
		ENTRY
		EXPORT __main

__main
		MOVW r0, #0xFFFF
		MOVW r1, #0xFFFF
		AND	r2, r1,r0 ;AND
		MVN	r3, r2 ;NAND
		ORR	r2, r1,r0 ;OR
		MVN	r3, r2 ;NOR
		EOR	r2, r0,r1 ;XOR
		MVN r3,r2 ;XNOR
		
		MOV r0, #0x10000000
		MOV r1, #0x90000000
		AND	r2, r1,r0 ;AND
		MVN	r3, r2 ;NAND
		ORR	r2, r1,r0 ;OR
		MVN	r3, r2 ;NOR
		EOR	R2, r0,r1 ;XOR
		MVN r3,r2 ;XNOR
		
		MOV r0, #4
		MOV r1, #5
		MVN R4, R1 ;-5
		
		ADC	r2, r1,r0 ;ADD 5+4
		SUBS r2, r0,r1 ;SUB 4-5
		MOV r0, #0xffffffff
		MOV r1, #0xffffff
		MUL r2, r0,r1 ;MUL 4X5
		
		
Stop 	B Stop
		END