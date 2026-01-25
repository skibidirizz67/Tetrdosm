    .section .text
    .global _start
_start:
    li a3, 0 # counter
    li a4, 10000 # max counter value
    li a5, 10 # digit count
    li a2, 5

while:
    la a1, digit
    addi t1, a1, 3 # i
    mv t2, a3 # tmp
    jal b2ds
    jal write
    addi a3, a3, 1
    beq a3, a4, exit
    jal sleep
    j while

write:
    li a0, 1
    li a7, 64
    ecall
    ret

# binary to decimal sequence
# TODO? remove trailing zeros
b2ds: 
    remu t3, t2, a5
    addi t3, t3, '0'
    sb t3, 0(t1)
    divu t2, t2, a5
    addi t1, t1, -1
    bnez t2, b2ds
    ret

    .section .data
digit: .ascii "0000\n"
