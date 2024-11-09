	AREA test, CODE,READONLY
		ENTRY
		EXPORT __main

__main
	LDR r0, =4
	LDR r1, =5
	MUL r2, r1, r0
Stop B Stop
	END
	
		