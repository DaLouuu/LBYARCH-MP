; Dana Louise A. Guillarte - S15
%include "io64.inc" ; Assuming io64.inc defines GET_DEC and GET_CHAR correctly

section .text
global main

main:
  ; Prompt the user for input
  PRINT_STRING "Enter a positive integer: "
  NEWLINE

loop:
  ; Get user input
  GET_DEC 8, RDI  ; Assuming GET_DEC takes two arguments: register and size

  ; Check if scanf returned an error (non-numeric input)
  CMP RAX, 0  ; RAX holds the return value of GET_DEC
  JE invalid_format  ; Jump to error handling if scanf failed

  ; Check if the input is negative
  CMP RDI, 0
  JL negative  ; Jump to error handling if less than 0

  ; Input is valid, proceed with your program logic here

  xor rax, rax  ; Clear accumulator for potential return
  ret

invalid_format:
  ; Print error message for non-numeric input
  PRINT_STRING "Invalid input: Please enter a number. "
  NEWLINE

  jmp loop

negative:
  ; Print error message for negative input
  PRINT_STRING "Invalid input: Please enter a positive integer. "
  NEWLINE

  jmp loop

continuation:
  ; Prompt for user continuation
  PRINT_STRING "Do you want to continue (Y/N)? "
  NEWLINE

  ; Get user input (character)
  GET_DEC 8, RDI

  ; Check if user wants to continue
  MOV AL, BYTE [RDI]  ; Move first byte of user input to AL
  CMP AL, 'Y'  ; Compare AL with character 'Y'
  JNE exit  ; Jump to exit if not Y

  ; User wants to continue, jump back to the loop
  jmp loop

exit:
  ; Exit the program
  xor rax, rax
  ret
