AS=nasm

build_dir:
	@echo [INFO] making build directory
	@mkdir -p build

stage1: build_dir
	@echo [AS] Assembling stage1
	@$(AS) source/stage1/main.s -I source/stage1 -f bin -o build/stage1.bin
	
all: stage1

qemu: stage1
	qemu-system-i386 -hda build/stage1.bin 