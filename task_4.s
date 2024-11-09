
;Task4

	AREA MYDATA, DATA, READWRITE
        
a DCB 0xAF, 0xDF, 0xEF, 0xCF
size EQU 4

    AREA MYCODE, CODE, READONLY
    ENTRY
    EXPORT main

main
    LDR R0, =a          ;Load base address  of arr in R0
    MOV R1, #size      ; Get the arr size
    MOV R4, #0               ; Register for sum 
    MOV R5, #0               ; Register for keeping sum of carries
    MOV R2, #0               ; Index
	
; Loop to perform addition and carry handling
LOOP
    CMP R2, R1
    BEQ OUT_OF_LOOP
    LDRB R7, [R0, R2]      ;loading one byte to R7
    ADD R4, R4, R7
    MOV R8, R4
    LSR R8, R8, #8           ; This is the carry found from the latest addition
    ADD R5, R5, R8           ; Adding the carries
    AND R4, R4, #0xFF        ; Keeping the carries out of the sum
    ADD R2, R2, #1
    
    B LOOP
    
OUT_OF_LOOP

    B STOP

STOP B STOP
    END


