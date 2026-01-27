    .section .text
    .global _start
_start:
    li a3, 0 # counter
    li a4, 1024 # max counter value
    li a5, 10 # digit count
    li a2, 2 # write len
    li s0, 8 # string len
    li s1, 6 # offset

while:
    la a1, digit
    add t1, a1, s0 # i
    addi t1, t1, -2
    add a1, a1, s1
    mv t2, a3 # tmp
    jal b2ds
    jal write
    addi a3, a3, 1
    beq a3, a4, exit
    lb t1, 0(a1)
    addi t1, t1, -'9'
    bnez t1, skip
    addi a2, a2, 1
    addi s1, s1, -1
skip:
    jal sleep
    j while

write:
    li a0, 1
    li a7, 64
    ecall
    ret

# binary to decimal sequence
b2ds: 
    remu t3, t2, a5
    addi t3, t3, '0'
    sb t3, 0(t1)
    divu t2, t2, a5
    addi t1, t1, -1
    bnez t2, b2ds
    ret

    .section .data
digit: .ascii "0000000\n"
