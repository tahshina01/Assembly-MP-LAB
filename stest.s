AREA Initializearray, DATA, READWRITE
str dcb "AbrarEyasir",0 ; Define an array of integers with initial values set to 0
ans dcb ""
arr_length EQU 4                             ; Length of the array 

 AREA BinarySearch, CODE, READONLY
    ENTRY

    EXPORT main
 
main
    LDR r0, =str    ; Load the address of the string into r0
    LDR r2,=ans
    BL df
    B .
    
df
    PUSH {LR}
    
loop
    LDRB r1,[r0]  ; r1=r0 then r0++
    CMP r1,#0 ; Null pointer check
    BEQ finished
    
    CMP r1,#'a' ; r1<a and r1>z hoile skip
    BLT skip ; BLT = Branch if less than 
    CMP r1,#'z'
    BGT skip 
    
    SUB r1,r1,#'a' ; -97
    ADD r1,r1,#'A' ; + 65  str[i]=str[i]-32= str[i]-97+65
    
skip   
    STRB r1,[r2] 
    ADD r2,r2,#1
    ADD r0,r0,#1
    B loop
    
    
   
finished
    POP {LR}
    BX LR
    


    
    
    
    
    
    
    
    
