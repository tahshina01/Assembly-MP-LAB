	AREA 	test, CODE,READONLY
		ENTRY
		EXPORT __main

__main
		Buffer DCD 0,0,0,0,0,0
		MOVW r0, #0x0001
		MOVW r1, #0xF
		LDR R0,[R5,R1,LSL #2]
		STR R0,[R5,R1,LSL #2]
		R0:=Buffer[R1]
		Buffer[R1]:=R0
		
		ADR R5,Buffer
		MOV R0,#0
		MOV R1,#16
	LOOP
		STR R0,[R5,R1]
		SUBS R1,R1,#4
		BPL LOOP
		
		
		
Stop 	B Stop
		END