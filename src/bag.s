    .section .text
    .global fill
fill:
    li a1, 1
    li a7, 278
    li s8, 0 # counter (bag offset)
generate:
    add a0, s7, s8
    ecall
    add a0, s7, s8
    lb t1, 0(a0)
    remu t3, t1, s9 # getrand() % 7
    li t2, 0 # counter (bag offset)
check_duplicate:
    beq t2, s8, store
    add t4, s7, t2
    lb t4, 0(t4)
    beq t3, t4, generate # if duplicate, try again
    addi t2, t2, 1
    j check_duplicate
store:
    sb t3, 0(a0)
    addi s8, s8, 1
    bne s8, s9, generate
    addi s8, s8, -1
    ret

    .section .data
    .global bag
bag: .skip 7
