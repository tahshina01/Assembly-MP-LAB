	AREA TEST,DATA,READWRITE
ARRAY dcd 123, 2, 1, 56
SIZE equ 4

	AREA MYCODE, CODE, READONLY
 ENTRY
 EXPORT main


insertion_sort proc
	mov r2, #0					; INITIALIZE INDEX


outer_loop
	 cmp r2, r1					;IF INDEX IN FULLY TRAVERSED		
	 beq out_of_loop
	 
	 ; Initialize secondary index to current index
	 mov r4, r2 				;TRAVERSE J_INDEX BACKWARDS
 
 
LOOP
	 subs r4,r4,#1				;R4=R4-1
	 adds r6,r4,#1				;temporary index
	 cmp r4, #0
	 blt out_of_inner_loop
	 
	 ; Fetch two adjacent elements to compare
	 
	 ldr r3, [r0, r4, lsl #2]	;two adjacent elements are fetched to compare
	 ldr r5, [r0, r6, lsl #2]
	 
	 ; Compare elements and swap if out of order
	 
	 cmp r3,r5
	 itte gt
	 strgt r3, [r0, r6, lsl #2]
	 strgt r5, [r0, r4, lsl #2]	;swaps memory address if found in out of order
	 ble out_of_inner_loop
 
 b LOOP
 
out_of_inner_loop
	 adds r2,r2,#1				; INCREMENT INDEX
	 b outer_loop 
  
out_of_loop 
	 bx lr
	 endp

main 

	 ldr r0, =ARRAY					;store address of array a
	 mov r1, #SIZE			;store array size
	 
	 bl insertion_sort


STOP B STOP
 END
