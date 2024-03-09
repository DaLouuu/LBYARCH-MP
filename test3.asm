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
    ;check if 
    JE equal
    PRINT_STRING "ITS NOT EQUALL"
    equal:
        PRINT_STRING "ITS EQUALL"
        
    PRINT_DEC 8, [var1]
    xor rax, rax
    ret
    
    ;get string input
    ;parse through each character by moving characters to 8 bit register one at a time; [var+index]
    ;check if in the range 65-122
    ; check if negative (dash is 45)
    ; if pasado lahat, convert back to decimal by subtracting each caharacter by 48
    