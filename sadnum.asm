%include "io64.inc"
section .data
inputNum dq 0
currDigit dq 0
remNum dq 0
section .text
global main
main:
    mov rbp, rsp ; for correct debugging
    
    ;accept integer input
    GET_DEC 8, [inputNum]
    
    ;initialize values
    MOV rax, [inputNum] ;container for remaining numbers
    MOV r8, 10          ;divisor
    MOV r9, 0           ;accumulator
    MOV rdx, 0          ;remainder, current num to square
    
    ;if rcx is zero, jump to FINISH
    JRCXZ FINISH
    
    ;loop
    L1:
        call getSquare
    loop L1
   
   ;after sum has been accumulated:
   FINISH:
   NEWLINE
   PRINT_STRING "The sum is "   ;print sum in r9
   PRINT_DEC 8, r9
   xor rax, rax
   ret
   
getSquare:
    ;rdx -> remainder/current digit; rax-> digits left
    DIV r8  
    ;update current digit and digits left
    MOV qword [currDigit], rdx
    MOV qword [remNum], rax
    
    ;multiplication: MUL src;  RAX*src->RDX:RAX
    ;mov currDigit to rax
    MOV rax, [currDigit]    ;copy current digit to rax
    MUL rax                 ;square rax
    ADD r9, rax             ;accumulate sum in r9
    
    ;print the sum after every cycle/digit
    PRINT_DEC 8, r9
    NEWLINE
    
    ;update values of rax and rdx to prep for next cycle
    MOV rdx, 0
    MOV rax, [remNum]
    
    ;update rcx 
    MOV rcx, rax
    INC rcx         ;increnent rcx, jic rcx = 0, to avoid rcx=-1=255
    
    ret