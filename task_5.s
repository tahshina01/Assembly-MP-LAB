
	
	AREA MYDATA,DATA,READWRITE

BCD_NUM equ 2_1000100110011000  ; Define a 16-bit Binary-Coded Decimal number

BINARY_NUM DCD 0				; Define a location to store the converted binary number


	AREA MYCODE, CODE, READONLY
 ENTRY
 EXPORT main

check_digit proc 				; Subroutine to convert each BCD digit to its decimal equivalent
	
	; Compare the BCD digit with each possible value from 0 to 15
	
	cmp r5, #2_0000
	itt eq
	moveq r6, #0
	beq return
	
	cmp r5, #2_0001
	itt eq
	moveq r6, #1
	beq return
	
	cmp r5, #2_0010
	itt eq
	moveq r6, #2
	beq return
	
	cmp r5, #2_0011
	itt eq
	moveq r6, #3
	beq return
	
	cmp r5, #2_0100
	itt eq
	moveq r6, #4
	beq return
	
	cmp r5, #2_0101
	itt eq
	moveq r6, #5
	beq return
	
	cmp r5, #2_0110
	itt eq
	moveq r6, #6
	beq return
	
	cmp r5, #2_0111
	itt eq
	moveq r6, #7
	beq return
	
	cmp r5, #2_1000
	itt eq
	moveq r6, #8
	beq return
	
	cmp r5, #2_1001
	itt eq
	moveq r6, #9
	beq return
	
	cmp r5, #2_1010
	itt eq
	moveq r6, #10
	beq return
	
	cmp r5, #2_1011
	itt eq
	moveq r6, #11
	beq return
	
	cmp r5, #2_1100
	itt eq
	moveq r6, #12
	beq return
	
	cmp r5, #2_1101
	itt eq
	moveq r6, #13
	beq return
	
	cmp r5, #2_1110
	itt eq
	moveq r6, #14
	beq return
	
	cmp r5, #2_1111
	itt eq
	moveq r6, #15
	beq return
	
	
	
	
return 
	blx lr
	
	endp


main
	mov r0, #BCD_NUM	; Load the address of the BCD number into r0
	ldr r10,=BINARY_NUM
	
	; Initialize loop parameters
	mov r1, #4			; Number of BCD digits to process
	mov r2, #2_1111		; Mask to extract the last 4 BCD digits
	mov r3, #0			;iteration num
	mov r4, #1			;positon of the digit in the decimal value
	mov r7, #0			;will contain the decimal value
	
;convert bcd to decimal first
loop

	; Check if all BCD digits have been processed
	cmp r3, r1
	bge out_of_loop
	
	; Extract the last BCD digit
	and r5, r0, r2
	
	; Shift the BCD number to process the next digit
	lsr r0, r0, #4
	bl check_digit
	mul r6, r6, r4
	add r7, r7, r6
	mov r5, #10			;Update the position for the next digit
	mul r4, r4 , r5		
	add r3,r3,#1
	b loop
	
	
out_of_loop
	add r7,r7, #0		; r7= decimal value of the BCD number
	
; Convert the decimal number to binary (16 bits)
	mov r1, #16			; Number of bits in the binary number
	mov r3, #0			;iteration num
	mov r2 ,#2_0001		;to fetch lsbit

loop2

; Check if all bits have been processed
	cmp r1,r3
	beq out_of_loop2
	and r4,r7, r2		; Extract the least significant bit
	lsr r7,r7, #1		
	str r4, [r10]		; Store the bit in memory
	add r3, r3, #1
	add r10 , r10, #1
	b loop2

out_of_loop2
	; the binary number is stored in memory, you might need to read it backwards though

STOP B STOP
 END
 