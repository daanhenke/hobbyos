; simple panic "handler"
panic:
	mov si, strings.panic		; print our panic message
	call printc
.loop:							; go into infinite loop
	jmp .loop