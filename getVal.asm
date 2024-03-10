%include "io64.inc"
section .data
var1 dq 0
section .text
global main
main:
    ;write your code here
    GET_STRING [var1], 62
    MOV al, [var1+2]
    PRINT_DEC 1, al
    xor rax, rax
    ret