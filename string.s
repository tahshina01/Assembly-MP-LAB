AREA MYDATA,DATA,READWRITE
  
a dcb "abcdef", 0
size equ 6
  
  
 AREA MYCODE,CODE,READONLY
 ENTRY
 EXPORT main


small_to_big proc
 
 cmp r2, #'a'
 blt return
 
 cmp r2, #'z'
 bgt return
 
 sub r2, r2, #32
 
 
return 
 bx lr
 endp


 
main
 
 ldr r0,=a
 mov r1, #size  
 
 
 add r2, r0,r1
 sub r2, r2,#1
 
loop
 ldrb r4, [r0]
 ldrb r5, [r2]
 
 cmp r0, r2
 bge loop_exit
 
 strb r5, [r0]
 strb r4, [r2]
 
 
 add r0, r0, #1
 sub r2, r2, #1
 
 
 b loop
 
 
 
loop_exit 
 



STOP B STOP
 END
