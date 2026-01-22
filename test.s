    .section .text
    .global _start
_start:
    li t0, 0
    li t1, 10

while:
    jal ra, write
    jal ra, sleep
    addi t0, t0, 1
    beq t0, t1, exit
    j while

write:
    addi t2, t0, '0'
    la a1, digit
    sb t2, 0(a1)

    li a0, 1
    li a2, 1
    li a7, 64
    ecall
    ret

sleep:
    la a0, timespec
    li a1, 0
    li a7, 101
    ecall
    ret

exit:
    li a0, 0
    li a7, 93
    ecall

    .section .rodata
timespec:
    .dword 1
    .dword 0
    .section .bss
digit: .skip 1
