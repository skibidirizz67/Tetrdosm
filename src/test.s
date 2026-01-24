    .section .text
    .global _start
_start:
    # set gp
    .option push
    .option norelax
    lla gp, __global_pointer$
    .option pop

    # counter
    li t0, 0
    # max counter value
    li t1, 60

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
    mv t3, a1 # i
    mv t4, t0 # tmp
    li a3, 10 # b
    mv a4, ra
    jal b2ds
    mv ra, a4
    li a2, 1
    li a7, 64
    ecall

    li t2, '\n'
    sb t2, 0(a1)

    li a2, 4
    ecall

    ret

sleep:
    la a0, timespec
    li a1, 0
    li a7, 101
    ecall
    ret

# binary to decimal sequence
b2ds:
    remu t5, t4, a3
    addi t5, t5, '0'
    sb t5, 0(t3)
    divu t4, t4, a3
    addi t3, t3, 1
    bnez t4, b2ds
    ret

    .section .rodata
timespec:
    .dword 1
    .dword 0

    .section .bss
digit: .skip 4
