%include "io64.inc"
section .data
    inputNum dq 0
    currDigit dq 0
    remNum dq 0
    isSadNumber db 0
    continuePrompt db "Do you want to continue (Y/N)? ", 0

section .text
    global main
    main:
    ; loop for continuing or exiting
    CONTINUE_LOOP:
        ; accept integer input
        PRINT_STRING "Input Number: "
        GET_DEC 8, [inputNum]

        ; initialize values
        MOV rax, [inputNum]      ; container for remaining numbers
        MOV r8, 10          ; divisor
        MOV rdx, 0          ; remainder, current num to square
        MOV r10, 0          ; counter for loop iterations
        MOV byte [isSadNumber], 1 ; Assume it's a sad number until proven otherwise
        PRINT_STRING "Iterations: "   ; print sum in r9
        PRINT_DEC 8, [inputNum]
        ; loop
    L1:
        PRINT_STRING ","
        MOV r9, 0  ; Reset the accumulator before processing each digit
        call GET_SQUARE
        ; print the sum after every cycle/digit
        MOV rax, r9  ; Move the sum from r9 to rax for printing
        PRINT_DEC 8, rax
        ; Check if the sum equals 1
        CMP rax, 1
        JE STOP_LOOP
        ; increment loop counter
        INC r10
        ; check if loop counter exceeds 20
        CMP r10, 19
        JGE FINISH

        ; continue looping if not yet reached 20 iterations
        JMP L1

    STOP_LOOP:
        ; Check if the last sum is not 1
        CMP rax, 0
        JNE SET_SAD_NUMBER_YES

        ; If the last sum is 1, then print "Sad Number: No"
        MOV byte [isSadNumber], 1
        JMP FINISH

    SET_SAD_NUMBER_YES:
        ; Set flag to indicate it's a sad number
        MOV byte [isSadNumber], 0

    FINISH:
        NEWLINE
        ; Check if it's a sad number or not
        MOVZX rax, byte [isSadNumber]
        CMP rax, 1
        JE SAD_NUMBER_YES
        PRINT_STRING "Sad Number: No"
        JMP CONTINUE_PROMPT

    SAD_NUMBER_YES:
        PRINT_STRING "Sad Number: Yes"
        JMP CONTINUE_PROMPT

    CONTINUE_PROMPT:
        ; Print the prompt for continuing
        NEWLINE
        PRINT_STRING continuePrompt
        
        ; Read user input
        MOV rax, 0
        GET_CHAR al ; Takes in enter key
        GET_CHAR rax
        
        ; Check if the input is 'Y' or 'y'
        NEWLINE
        CMP al, 'Y'
        JE CONTINUE_LOOP
        CMP al, 'y'
        JE CONTINUE_LOOP
        CMP al, 'N'
        JE END_PROGRAM
        CMP al, 'n'
        JE END_PROGRAM
        
    END_PROGRAM:
        NEWLINE
        xor rax, rax
        ret

    GET_SQUARE:
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
