; Tudor Maria-Elena 311CA

section .data

section .text
	global checkers

checkers:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; table

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE

    ; if edx == 0, then none of the two cases of lines (up or down)
    ; have been checked. It will be incremented for each one done
    ; so that after both cases are done, the execution stops (exit)
    mov edx, 0
    
    ; first I check if it is possible to make a move 
    ; downwards (on the lower line in the matrix)
    dec eax
    cmp eax, 0
    jge check_col_left
    
    ; if a move downwards is not possible, then we check
    ; for upwards (the upper line in the matrix)
    inc edx
    add ebx, 1

check_upper_line:
    ; adding 2 to get to the upper line and then checking if the position
    ; is out of the board
    add eax, 2
    dec ebx

    cmp eax, 7
    jg exit
    
    ; if the line in the matrix exists, then I check
    ; if a move left or right is possible (so the diagonal
    ; is formed)
check_col_left:
    dec ebx
    cmp ebx, 0
    jge case1

check_col_right:
    add ebx, 2
    cmp ebx, 7
    jle case2

    inc edx
    cmp edx, 1
    je check_upper_line

exit:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY

case1:
    ; using the edi register for the index in the matrix that will
    ; mark a possible position
    mov edi, eax
    imul edi, 8
    add edi, ebx

    ; putting the position on the board
    mov byte [ecx + edi], 1
    jmp check_col_right

case2:
    ; using the edi register for the index in the matrix that will
    ; mark a possible position
    mov edi, eax
    imul edi, 8
    add edi, ebx

    ; putting the position on the board
    mov byte [ecx + edi], 1

    ; checking if both line cases have been verified
    inc edx
    cmp edx, 1
    je check_upper_line
    jmp exit
