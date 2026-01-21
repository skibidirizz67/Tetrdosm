    .section .text
    .global _start
_start:
    li a3, 0 # counter
    li a4, 10 # max value

while:
    addi a3, a3, 1 # increment counter
    addi t0, a3, '0' # convert to ascii

    li a0, 1 # stdout write
    la a1, digit
    sb t0, 0(a1)
    li a2, 1
    li a7, 64
    ecall

    la a0, timespec # nanosleep
    li a1, 0
    li a7, 101
    ecall

    beq a3, a4, exit
    j while

exit:
    li a0, 0
    li a7, 93
    ecall

    .section .data
digit: .byte 0
    .align 3
timespec:
    .dword 1
    .dword 0
