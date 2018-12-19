AS=nasm

build_dir:
	@echo [INFO] making build directory
	@mkdir -p build

img_dir:
	@echo [INFO] making IMG directory
	@mkdir -p img

stage1: build_dir
	@echo [AS] Assembling stage1
	@$(AS) source/stage1/main.s -I source/stage1 -f bin -o build/stage1.bin

img: img_dir stage1
	@echo [DD] Creating image file
	@dd if=/dev/zero of=build/bootable.img bs=1M count=50

	@echo [MKFS] Creating image filesystem


all: img

qemu: stage1
	qemu-system-i386 -hda build/stage1.bin