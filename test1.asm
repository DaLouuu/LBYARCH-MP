%include "io64.inc"
section .data
var1 dq 0
section .text
global main
main:
    ;write your code here
    GET_STRING [var1], 62
    CMP qword [var1], 45
    ;A -> 65 Z-> 90 a->97 z-> 122
    
    MOV RSI, 0
    ;check if 
    JE equal
    PRINT_STRING "ITS NOT EQUAL"
    equal:
        PRINT_STRING "ITS EQUAL"
    NEWLINE
    MOV al, [var1+1]
    CMP al, 0
    JE yes
        PRINT_STRING "not 0 terminated"
        JMP end
    yes:
        PRINT_STRING "0 terminated"
        
    end:
    PRINT_CHAR [var1]
    
    PRINT_DEC 8, [var1+0]
    
    
    xor rax, rax
    ret
    
    ;get string input
    ;parse through each character by moving characters to 8 bit register one at a time; [var+index]
    ;check if in the range 65-122
    ; check if negative (dash is 45)
    ; if pasado lahat, convert back to decimal by subtracting each caharacter by 48
    