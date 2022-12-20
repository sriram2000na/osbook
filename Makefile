CC=gcc

all: clean bootloader compile_c 
	cat kernel.bin > boot.bin
	mv boot.bin bin
	bximage -mode=create -hd=128M -imgmode=flat -q bin/hd.img
	dd if=bin/boot.bin of=bin/hd.img conv=notrunc
	# bochs -f bochsrc.txt -q
compile_c:
	$(CC) -m32 -ffreestanding -c kernel.c -o kernel.o -fno-pie
	ld  -m elf_i386 -o kernel.bin -Ttext 0x1000 kernel_entry.o kernel.o --oformat binary
create_dirs:
	mkdir -p bin

bootloader:
	# nasm infloop.asm -f bin -o boot.bin
	nasm infloop.asm -f elf -o kernel_entry.o -O0
	# mv boot.bin bin

os-img:
	# cat bin/boot.bin bin/kernel.bin > bin/os.bin
	dd if=bin/boot.bin of=bin/hd.img bs=512 conv=notrunc

run:
	bochs -f bochsrc.txt -q

clean:
	rm -rf bin/*.bin
	rm -rf bin/*.o
	rm -rf bin/*.img
