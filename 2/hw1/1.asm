org 0x7c00
[bits 16]
xor ax, ax
mov ds, ax
mov es, ax  
mov ss, ax
mov fs, ax
mov gs, ax
;初始化指针
mov sp 0x7c00
;显示字符串
mov ax 0xb800
mov gs,ax
mov ah, 0x01
mov al, 'H'
mov [gs:2*0],ax
