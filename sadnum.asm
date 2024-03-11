%include "io64.inc"
section .data
    currDigit dq 0
    remNum dq 0
    isSadNumber db 1  
    continuePrompt db "Do you want to continue (Y/N)? ", 0
    strVar dq 0
    hasChar db 0
    decVar dq 0
    dummy db 0
section .text
    global main

main:
    CONTINUE_LOOP:
        NEWLINE
        JMP ACCEPT_INPUT
        INPUT_DONE:
        MOV rax, [decVar]      
        MOV r8, 10          
        MOV rdx, 0          
        MOV r10, 0          
        MOV byte [isSadNumber], 1 ; Assume it's a sad number until proven otherwise
        PRINT_STRING "Iterations: "   
        PRINT_DEC 8, [decVar]
    L1:
        PRINT_STRING ","
        MOV r9, 0  
        call GET_SQUARE
        MOV rax, r9  
        PRINT_DEC 8, rax
        CMP rax, 1
        JE STOP_LOOP_DUE_1
       
        INC r10
        CMP r10, 19 ; Corrected loop termination condition
        JE FINISH
        JMP L1

    STOP_LOOP_DUE_1: ;means that num is not a sad num
        MOV byte [isSadNumber], 0 ; Corrected flag setting
        JMP SAD_NUMBER_NO

   
    FINISH: ;means num is a sadnum
        NEWLINE
        PRINT_STRING "Sad Number: Yes"
        JMP CONTINUE_PROMPT

    SAD_NUMBER_NO:
        NEWLINE
        PRINT_STRING "Sad Number: No"
        JMP CONTINUE_PROMPT

    CONTINUE_PROMPT:
        NEWLINE
        PRINT_STRING continuePrompt
        
        GET_CHAR al
        GET_CHAR r10b
        MOV r10b, 0
        
        NEWLINE
        CMP al, 'Y'
        JE CONTINUE_LOOP
        CMP al, 'y'
        JE CONTINUE_LOOP
        CMP al, 'N'
        JE END_PROGRAM
        CMP al, 'n'
        JE END_PROGRAM
        
        JMP CONTINUE_PROMPT

    END_PROGRAM:
    NEWLINE
    
    xor rax, rax
    ret
        
    GET_SQUARE:
        DIV r8  
        MOV qword [currDigit], rdx
        MOV qword [remNum], rax

        MOV rax, [currDigit]    
        MUL rax                 
        ADD r9, rax             

        MOV rax, [remNum]      
        CMP rax, 0             
        JNZ GET_SQUARE          
        ret

    ACCEPT_INPUT:
        PRINT_STRING "Input Number: "
        GET_STRING [strVar], 10
        MOV rsi, 0
        MOV r11b, [strVar + rsi]
        CMP r11b, '-'    ; Check for negative sign
        JNE PARSE_STR   ; If not negative, proceed with parsing

        ; Handle negative input
        NEWLINE
        PRINT_STRING "Error: Negative number input"
        NEWLINE
        JMP CONTINUE_PROMPT  ; Jump to the continuation prompt

    PARSE_STR:
        MOV rsi, 0

    PARSE_LOOP:
        MOV r11b, [strVar + rsi]
        CMP r11b, 10
        JE CONVERT

        CALL CHECK_CHAR
        CMP byte [hasChar], 1
        JE INVALID_CHAR

        INC rsi
        JMP PARSE_LOOP

    CONVERT:
        CALL CONVERT_DEC
        NEWLINE
        JMP END_INPUT_LOOP

    INVALID_CHAR:
        NEWLINE
        PRINT_STRING "Error: Invalid input"
        NEWLINE
        JMP CONTINUE_PROMPT  ; Jump to the continuation prompt

    END_INPUT_LOOP:
        JMP INPUT_DONE

    CHECK_CHAR:
        CMP r11b, 48
        JL character
        CMP r11b, 57
        JG character
        MOV byte [hasChar], 0 ; Add this line to reset the flag.
        JMP end
    character:
        MOV byte [hasChar], 1
    end:
        ret

    CONVERT_DEC:  
        MOV rsi, 0
        MOV r8, 10  
        MOV r11, 0 
        MOV r11b, [strVar]  
        SUB r11, 48
        MOV qword [decVar], r11
        MOV rax, 0
    loopConvert:
        MOV al, r11b                
        INC rsi                     
        MOV r11,0
        MOV r11b, [strVar + rsi]    
        CMP r11b, 10                
        JE end_loopConvert          
            
        SUB r11b, 48
        MOV rax, qword [decVar]
        MUL r8                      
        ADD rax, r11                
        MOV qword [decVar], rax
        JMP loopConvert
            
    end_loopConvert:
        ret
