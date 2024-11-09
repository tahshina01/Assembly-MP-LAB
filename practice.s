  AREA myData, DATA
  
val1  EQU 3    ;First value 9
val2  EQU 4    ;Second value 5
arr DCD 1, 9, 5, 7, 4  ;Declaring the array
  AREA  MYCODE,  CODE
    ENTRY
    EXPORT main
      
main
   
  
  
  ;Task 1 get 1st and the last element
  LDR R5, =arr    ;putting the adress of the buffer in R5
  LDR R0, [R5,#0]  ;putting arr[0] in r0
  MOV r1, #val2  ;keeping the array size in r1
  LSL r1, r1, #2
  LDR r0, [r5,r1]  ;gettin the last element

  ;task 2 summation of the elements of the elements of an array
  LDR R5, =arr 
  MOV r0, #0
  mov r1, #0
  MOV r2, #val2
  ADD r2, #1
  LSL r2, r2, #2
loop1 
  LDR r3, [r5,r1] ;r3=arr[r1]
  add r0, r0, r3  ;r3=r0+r3
  ADD r1, r1, #4  ;r1=r1+4
  SUBS r4, r2, r1  ;r4 = r2 - r1 (check if r0 and r2 are equal)
          ;if they are equal result is zero. z flag is set
  BNE loop1    ;if flag not set then do the loop again.
  
  ;task 3 to reverse the array
  LDR R5, =arr  
  mov r1, #0
  MOV r2, #val2
  LSL r2, r2, #2
  
loop2 
  LDR r3, [r5,r1] ;r3=arr[r1]
  LDR r4, [r5,r2] ;r4=arr[r2]
  STR r4, [r5,r1] ;arr[r2]=r3
  STR r3, [r5,r2]  ;arr[r1]=r2
  
  ADD r1, r1, #4  ;r1=r1+4
  SUB r2, r2, #4  ;r2=r2-4;
  cmp r1, r2    ;compare r1<r2
  blt loop2
  mov r1, #0
  MOV r2, #val2
  ADD r2, #1
  LSL r2, r2, #2
loop 
  LDR r3, [r5,r1] ;r3=arr[r1]
  ADD r1, r1, #4  ;r1=r1+4
  SUBS r4, r2, r1  ;r4 = r2 - r1 (check if r0 and r2 are equal)
          ;if they are equal result is zero. z flag is set
  BNE loop
  
  
  
  
  ;task 4 find the largest element 
  LDR R5, =arr 
  LDR r0, [r5,#0] ;biggest element considerd as arr[0]
  mov r1, #4
  MOV r2, #val2
  ADD r2, #1
  LSL r2, r2, #2
  
loop3 
  LDR r3, [r5,r1] ;r3=arr[r1]
  cmp r3, r0; check r3>r0
  bgt mkgreater
  ADD r1, r1, #4  ;r1=r1+4
  SUBS r4, r2, r1  ;r4 = r2 - r1 (check if r0 and r2 are equal)
          ;if they are equal result is zero. z flag is set
  BNE loop3    ;if flag not set then do the loop again.
  
mkgreater
  MOV r0, r3 ;r0=r3
  b loop3    ;go back to loop2
  
  
  
STOP B STOP 
  END
