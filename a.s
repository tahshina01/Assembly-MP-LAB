		AREA 	test, CODE,READONLY
		ENTRY
		EXPORT __main

__main
		;1
		MOV r0, #0xFFFFFFFF
		MOV r1, #1
		RRX r0
		
		
		
Stop 	B Stop
		END