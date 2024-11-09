
;Task6
	
	AREA MYDATA, DATA, READWRITE
	
CPU_SPEED DCD 0x77359400  ;intel core i5 CPU 2.00 GHz clock speed	
	
	AREA MYCODE, CODE, READONLY
    ENTRY
    EXPORT main



DELAY_1SECOND 
PROC
    ; 1-second delay loop
    MOV R4, R5; Moving CPU SPEED to R4

DELAY_LOOP
    SUB R4, R4, #1
    CMP R4, #0
    BNE DELAY_LOOP
    BX LR
ENDP


main
    MOV R0, #0            ; R0 for BCD counter initialize with 0
	LDR R5,=CPU_SPEED     
	LDR R5,[R5]           ;R5 = CPU_SPEED
    
LOOP_START
    AND R1, R0, #0x0F     ; Extracting the last digit from counter R0
    CMP R1, #9            ; If the last digit is 9 Branch to add 1 to tens digit
    BEQ ADD_TENS_DIGIT
    ADD R0, R0, #1        ; Increment last digit by one
    BL DELAY_1SECOND      ; 1 sec delay
    B LOOP_START          


ADD_TENS_DIGIT
    AND R2, R0, #0xF0     ; Extracting the tens digit from R0
    LSR R2, R2, #4        ; Right shift to get the tens place value
    CMP R2, #9            ; If the tens digit is 9, stop counter
    BEQ TIMER_EXPIRED
    ADD R2, R2, #1        ; Increment the tens digit by 1
    LSL R2, R2, #4        ; Left shift to reposition it
	AND R0, R0,0x00       ;setting R0 to 0
    ORR R0, R0, R2        ; Update the tens digit in R0
    BL DELAY_1SECOND      ; Call the delay procedure
    B LOOP_START          


TIMER_EXPIRED
    B STOP
    
STOP B STOP     ; Infinite loop to stop execution
    END
