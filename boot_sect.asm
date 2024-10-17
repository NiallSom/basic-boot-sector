[org 0x7c00]


mov dx, 0x1FB6

mov bx, my_text
call print
call print_hex
jmp $               ; Infinite loop to halt the execution

print_hex:
    pusha
    mov cx, 4 ; for looping
    mov bx, .HEX_OUTPUT
    .next_digit:
        rol dx, 4
        mov al, dl
        and al, 0x0F ; 0000 1111
        add al, '0'
        cmp al, '9'
        jle .store
        add al, 7 ; this is if the value is more than the ascii value of 9, converts the 
    .store:
        mov [bx], al
        inc bx
        loop .next_digit ; cx defined this loop to last for 4 iterations
        mov byte [bx], 0 ; adding a null terminator at the end of the string
        mov bx, .HEX_OUTPUT ; moving my_hex into bx to be used by the print function
        call print
        popa   
        ret
    .HEX_OUTPUT:
        db '0x0000'

my_text:
    db 'Hello World', 0  ; Define the text with a null terminator

print:
    pusha
    .next_char:
        mov al, [bx]
        cmp al, 0        ; Compare the character in AL with 0 (null terminator)
        je .done         ; If null, end the function
        mov ah, 0x0e     ; BIOS teletype function for printing a character
        int 0x10         
        inc bx
        jmp .next_char
    .done:
        popa
        ret              ; Return from the function

times 510-($-$$) db 0    ; Fill the rest of the boot sector with zeros
dw 0xaa55               ; Boot sector signature
