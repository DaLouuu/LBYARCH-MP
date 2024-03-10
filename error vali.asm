%include "io64.inc"
section .data
strVar dq 0
hasChar db 0
isNeg db 0
decVar dq 0
section .text
global main
main:
    ;write your code here
    call ACCEPT_INPUT
    xor rax, rax
    ret
    
    
;function list:
ACCEPT_INPUT:
    GET_STRING [strVar], 10 ;get string
    MOV r11b, [strVar]
    CMP r11b, 45    ;negative
    JE INVALID
    
    ;check if within 48 - 57 range
    MOV rsi, 0
    
    L1:
        MOV r11b, [strVar + rsi]
        CMP r11b, 0
        ;if zero terminate loop and convert to decimal value
        JE CONVERT
        
        call CHECK_CHAR
        CMP byte [hasChar], 1 ;check if may character na
        JE INVALID
        
        ;at this point it means ok pa to continue
        INC rsi
        JMP L1
        
    ;convert string to decimal equivalent
    CONVERT:
        call CONVERT_DEC
        NEWLINE
        PRINT_STRING "FINAL vALUE:"
        PRINT_DEC 8, [decVar]
        JMP END_INPUT_LOOP
    
    INVALID:
    PRINT_STRING "Invalid Input!"
    END_INPUT_LOOP:
    ret
;checks if character is a number from 0-9 or not
CHECK_CHAR:
    CMP r11b, 48
    JL character
    CMP r11b, 57
    JG character
    ;at this point, you are sure that its a number
    JMP end
    character:
        MOV byte [hasChar], 1
    end:
        ret
        
; converts string to decimal   
CONVERT_DEC:  
    ;convert to decimal, store in r12
    MOV rsi, 0
    MOV r8, 10  
    MOV r11, 0 
    MOV r11b, [strVar]  ;move first digit to 8 bit register 
    SUB r11, 48
    MOV qword [decVar], r11
    MOV rax, 0
    loopConvert:
        ;*10 + new digit
        MOV al, r11b                ; move digit to al  
        INC rsi                     ; increment loop counter
        MOV r11,0
        MOV r11b, [strVar + rsi]    ; move next digit to 8 bit reg
        CMP r11b, 0
        JE end_loopConvert          ; check if reach the end
        
        SUB r11b, 48
        MOV rax, qword [decVar]
        MUL r8                      ; multiply rax by 10
        ADD rax, r11                ; if not end, add digit to rax
        MOV qword [decVar], rax
        JMP loopConvert
        
        end_loopConvert:
        ret