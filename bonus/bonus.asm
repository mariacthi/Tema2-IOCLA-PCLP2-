; Tudor Maria-Elena 311CA

section .data

section .text
    global bonus

bonus:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; board

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE
    
    ; x and y are stored in al and bl, so I will work with those registers
    ; for getting the position in the checkers board, then use ah and bh 
    ; for copies of them to use in calculations that alter their value

    ; if edx == 0, then none of the two cases of lines (up or down)
    ; have been checked. It will be incremented for each one done
    ; so that after both cases are done, the execution stops (exit)
    mov edx, 0
    
    ; first I check if it is possible to make a move 
    ; downwards (on the lower line in the matrix)
    dec al
    cmp al, 0
    jge check_col_left
    
    ; if a move downwards is not possible, then we check
    ; for upwards (the upper line in the matrix)
    inc edx
    add bl, 1

check_upper_line:
    ; adding 2 to get to the upper line and then checking if the position
    ; is out of the board
    add al, 2
    dec bl

    cmp al, 7
    jg exit
    
    ; if the line in the matrix exists, then I check
    ; if a move left or right is possible (so the diagonal
    ; is formed)
check_col_left:
    dec bl
    cmp bl, 0
    jl check_col_right

    call shift_position

check_col_right:
    add bl, 2
    cmp bl, 7
    jg no_shift

    call shift_position
no_shift:
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

    shift_position:
        ; when a move is possible, then this function is called
        ; to modify the board
        
        ;copying the coordinates of the new position in the high registers
        mov ah, al
        mov bh, bl

        ; getting the position that it would've been placed on if the board
        ; was a matrix
        ; ah <- ah * 8 + bh
        shl ah, 3
        add ah, bh
        
        ; pushing the registers on the stack to work with them and not modify
        ; their values
        push edx
        push ecx

        ; esi will either be 0 (for the upper board) or 4 (for the lower board)
        ; and it will be used at the ending for putting the correct value in 
        ; the upper or lower level of the board
        mov esi, 4

        ; if the position is in the lower board (first 4 lines), then esi == 4
        cmp al, 4
        jl ready

        ; if the position is in the upper board, then esi == 0 and we subtract
        ; the positions from the lower board from ah to get the position in the
        ; upper board
        mov esi, 0
        sub ah, 32
    
    ready:
        ; getting 1 in the position needed (in binary form) by shifting to
        ; the left
        mov edx, 1
        mov cl, ah
        shl edx, cl

        pop ecx
    
        or [ecx + esi], edx
        pop edx
    ret 


