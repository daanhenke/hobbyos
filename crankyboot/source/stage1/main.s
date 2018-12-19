bits 16
org 0

[map all build/stage1.map]

%include "memory.s"

entrypoint:
    jmp memory.stage1.segment : stage1_main                 ; far jump to update the code segment

%include "print.s"
%include "panic.s"

stage1_main:
    cli                                                     ; disable interrupts temporarily

    mov ax, cs                                              ; set most segments to our code segment
    mov ds, ax
    mov fs, ax
    mov gs, ax

    xor ax, ax                                              ; set up our temporary stack
    mov ss, ax
    mov sp, memory.stack.top

    mov es, ax                                              ; set es to 0, so we can easily get to the first 64KiB of ram

    sti                                                     ; re-enable interrupts

    mov byte [es:memory.globals.activeDrive], dl            ; save our active disk

    mov si, strings.name                                    ; print out our name
    call printc

    mov si, strings.stage                                   ; inform user we're in stage 1
    call printc

    mov si, strings.disk                                    ; inform user of active disk id
    call printc

    mov ax, [es:memory.globals.activeDrive]
    mov word [hex.input], ax
    call hex16

    mov si, strings.newline
    call printc

    call panic                                              ; panic because we have nothing to do

strings.name db "crankyboot", 0x0D, 0x0A, 0x00
strings.stage db "stage 1", 0x0D, 0x0A, 0x00
strings.disk db "active disk: ", 0x00
strings.newline db 0x0D, 0x0A, 0x00
strings.panic db "feef :(", 0x0D, 0x0A, 0x00

times 0x1fe-($-$$) db 0
signature dw 0xaa55