%include "io64.inc"
section .data
var1 dq '9'
section .text
global main
main:
; dash is 45
    ;write your code here
    MOV r10b, [var1]
    PRINT_DEC 1, r10b
    '124'
    1234566
    xor rax, rax
    ret