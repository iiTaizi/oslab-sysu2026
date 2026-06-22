[bits 16]
[org 0x7c00]

; Character projectile for an 80x25 text screen.
start:
    xor ax, ax
    mov ds, ax
    cli
    mov ss, ax
    mov sp, 0x7c00
    sti

    mov ax, 0x0003          ; 80x25 text mode, clear screen
    int 0x10

draw:
    mov dh, [row]
    mov dl, [column]
    mov ah, 0x02            ; move cursor to (DH, DL)
    xor bh, bh              ; display page 0
    int 0x10

    mov al, [character]
    mov ah, 0x09            ; write one colored character at cursor
    mov bl, [color]
    mov cx, 1
    int 0x10

    call delay

    inc byte [color]        ; cycle color through 1..15
    and byte [color], 0x0f
    jnz next_char
    inc byte [color]

next_char:
    inc byte [character]    ; cycle character through A..Z
    cmp byte [character], 'Z' + 1
    jne bounce_column
    mov byte [character], 'A'

bounce_column:
    cmp byte [column], 79
    je reverse_column
    cmp byte [column], 0
    jne bounce_row
reverse_column:
    neg byte [column_velocity]

bounce_row:
    cmp byte [row], 24
    je reverse_row
    cmp byte [row], 0
    jne move
reverse_row:
    neg byte [row_velocity]

move:
    mov al, [column_velocity]
    add [column], al
    mov al, [row_velocity]
    add [row], al
    jmp draw

delay:
    push cx
    push dx
    mov cx, 0x0002
.outer:
    xor dx, dx
.inner:
    dec dx
    jnz .inner
    loop .outer
    pop dx
    pop cx
    ret

row:             db 2
column:          db 0
row_velocity:    db 1
column_velocity: db 1
color:           db 1
character:       db 'A'

times 510 - ($ - $$) db 0
dw 0xaa55
