; will print a cstring using interrupt 0x10
; in:
;   si: pointer to string
printc:
    pusha
.loop:
    lodsb

    cmp al, 0x00
    je .done

    mov ah, 0x0E
    mov bx, 0x00
    int 0x10
    jmp .loop
.done:
    popa
    ret

hex.characters  db  "0123456789ABCDEF"
hex.output      db  "0000", 0
hex.input       dw  0x0000

; will print a 16 bit register using printc
; make sure to put the input in hex.input
hex16:
    mov di, hex.output
    mov ax, [hex.input]
    mov si, hex.characters
    mov cx, 4
.loop:
    rol ax, 4
    mov bx, ax
    and bx, 0x0f
    mov bl, [si + bx]
    mov [di], bl
    inc di
    dec cx
    jnz .loop

    mov si, hex.output
    call printc

    ret