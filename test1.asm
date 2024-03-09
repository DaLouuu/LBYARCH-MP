%include "io64.inc"
section .data
var1 dq 0
section .text
global main
main:
    ;write your code here
    GET_STRING [var1], 10
    CMP qword [var1], 65
    ;A -> 65 Z-> 90 a->97 z-> 122
    MOV RSI, 0
    ;check if 
    JE equal
    PRINT_STRING "ITS NOT EQUALL"
    equal:
        PRINT_STRING "ITS EQUALL"
        
    PRINT_DEC 8, [var1]
    DIVIDE:
        MOV r10b, [var1 + rsi]
        PRINT_DEC 1, r10b
        INC 
        
    CONVERT_DEC:
        ; rdx -> remainder/current digit; rax-> digits left
        DIV r8  
        ; update current digit and digits left
        MOV qword [currDigit], rdx
        MOV qword [remNum], rax

        ; multiplication: MUL src; RAX*src->RDX:RAX
        ; mov currDigit to rax
        MOV rax, [currDigit]    ; copy current digit to rax
        MUL rax                 ; square rax
        ADD r9, rax             ; accumulate sum in r9

        ; check if there are more digits to process
        MOV rax, [remNum]      ; Move remaining digits to rax
        CMP rax, 0             ; Check if rax is zero
        JNZ GET_SQUARE          ; If not zero, continue processing digits

        ret
    xor rax, rax
    ret
    
    ;get string input
    ;parse through each character by moving characters to 8 bit register one at a time; [var+index]
    ;check if in the range 65-122
    ; check if negative (dash is 45)
    ; if pasado lahat, convert back to decimal by subtracting each caharacter by 48
    