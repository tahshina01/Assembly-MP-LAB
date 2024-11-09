
;Task7   
	AREA MYDATA, DATA, READWRITE

SRC_DATA DCB 1,2,3,4,5,6,7,8   ; Source data array
SRC_LENGTH EQU 8                ; Length of the source array
DEST_DATA DCB 0                ; Destination array with initial value

    AREA MYCODE, CODE, READONLY
    ENTRY
    EXPORT main        ; Entry point

main
    LDR R0, =SRC_DATA           ; Load address of the source array
    LDR R1, =DEST_DATA          ; Load address of the destination array
    MOV R2, #SRC_LENGTH         ; Total number of bytes to copy
    MOV R3, #0                  ; Loop counter

COPY_LOOP
    CMP R3, R2                  ; Check if loop counter has reached the end
    BEQ END_LOOP                ; Exit loop if true
    LDRB R7, [R0, R3]            ; Load a byte from the source
    STRB R7, [R1, R3]            ; Store the byte into the destination 
    ADD R3, R3, #1              ; Increment the loop counter
    
    B COPY_LOOP                 ; Continue looping

END_LOOP
    B STOP                      ; End the program

STOP B STOP                      ; Stop execution
    END                          ; End of the assembly program
