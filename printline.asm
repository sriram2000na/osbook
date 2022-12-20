; [org 0x7c00]
print:
    pusha
    print_top:
        mov ah,[bx]
        cmp ah,0
        je end
        mov ah,0x0e 
        mov al,[bx]
        int 0x10
        add bx, 0x0001
        jmp print_top
    end:
        popa
        ret
print_hex:
    pusha
    mov cx,0x0004
    top:
        mov ax,dx
        and ax,0x000f
        cmp ax,0x000a
        jge conv
    noconv:
        add ax, 0x0030
        mov [storage],al
        mov bx,storage
        call print
        jmp setup
    conv:
        sub ax,0x000a
        add ax,0x0041
        mov [storage],al
        mov bx,storage
        call print
    setup:
        sub cx, 1
        cmp cx,0x000
        je myreturn
        shr dx,4
        jmp top
    myreturn:
        popa
        ret
    storage:
        db 0,0
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f
[bits 32]
print_no_bios:
    pusha
    mov edx,VIDEO_MEMORY
    mov ah,WHITE_ON_BLACK
print_no_bios_begin:
    mov al,[ebx]
    cmp al,0x00
    je print_no_bios_end
    mov [edx],ax
    add ebx,1
    add edx,2
    jmp print_no_bios_begin
print_no_bios_end:
    popa
    ret
DUMMY_MESSAGE:
    db "DUMMY MAN",0
