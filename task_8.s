
;Task8    
	
	AREA MYDATA, DATA, READWRITE
    
src DCB 23,3,22,46,5,43,74,83,9   	; Source data
src_size EQU 9              	; Number of sets of data (3 bytes each)
dest DCB 0                  	; dest to store maximums
    
    AREA test, CODE, READONLY
    ENTRY
    EXPORT main           

MAXIMUM_OF_THREE
PROC                				; Procedure to find the maximum of three values
    CMP R6, R8                      ; Compare R6 and R8
    ITE GE                          ; If-Then-Else structure
    MOVGE R7, R6                    ; If R6 >= R8, set R7 to R6
    MOVLT R7, R8                    ; If R6 < R8, set R7 to R8
    CMP R7, R9                      ; Compare R7 with R9
    MOVLT R7, R9                    ; If R7 > R9, set R7 to R9
    BLX LR                          ; Return from the procedure
ENDP                                ; End of procedure

main
    LDR R0, =src             	; Load the address of the source array
    LDR R1, =dest              	; Load the address of the dest_arr
    MOV R2, #src_size           ; Number of sets of data to process
    MOV R4, #0                      ; Index for source array
    MOV R5, #0                      ; Index for dest array
    
LOOP
    CMP R4, R2                      ; Check if index is greater than or equal to size
    BGE END_LOOP            	    ; If true, exit the loop
    ADD R3, R0, R4                  ; Calculate offset in the source array
    LDRB R6, [R3]                   ; Load the first byte
    LDRB R8, [R3, #1]               ; Load the second byte
    LDRB R9, [R3, #2]               ; Load the third byte
    BL MAXIMUM_OF_THREE             ; Call the procedure to get the maximum  
    STRB R7, [R1, R5]               ; Store the result in the dest
    ADD R4, R4, #3                  ; Increment the source index by 3 as each set is 3 bytes
    ADD R5, R5, #1                  ; Increment the dest index by 1
    
    B LOOP                          ; Repeat the loop

END_LOOP
    B STOP                          ; Stop execution
    
STOP B STOP                                  
    END                                      

