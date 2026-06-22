; If you meet compile error, try:
; sudo apt install gcc-multilib g++-multilib

%include "head.include"

your_if:
    mov eax, [a1]
    cmp eax, 12
    jge if_con2

    shr eax, 1
    inc eax
    mov [if_flag], eax
    jmp if_end

if_con2:
    cmp eax, 24
    jge if_con3

    mov ebx, eax
    neg eax
    add eax, 24
    imul eax, ebx
    mov [if_flag], eax
    jmp if_end

if_con3:
    shl eax, 4
    mov [if_flag], eax

if_end:

your_while:
while_start:
    cmp dword [a2], 12
    jl while_end

    call my_random
    mov ebx, [a2]
    sub ebx, 12
    mov esi, [while_flag]
    mov [esi + ebx], al

    dec dword [a2]
    jmp while_start

while_end:

%include "end.include"

your_function:
    pushad
    xor ebx, ebx
    mov esi, [your_string]

your_loop:
    xor eax, eax
    mov al, [esi + ebx]
    cmp al, 0
    je your_end

    push eax
    call print_a_char
    add esp, 4
    inc ebx
    jmp your_loop

your_end:
    popad
    ret
