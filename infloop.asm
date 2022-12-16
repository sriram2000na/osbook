;qemu-system-i386 -drive format=raw,file="infloop.bin",index=0,if=floppy -m 128M 
[org 0x7c00]
; [bits 32]
; mov bx,HELLO_MSG
; call print
xor ax,ax
mov cs,ax
mov ax,0x0001
mov ds,ax
mov bx,GOODBYE_MSG;7c3c
; mov dx,bx
; call print_hex
call print
;----------  reading sectors from disk  --------------
; mov bp,0x8000
; mov sp,bp
; mov bx,0x0000
; mov es,bx
; mov bx,0x9000
; mov dh,5
; mov dl,[BOOT_DRIVE]
; call disk_read
; mov dx,[0x9000]
; call print_hex
; mov dx,[0x9000 + 512]
; call print_hex
;-----------------------------------------------------
; mov ebx,HELLO_MSG
; call print_no_bios
;-----------------------------------------------------
jmp $
%include "printline.asm"
%include "diskread.asm"
HELLO_MSG:
    db "Bye man",0
GOODBYE_MSG:
    db "Hello man",0
BOOT_DRIVE:
    db 0
times 510-($-$$) db 0
dw 0xaa55
times 256 dw 0xdada
times 256 dw 0xface
