
  AREA practice, CODE, READONLY
  ENTRY
  EXPORT main
    
string DCB "bcd",0
CHAR DCB "bbbb",0

main
  LDR r0,=string
  LDR r3,=CHAR
  MOV r1,#2    ;index of first elementm
  MOV r2,#3
  MOV r4,r2, LSL #1
  MLA r7,r1,r2,r4, LSL #3
stop B stop
  END
  

