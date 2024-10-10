; Tudor Maria-Elena 311CA

%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
    ;; Your code starts here

    ; counter for the number of letters read from the string
    mov ebx, 0

    cmp edx, 0
    jne outer_loop_start

    ; if the number of steps is 0, then the encoded string is
    ; the original string
copy_string:
    mov al, [esi + ebx]
    mov [edi + ebx], al
    inc ebx

    cmp ebx, ecx
    jl copy_string
    
    jmp exit

    ; the first loop is for going through all of the letters of the string
    ; (it stops when the counter ebx becomes equal with the length of the 
    ; string stored in ecx)
outer_loop_start:
    
    ; accessing the character in the plain string
    mov al, [esi + ebx]

    ; the second loop is for shifting the letters until the number of steps
    ; becomes 0
loop_shift_letter:
    cmp al, 'Z'
    je restart

    add al, 1
    jmp normal

restart:
    ; if the letter is 'Z', then adding 1 is not enough for shifting
    ; so it needs to start again at letter 'A'
    mov al, 'A'

normal:
    dec edx

    cmp edx, 0
    jne loop_shift_letter

    ; after the letter has been shifted, it is copied in the encoded string
    mov [edi + ebx], al

    inc ebx
    ; reinitialising the number of steps for the next letter
    mov edx, [ebp + 20]
    
    cmp ebx, ecx
    jl outer_loop_start

exit:
    ;; Your code ends here
    
    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY

