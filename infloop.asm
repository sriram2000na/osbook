[org 0x7c00]
; mov bx,HELLO_MSG
; call print
; mov bx,GOODBYE_MSG
; call print
; mov dx,0x1fb6
; call print_hex
mov bp,0x8000
mov sp,bp
mov bx,0x0000
mov es,bx
mov bx,0x9000
mov dh,5
mov dl,[BOOT_DRIVE]
call disk_read
mov dx,[0x9000]
call print_hex
mov dx,[0x9000 + 512]
call print_hex
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