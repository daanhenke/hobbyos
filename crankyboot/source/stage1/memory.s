memory.stage1.address		equ	0x00007C00
memory.stage1.segment		equ memory.stage1.address >> 4

memory.stack.top			equ memory.stage1.address

struc memory.globals
	.activeDrive		resd	1
endstruc