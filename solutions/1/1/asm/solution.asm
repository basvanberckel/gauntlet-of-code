

global    _start

section   .text
_start: call load
        mov rdx, rax
        call solve
        mov rdi, rax
        call itoa_print
        call exit

solve:
    xor r10, r10 ; zero a "result"
.outer_top:
    xor r11, r11 ; zero a current elf count
.inner_top:
    call atoi_read ; rax = atoi(readline())
    test rax, rax ; end of current elf
    js .outer_break ; if rax < 0: break 2  
    jz .inner_break ; if rax == 0: break
    add r11, rax ; cur += rax
    jmp .inner_top
.inner_break: ; }
    cmp r11, r10 ; cur > result
    jle .outer_top ; if cur > prev {
    mov r10, r11 ; prev = rax
    jmp .outer_top
.outer_break:
    mov rax, r10 ; return result
    ret

atoi_read:
    xor rax, rax ; zero a "result so far"
.top:
    movzx rcx, byte [rdx] ; get a character
    test rcx, rcx ; if null-terminator
    jz .eof ; .eof
    inc rdx ; ready for next one
    cmp rcx, '0' ; between 0 and 9?
    jb .done     ; ^
    cmp rcx, '9' ; ^
    ja .done     ; ^
    sub rcx, '0' ; "convert" character to number
    imul rax, 10 ; multiply "result so far" by ten
    add rax, rcx ; add in current digit
    jmp .top ; until done
.eof:
    mov rax, -1 ; return -1
.done:
    ret

itoa_print:
    lea rsi, [rsp - 1] ; result buffer (red zone)
    mov byte [rsi], `\n` ; end with newline
    mov rax, rdi ; argument to low dividend
    mov rcx, 10 ; divisor
.top:
    xor rdx, rdx ; zero top dividend
    div rcx ; rax = rdx:rax / rcx ; rdx = rdx:rax % rcx
    add rdx, '0' ; convert to ascii
    dec rsi ; move result pointer to next char
    mov [rsi], dl ; move char to result pointer
    test rax, rax ; check if zero
    jnz .top ; repeat if not zero
    ; print right away
    mov rdx, rsp ; copy stack ptr (end of result)
    sub rdx, rsi ; number of bytes (end - result start)
    mov rax, 1 ; sys_write
    mov rdi, 1 ; fd 1 stdout
    syscall
    ret

print:  
    mov rax, 1                  ; system call for write
    mov rdx, rsi                 ; number of bytes
    mov rsi, rdi
    mov rdi, 1                  ; file handle 1 is stdout
    syscall                           ; invoke operating system to do the write
    ret

exit:  
    mov       rax, 60                 ; system call for exit
    xor       rdi, rdi                ; exit code 0
    syscall                           ; invoke operating system to exit

load:   
    mov rdi, file
    mov rsi, 0          ;O_RDONLY, man open
    mov rax, 2
    syscall

    mov [fd], rax
    mov r9, 0           ; offset
    mov r8, [fd]        ; fd
    mov r10, 1          ; MAP_PRIVATE
    mov rdx, 1          ; PROT_READ
    mov rsi, len        ; read length
    mov rdi, 0          ; addr NULL
    mov rax, 9         ;system call number (sys_mmap)
    syscall            ;call kernel

    mov r10, rax

    mov rdi, [fd]
    mov rax, 3         ;sys_close
    syscall

    mov rax, r10
    ret

section   .data
file:   db        "cases/input/2"

len:    equ 102400

fd: dq 0

section .bss

output: resb 8